import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daymark_tracking/features/authethication/domain/entity/auth_session_entity.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/check_session_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/sign_out_usecase.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_state.dart';

/// Manages global authentication session lifecycle (Splash check, authenticated,
/// verification-pending, unauthenticated, and sign-out).
class AuthSessionCubit extends Cubit<AuthSessionState> {
  final CheckSessionUseCase _checkSessionUseCase;
  final SignOutUseCase _signOutUseCase;

  AuthSessionCubit(this._checkSessionUseCase, this._signOutUseCase)
    : super(const AuthSessionInitial());

  Future<void> checkSession() async {
    emit(const AuthSessionChecking());
    final result = await _checkSessionUseCase.execute();
    result.fold((_) => emit(const AuthSessionUnauthenticated()), applySession);
  }

  void applySession(AuthSessionEntity session) {
    if (session.isAuthenticated) {
      emit(const AuthSessionAuthenticated());
    } else if (!session.isEmailVerified) {
      emit(const AuthSessionUnauthenticated());
    } else {
      emit(const AuthSessionUnauthenticated());
    }
  }

  void markVerificationPending() {
    emit(const AuthSessionVerificationPending());
  }

  void markAuthenticated() {
    emit(const AuthSessionAuthenticated());
  }

  Future<void> signOut({bool global = false}) async {
    emit(const AuthSessionChecking());
    final result = await _signOutUseCase.execute(global: global);
    result.fold(
      (failure) => emit(AuthSessionFailure(failure)),
      (_) => emit(const AuthSessionUnauthenticated()),
    );
  }
}
