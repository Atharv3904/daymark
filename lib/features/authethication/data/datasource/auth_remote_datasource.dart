import 'package:daymark_tracking/features/authethication/data/model/auth_session_model.dart';
import 'package:daymark_tracking/features/authethication/data/model/forgot_password_request_model.dart';
import 'package:daymark_tracking/features/authethication/data/model/login_request_model.dart';
import 'package:daymark_tracking/features/authethication/data/model/registration_request_model.dart';
import 'package:daymark_tracking/features/authethication/data/model/reset_password_request_model.dart';
import 'package:daymark_tracking/features/authethication/data/model/verify_email_request_model.dart';

/// Abstract contract for authentication REST API calls.
abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> register(RegistrationRequestModel model);
  Future<AuthSessionModel> login(LoginRequestModel model);
  Future<void> sendPasswordResetEmail(ForgotPasswordRequestModel model);
  Future<void> resetPassword(ResetPasswordRequestModel model);
  Future<AuthSessionModel> verifyEmail(VerifyEmailRequestModel model);
  Future<void> signOut({bool global = false});
}
