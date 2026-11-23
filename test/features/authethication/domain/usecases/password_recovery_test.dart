import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:daymark_tracking/core/errors/failures/app_failure.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/forgot_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/entity/reset_password_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/forgot_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/reset_password_usecase.dart';

class FakeAuthRepository implements AuthRepository {
  bool shouldFail = false;
  AppFailure failure = const NetworkFailure();

  @override
  Future<Either<AppFailure, void>> register(RegistrationEntity entity) async {
    return const Right(null);
  }

  @override
  Future<Either<AppFailure, void>> login(LoginEntity entity) async {
    return const Right(null);
  }

  @override
  Future<Either<AppFailure, void>> sendPasswordResetEmail(
    ForgotPasswordEntity entity,
  ) async {
    if (shouldFail) {
      return Left(failure);
    }
    return const Right(null);
  }

  @override
  Future<Either<AppFailure, void>> resetPassword(
    ResetPasswordEntity entity,
  ) async {
    if (shouldFail) {
      return Left(failure);
    }
    return const Right(null);
  }
}

void main() {
  late FakeAuthRepository fakeRepository;
  late ForgotPasswordUseCase forgotPasswordUseCase;
  late ResetPasswordUseCase resetPasswordUseCase;

  setUp(() {
    fakeRepository = FakeAuthRepository();
    forgotPasswordUseCase = ForgotPasswordUseCase(fakeRepository);
    resetPasswordUseCase = ResetPasswordUseCase(fakeRepository);
  });

  group('ForgotPasswordUseCase', () {
    test('should return Right(null) on success', () async {
      const entity = ForgotPasswordEntity(email: 'test@example.com');
      final result = await forgotPasswordUseCase.execute(entity);

      expect(result, const Right(null));
    });

    test('should return Left(RateLimitFailure) when rate limited', () async {
      fakeRepository.shouldFail = true;
      fakeRepository.failure = const RateLimitFailure(
        message: 'Rate limit exceeded',
      );

      const entity = ForgotPasswordEntity(email: 'test@example.com');
      final result = await forgotPasswordUseCase.execute(entity);

      expect(result, isA<Left<AppFailure, void>>());
      result.fold(
        (failure) => expect(failure, isA<RateLimitFailure>()),
        (_) => fail('Should not succeed'),
      );
    });
  });

  group('ResetPasswordUseCase', () {
    test('should return Right(null) on success', () async {
      const entity = ResetPasswordEntity(newPassword: 'newValidPassword123');
      final result = await resetPasswordUseCase.execute(entity);

      expect(result, const Right(null));
    });

    test('should return Left(InvalidResetLinkFailure) when session is missing/invalid', () async {
      fakeRepository.shouldFail = true;
      fakeRepository.failure = const InvalidResetLinkFailure(
        message: 'Invalid link',
      );

      const entity = ResetPasswordEntity(newPassword: 'newValidPassword123');
      final result = await resetPasswordUseCase.execute(entity);

      expect(result, isA<Left<AppFailure, void>>());
      result.fold(
        (failure) => expect(failure, isA<InvalidResetLinkFailure>()),
        (_) => fail('Should not succeed'),
      );
    });
  });
}
