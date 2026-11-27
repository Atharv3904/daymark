import 'package:daymark_tracking/features/authethication/domain/entity/auth_entities.dart';

class RegistrationRequestModel {
  final String email;
  final String password;

  const RegistrationRequestModel({required this.email, required this.password});

  factory RegistrationRequestModel.fromEntity(RegistrationEntity entity) {
    return RegistrationRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'email': email,
    'password': password,
  };
}

class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({required this.email, required this.password});

  factory LoginRequestModel.fromEntity(LoginEntity entity) {
    return LoginRequestModel(email: entity.email, password: entity.password);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'email': email,
    'password': password,
  };
}

class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({required this.email});

  factory ForgotPasswordRequestModel.fromEntity(ForgotPasswordEntity entity) {
    return ForgotPasswordRequestModel(email: entity.email);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'email': email};
}

class ResetPasswordRequestModel {
  final String token;
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.token,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromEntity(ResetPasswordEntity entity) {
    return ResetPasswordRequestModel(
      token: entity.token,
      newPassword: entity.newPassword,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'token': token,
    'new_password': newPassword,
  };
}

class VerifyEmailRequestModel {
  final String token;

  const VerifyEmailRequestModel({required this.token});

  factory VerifyEmailRequestModel.fromEntity(VerifyEmailEntity entity) {
    return VerifyEmailRequestModel(token: entity.token);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'token': token};
}

/// Contract-ready session response DTO.
/// TODO: Confirm exact token/verification JSON keys with FastAPI backend docs.
class AuthSessionModel {
  final String? accessToken;
  final String? refreshToken;
  final bool isEmailVerified;

  const AuthSessionModel({
    this.accessToken,
    this.refreshToken,
    this.isEmailVerified = false,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      isEmailVerified:
          (json['email_verified'] as bool?) ??
          (json['access_token'] is String &&
              (json['access_token'] as String).isNotEmpty),
    );
  }

  AuthSessionEntity toEntity() {
    final bool hasToken = accessToken != null && accessToken!.isNotEmpty;
    return AuthSessionEntity(
      isAuthenticated: hasToken && isEmailVerified,
      isEmailVerified: isEmailVerified,
    );
  }
}
