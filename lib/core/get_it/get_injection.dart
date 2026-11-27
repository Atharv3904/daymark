import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'package:daymark_tracking/core/config/api_config.dart';
import 'package:daymark_tracking/core/network/dio_client.dart';
import 'package:daymark_tracking/core/storage/token_storage.dart';
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
  // ---------------------------------------------------------------------------
  // Core Infrastructure & Configuration
  // ---------------------------------------------------------------------------
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
      attachToken: false, // Activated when auth contract is confirmed
    ),
  );

  // ---------------------------------------------------------------------------
  // Authentication — Data Source
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<DioClient>()),
  );

  // ---------------------------------------------------------------------------
  // Authentication — Repository
  // ---------------------------------------------------------------------------
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
      getIt<TokenStorage>(),
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
