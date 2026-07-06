class Env {
  const Env._();

  static String get mapboxAccessToken {
    const token = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

    if (token.isEmpty) {
      throw StateError('MAPBOX_ACCESS_TOKEN is not set');
    }

    return token;
  }

  static String get appEnv =>
      const String.fromEnvironment('APP_ENV', defaultValue: 'dev');

  static String get sentryDsn {
    const token = String.fromEnvironment('SENTRY_DSN');

    if (token.isEmpty) {
      throw StateError('SENTRY_DSN is not set');
    }

    return token;
  }

  static bool get isProduction => appEnv == 'production';
}
