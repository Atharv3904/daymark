import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/errors/exceptions/app_exception.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/data/model/auth_models.dart';
import 'package:daymark_tracking/features/authethication/data/repository/auth_repository_impl.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';

class _FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  AppException? errorToThrow;
  AuthSessionModel sessionToReturn = const AuthSessionModel(
    accessToken: 'token-abc',
    refreshToken: 'refresh-xyz',
    isEmailVerified: true,
  );
  bool signOutCalled = false;

  @override
  Future<AuthSessionModel> register(RegistrationRequestModel model) async {
    if (errorToThrow != null) throw errorToThrow!;
    return sessionToReturn;
  }

  @override
  Future<AuthSessionModel> login(LoginRequestModel model) async {
    if (errorToThrow != null) throw errorToThrow!;
    return sessionToReturn;
  }

  @override
  Future<void> sendPasswordResetEmail(ForgotPasswordRequestModel model) async {
    if (errorToThrow != null) throw errorToThrow!;
  }

  @override
  Future<void> resetPassword(ResetPasswordRequestModel model) async {
    if (errorToThrow != null) throw errorToThrow!;
  }

  @override
  Future<AuthSessionModel> verifyEmail(VerifyEmailRequestModel model) async {
    if (errorToThrow != null) throw errorToThrow!;
    return sessionToReturn;
  }

  @override
  Future<void> signOut({bool global = false}) async {
    signOutCalled = true;
    if (errorToThrow != null) throw errorToThrow!;
  }
}

class _FakeTokenStorage implements TokenStorage {
  String? accessToken;
  String? refreshToken;

  @override
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }

  @override
  Future<String?> getAccessToken() async => accessToken;

  @override
  Future<String?> getRefreshToken() async => refreshToken;

  @override
  Future<void> clearTokens() async {
    accessToken = null;
    refreshToken = null;
  }
}

void main() {
  late _FakeAuthRemoteDataSource dataSource;
  late _FakeTokenStorage tokenStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    dataSource = _FakeAuthRemoteDataSource();
    tokenStorage = _FakeTokenStorage();
    repository = AuthRepositoryImpl(dataSource, tokenStorage);
  });

  test('login persists tokens and returns authenticated session', () async {
    final Either<AppFailure, AuthSessionEntity> result = await repository.login(
      const LoginEntity(email: 'a@b.com', password: 'password123'),
    );

    expect(result.isRight(), isTrue);
    expect(tokenStorage.accessToken, 'token-abc');
    expect(tokenStorage.refreshToken, 'refresh-xyz');
  });

  test(
    'register maps AppUserAlreadyExistsException to UserAlreadyExistsFailure',
    () async {
      dataSource.errorToThrow = const AppUserAlreadyExistsException();

      final Either<AppFailure, AuthSessionEntity> result = await repository
          .register(
            const RegistrationEntity(email: 'a@b.com', password: 'password123'),
          );

      expect(result, isA<Left<AppFailure, AuthSessionEntity>>());
      result.fold(
        (failure) => expect(failure, isA<UserAlreadyExistsFailure>()),
        (_) => fail('Expected failure'),
      );
    },
  );

  test('checkSession returns unauthenticated when no token stored', () async {
    final result = await repository.checkSession();
    result.fold(
      (_) => fail('Expected Right'),
      (session) => expect(session.isAuthenticated, isFalse),
    );
  });

  test('signOut clears stored tokens', () async {
    tokenStorage.accessToken = 'token-abc';
    final result = await repository.signOut();

    expect(result, const Right<AppFailure, void>(null));
    expect(tokenStorage.accessToken, isNull);
    expect(dataSource.signOutCalled, isFalse);
  });
}
