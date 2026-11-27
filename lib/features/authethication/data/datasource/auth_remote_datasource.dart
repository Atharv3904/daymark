import 'package:daymark_tracking/features/authethication/data/model/auth_models.dart';

/// Abstract contract for authentication REST API calls.
abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> register(RegistrationRequestModel model);
  Future<AuthSessionModel> login(LoginRequestModel model);
  Future<void> sendPasswordResetEmail(ForgotPasswordRequestModel model);
  Future<void> resetPassword(ResetPasswordRequestModel model);
  Future<AuthSessionModel> verifyEmail(VerifyEmailRequestModel model);
  Future<void> signOut({bool global = false});
}
