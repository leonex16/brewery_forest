import 'package:brewery_forest/app/router.dart';
import 'package:brewery_forest/l10n/app_localizations.dart';
import 'package:brewery_forest/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: .system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
