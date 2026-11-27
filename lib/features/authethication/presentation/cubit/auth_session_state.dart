import 'package:equatable/equatable.dart';

import 'package:daymark_tracking/core/errors/failures/app_failure.dart';

abstract class AuthSessionState extends Equatable {
  const AuthSessionState();

  @override
  List<Object?> get props => <Object?>[];
}

class AuthSessionInitial extends AuthSessionState {
  const AuthSessionInitial();
}

class AuthSessionChecking extends AuthSessionState {
  const AuthSessionChecking();
}

class AuthSessionAuthenticated extends AuthSessionState {
  const AuthSessionAuthenticated();
}

class AuthSessionVerificationPending extends AuthSessionState {
  const AuthSessionVerificationPending();
}

class AuthSessionUnauthenticated extends AuthSessionState {
  const AuthSessionUnauthenticated();
}

class AuthSessionFailure extends AuthSessionState {
  final AppFailure failure;

  const AuthSessionFailure(this.failure);

  @override
  List<Object?> get props => <Object?>[failure];
}
