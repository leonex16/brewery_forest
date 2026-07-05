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
              const Text(
                "No problem! You can still explore breweries by searching "
                "manually, or enable location in your settings later to "
                "see what's nearby.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: onOpenSettings,
                child: const Text('Open settings'),
              ),
              TextButton(
                onPressed: onExplore,
                child: const Text('Explore without location'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
