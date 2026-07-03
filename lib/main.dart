import 'package:brewery_forest/app/application.dart';
import 'package:brewery_forest/core/di/injection.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDI();
  runApp(const Application());
}
