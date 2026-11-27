import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:daymark_tracking/core/config/api_config.dart';
import 'package:daymark_tracking/core/network/dio_client.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource.dart';
import 'package:daymark_tracking/features/authethication/data/datasource/auth_remote_datasource_impl.dart';
import 'package:daymark_tracking/features/authethication/data/repository/auth_repository_impl.dart';
import 'package:daymark_tracking/features/authethication/domain/repository/auth_repository.dart';
import 'package:daymark_tracking/features/authethication/domain/usecases/auth_usecases.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_form_cubit.dart';
import 'package:daymark_tracking/features/authethication/presentation/cubit/auth_session_cubit.dart';

final GetIt getIt = GetIt.instance;

void setupInjection() {
  // Core
  getIt.registerLazySingleton<ApiConfig>(() => ApiConfig.fromEnvironment());

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );

  getIt.registerLazySingleton<TokenStorage>(
    () => SecureTokenStorageImpl(getIt<FlutterSecureStorage>()),
  );

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      config: getIt<ApiConfig>(),
      tokenStorage: getIt<TokenStorage>(),
      attachToken: false, // Activated when FastAPI token contract is confirmed
    ),
  );

  // Auth Data
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<DioClient>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<TokenStorage>(),
    ),
  );

  // Auth Use Cases
  getIt.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
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
  getIt.registerFactory<VerifyEmailUseCase>(
    () => VerifyEmailUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<CheckSessionUseCase>(
    () => CheckSessionUseCase(getIt<AuthRepository>()),
  );
  getIt.registerFactory<SignOutUseCase>(
    () => SignOutUseCase(getIt<AuthRepository>()),
  );

  // Auth Cubits
  getIt.registerLazySingleton<AuthSessionCubit>(
    () =>
        AuthSessionCubit(getIt<CheckSessionUseCase>(), getIt<SignOutUseCase>()),
  );

  getIt.registerFactory<AuthFormCubit>(
    () => AuthFormCubit(
      getIt<RegisterUseCase>(),
      getIt<LoginUseCase>(),
      getIt<ForgotPasswordUseCase>(),
      getIt<ResetPasswordUseCase>(),
      getIt<VerifyEmailUseCase>(),
    ),
  );
}
