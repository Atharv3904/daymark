import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/core/config/api_config.dart';

void main() {
  group('ApiConfig', () {
    test('uses expected default timeouts and explicit baseUrl', () {
      const ApiConfig config = ApiConfig(baseUrl: 'http://localhost:8000');

      expect(config.baseUrl, 'http://localhost:8000');
      expect(config.connectTimeoutMs, 15000);
      expect(config.receiveTimeoutMs, 15000);
      expect(config.sendTimeoutMs, 15000);
    });

    test('fromEnvironment resolves non-empty baseUrl', () {
      final ApiConfig config = ApiConfig.fromEnvironment();
      expect(config.baseUrl, isNotEmpty);
    });
  });
}
