import 'package:brewery_forest/core/di/injection.dart';
import 'package:brewery_forest/core/env.dart';
import 'package:brewery_forest/core/observability/device_identity_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> bootstrap(Widget Function() builder) async {
  setupDI(environment: Env.isProduction ? Environment.prod : Environment.dev);

  await SentryFlutter.init(
    (options) {
      options.dsn = Env.sentryDsn;
      options.environment = Env.appEnv;
      options.debug = kDebugMode;
      options.sendDefaultPii = true;
      options.tracesSampleRate = Env.isProduction ? 1.0 : 0.1;
      options.replay.sessionSampleRate = Env.isProduction ? 1.0 : 0.1;
      options.replay.onErrorSampleRate = Env.isProduction ? 1.0 : 0.0;
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      MapboxOptions.setAccessToken(Env.mapboxAccessToken);

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      final identity = await getIt<DeviceIdentityService>().resolve();
      await Sentry.configureScope(
        (scope) => scope.setUser(
          SentryUser(
            id: identity.installationId,
            data: {
              'model': identity.model,
              'os': identity.osVersion,
              'environment': Env.appEnv,
            },
          ),
        ),
      );

      runApp(builder());
    },
  );
}
