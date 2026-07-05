import 'package:brewery_forest/app/application.dart';
import 'package:brewery_forest/core/di/injection.dart';
import 'package:brewery_forest/core/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapboxOptions.setAccessToken(Env.mapboxAccessToken);

  await SystemChrome.setPreferredOrientations([.portraitUp, .portraitDown]);

  setupDI();
  runApp(const Application());
}
