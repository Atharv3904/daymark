import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource_impl.dart';
import 'package:daymark_tracking/features/authethication/data/repository/auth_repository_impl.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/registration_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/login_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/forgot_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/reset_password_usecase.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupInjection() {
  if (getIt.isRegistered<SupabaseClient>()) {
    return;
  }

  // ---------------------------------------------------------------------------
  // External
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // ---------------------------------------------------------------------------
  // Authentication — Data Source
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<SupabaseClient>()),
  );

  // ---------------------------------------------------------------------------
  // Authentication — Repository
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<SupabaseClient>(),
    ),
  );

  // ---------------------------------------------------------------------------
  // Authentication — Use Cases
  // ---------------------------------------------------------------------------
  getIt.registerFactory<RegistrationUseCase>(
    () => RegistrationUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(getIt<AuthRepository>()),
  );

  // ---------------------------------------------------------------------------
  // Authentication — Cubit
  // ---------------------------------------------------------------------------
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(
      getIt<RegistrationUseCase>(),
      getIt<LoginUseCase>(),
      getIt<ForgotPasswordUseCase>(),
      getIt<ResetPasswordUseCase>(),
    ),
  );
}
