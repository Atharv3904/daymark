import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';

class ResetPasswordRequestModel {
  final String token;
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.token,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromParams(ResetPasswordParams params) {
    return ResetPasswordRequestModel(
      token: params.token,
      newPassword: params.newPassword,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token': token,
    'new_password': newPassword,
  };
}
