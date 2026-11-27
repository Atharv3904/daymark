import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';

class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromParams(LoginParams params) {
    return LoginRequestModel(email: params.email, password: params.password);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'email': email,
    'password': password,
  };
}
