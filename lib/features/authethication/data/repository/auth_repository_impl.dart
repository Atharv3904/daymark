import 'package:dartz/dartz.dart';

import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/data/model/auth_models.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;
  final TokenStorage _tokenStorage;

  AuthRepositoryImpl(this._dataSource, this._tokenStorage);

  @override
  Future<Either<AppFailure, AuthSessionEntity>> register(
    RegistrationEntity entity,
  ) async {
    try {
      final AuthSessionModel result = await _dataSource.register(
        RegistrationRequestModel.fromEntity(entity),
      );
      await _persistTokensIfPresent(result);
      // TODO: Trigger Profile initialization per `profile/spec.md` once
      // backend registration/profile boundary is confirmed.
      return Right(result.toEntity());
    } on AppException catch (e) {
      return Left(_mapExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<AppFailure, AuthSessionEntity>> login(
    LoginEntity entity,
  ) async {
    try {
      final AuthSessionModel result = await _dataSource.login(
        LoginRequestModel.fromEntity(entity),
      );
      await _persistTokensIfPresent(result);
      return Right(result.toEntity());
    } on AppException catch (e) {
      return Left(_mapExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity entity,
  ) async {
    try {
      await _dataSource.sendPasswordResetEmail(
        ForgotPasswordRequestModel.fromEntity(entity),
      );
      return const Right(null);
    } on AppException catch (e) {
      return Left(_mapExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<AppFailure, void>> resetPassword(
    ResetPasswordEntity entity,
  ) async {
    try {
      await _dataSource.resetPassword(
        ResetPasswordRequestModel.fromEntity(entity),
      );
      return const Right(null);
    } on AppException catch (e) {
      if (e is AppInvalidCredentialsException ||
          e is UnauthorizedException ||
          e is ForbiddenException) {
        return const Left(InvalidResetLinkFailure());
      }
      return Left(_mapExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<AppFailure, AuthSessionEntity>> verifyEmail(
    VerifyEmailEntity entity,
  ) async {
    try {
      final AuthSessionModel result = await _dataSource.verifyEmail(
        VerifyEmailRequestModel.fromEntity(entity),
      );
      await _persistTokensIfPresent(result);
      return Right(result.toEntity());
    } on AppException catch (e) {
      return Left(_mapExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<AppFailure, AuthSessionEntity>> checkSession() async {
    try {
      final String? token = await _tokenStorage.getAccessToken();
      if (token == null || token.isEmpty) {
        return const Right(
          AuthSessionEntity(isAuthenticated: false, isEmailVerified: false),
        );
      }
      // TODO: Validate stored session against FastAPI `/me` or `/refresh`
      // endpoint once backend session contract is confirmed.
      return const Right(
        AuthSessionEntity(isAuthenticated: true, isEmailVerified: true),
      );
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  @override
  Future<Either<AppFailure, void>> signOut({bool global = false}) async {
    try {
      if (global) {
        await _dataSource.signOut(global: true);
      }
      await _tokenStorage.clearTokens();
      return const Right(null);
    } on AppException catch (e) {
      await _tokenStorage.clearTokens();
      return Left(_mapExceptionToFailure(e));
    } catch (_) {
      return const Left(UnknownAuthFailure());
    }
  }

  Future<void> _persistTokensIfPresent(AuthSessionModel model) async {
    final String? token = model.accessToken;
    if (token != null && token.isNotEmpty) {
      await _tokenStorage.saveTokens(
        accessToken: token,
        refreshToken: model.refreshToken,
      );
    }
  }

  AppFailure _mapExceptionToFailure(AppException e) {
    if (e is AppUserAlreadyExistsException) {
      return UserAlreadyExistsFailure(e.message);
    }
    if (e is AppWeakPasswordException) {
      return WeakPasswordFailure(e.message);
    }
    if (e is AppInvalidCredentialsException) {
      return InvalidCredentialsFailure(e.message);
    }
    if (e is AppEmailNotVerifiedException) {
      return EmailNotVerifiedFailure(e.message);
    }
    if (e is AppEmailVerificationPendingException) {
      return EmailVerificationPendingFailure(e.message);
    }
    if (e is AppSessionExpiredException) {
      return SessionExpiredFailure(e.message);
    }
    if (e is AppRefreshTokenRevokedException) {
      return RefreshTokenRevokedFailure(e.message);
    }
    if (e is AppNetworkException || e is NetworkException) {
      return const NetworkFailure();
    }
    if (e is RateLimitException) {
      return const RateLimitFailure();
    }
    if (e is ServerException) {
      return const ServerFailure();
    }
    return const UnknownAuthFailure();
  }
}
