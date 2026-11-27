import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';

class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({required this.email});

  factory ForgotPasswordRequestModel.fromParams(ForgotPasswordParams params) {
    return ForgotPasswordRequestModel(email: params.email);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'email': email};
}
