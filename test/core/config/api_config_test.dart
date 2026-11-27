import 'package:flutter_test/flutter_test.dart';
import 'package:daymark_tracking/core/config/api_config.dart';

void main() {
  group('ApiConfig Tests', () {
    test('ApiConfig has valid default properties', () {
      const config = ApiConfig(baseUrl: 'http://localhost:8000');
      expect(config.baseUrl, 'http://localhost:8000');
      expect(config.connectTimeoutMs, 15000);
      expect(config.receiveTimeoutMs, 15000);
      expect(config.sendTimeoutMs, 15000);
    });

    test('ApiConfig.fromEnvironment returns non-empty baseUrl and valid timeouts', () {
      final config = ApiConfig.fromEnvironment();
      expect(config.baseUrl.isNotEmpty, isTrue);
      expect(config.connectTimeoutMs, 15000);
      expect(config.receiveTimeoutMs, 15000);
      expect(config.sendTimeoutMs, 15000);
    });
  });
}
