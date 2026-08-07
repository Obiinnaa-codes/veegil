import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class EnvConfig {
  static String get baseUrl {
    final url = dotenv.env['BASE_URL'];
    if (url == null || url.isEmpty) {
      throw StateError(
        'BASE_URL is not set. Copy .env.example to .env and configure it.',
      );
    }
    return url;
  }
}
