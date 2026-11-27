import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

/// Centralized API and environment configuration.
///
/// Uses `--dart-define` for runtime configuration with safe environment-aware defaults.
class ApiConfig {
  final String baseUrl;
  final int connectTimeoutMs;
  final int receiveTimeoutMs;
  final int sendTimeoutMs;

  const ApiConfig({
    required this.baseUrl,
    this.connectTimeoutMs = 15000,
    this.receiveTimeoutMs = 15000,
    this.sendTimeoutMs = 15000,
  });

  /// Factory that loads configuration from compile-time `--dart-define` environment flags.
  ///
  /// If `API_BASE_URL` is omitted, resolves local development host appropriately:
  /// - Android emulator: `http://10.0.2.2:8000`
  /// - iOS Simulator / macOS / Desktop: `http://localhost:8000`
  /// - Web: `http://localhost:8000`
  factory ApiConfig.fromEnvironment() {
    const String envBaseUrl = String.fromEnvironment('API_BASE_URL');
    const int envConnectTimeout = int.fromEnvironment(
      'CONNECT_TIMEOUT_MS',
      defaultValue: 15000,
    );
    const int envReceiveTimeout = int.fromEnvironment(
      'RECEIVE_TIMEOUT_MS',
      defaultValue: 15000,
    );
    const int envSendTimeout = int.fromEnvironment(
      'SEND_TIMEOUT_MS',
      defaultValue: 15000,
    );

    String resolvedBaseUrl = envBaseUrl.trim();
    if (resolvedBaseUrl.isEmpty) {
      if (!kIsWeb && Platform.isAndroid) {
        resolvedBaseUrl = 'http://10.0.2.2:8000';
      } else {
        resolvedBaseUrl = 'http://localhost:8000';
      }
    }

    return ApiConfig(
      baseUrl: resolvedBaseUrl,
      connectTimeoutMs: envConnectTimeout,
      receiveTimeoutMs: envReceiveTimeout,
      sendTimeoutMs: envSendTimeout,
    );
  }
}
