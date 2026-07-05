import 'package:flutter/material.dart';

const appTextTheme = TextTheme(
  // headline-xl (40/800→700, -0.02em) — héroe del detalle
  displaySmall: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.8,
  ),
  // headline-lg (32/800→700, -0.02em) — onboarding
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.64,
  ),
  // headline-lg-mobile (28/800→700) — headlines de error states
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.214,
  ),
  // headline-md (24/700)
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.333,
  ),
  // headline-md (24/700) duplicado → AppBar lee titleLarge
  titleLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.333,
  ),
  // body-lg (18/400) — textos del detalle
  bodyLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.556,
  ),
  // body-md (16/400) — body por defecto
  bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.5),
  // label-md (14/600, +0.01em) duplicado → ListTile lee titleMedium
  titleMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.429,
    letterSpacing: 0.14,
  ),
  // label-md (14/600, +0.01em) → botones leen labelLarge
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.429,
    letterSpacing: 0.14,
  ),
  // label-sm (12/700) — metadatos, chips
  labelMedium: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.333,
  ),
);
