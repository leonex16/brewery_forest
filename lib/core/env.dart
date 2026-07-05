class Env {
  const Env._();

  static String get mapboxAccessToken {
    const token = String.fromEnvironment('MAPBOX_ACCESS_TOKEN');

    if (token.isEmpty) {
      throw StateError('MAPBOX_ACCESS_TOKEN is not set');
    }

    return token;
  }
}
