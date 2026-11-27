import 'package:daymark_tracking/features/authethication/domain/params/auth_params.dart';

class VerifyEmailRequestModel {
  final String token;

  const VerifyEmailRequestModel({required this.token});

  factory VerifyEmailRequestModel.fromParams(VerifyEmailParams params) {
    return VerifyEmailRequestModel(token: params.token);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'token': token};
}
