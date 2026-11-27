import 'package:daymark_tracking/features/authethication/domain/entity/auth_session_entity.dart';

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
