import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:flutter/material.dart';

class LocationDisabledPage extends StatelessWidget {
  const LocationDisabledPage({
    super.key,
    required this.onOpenSettings,
    required this.onExplore,
  });

  final Future<bool> Function() onOpenSettings;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.l10n.deniedBody, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              TextButton(
                onPressed: onOpenSettings,
                child: Text(context.l10n.deniedOpenSettings),
              ),
              TextButton(
                onPressed: onExplore,
                child: Text(context.l10n.deniedExplore),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
