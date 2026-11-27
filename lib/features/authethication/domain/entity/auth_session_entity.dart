import 'package:equatable/equatable.dart';

/// Domain entity representing the authenticated user session state.
class AuthSessionEntity extends Equatable {
  final bool isAuthenticated;
  final bool isEmailVerified;

  const AuthSessionEntity({
    required this.isAuthenticated,
    required this.isEmailVerified,
  });

  @override
  List<Object?> get props => <Object?>[isAuthenticated, isEmailVerified];
}
