import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';

class RegistrationRequestModel {
  final String email;
  final String password;

  const RegistrationRequestModel({required this.email, required this.password});

  factory RegistrationRequestModel.fromParams(RegisterParams params) {
    return RegistrationRequestModel(
      email: params.email,
      password: params.password,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'email': email,
    'password': password,
  };
}
