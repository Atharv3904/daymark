import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// Centralized API configuration loaded from `--dart-define` flags
/// with platform-aware local development defaults.
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
      resolvedBaseUrl = (!kIsWeb && Platform.isAndroid)
          ? 'http://10.0.2.2:8000'
          : 'http://localhost:8000';
    }

    return ApiConfig(
      baseUrl: resolvedBaseUrl,
      connectTimeoutMs: envConnectTimeout,
      receiveTimeoutMs: envReceiveTimeout,
      sendTimeoutMs: envSendTimeout,
    );
  }
}
