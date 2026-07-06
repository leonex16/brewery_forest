import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:flutter/material.dart';

class EnableLocationPage extends StatelessWidget {
  const EnableLocationPage({
    super.key,
    required this.onEnable,
    required this.onExplore,
  });

  final VoidCallback onEnable;
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
              const Icon(Icons.location_on_outlined, size: 64),
              const SizedBox(height: 16),
              Text(
                context.l10n.onboardingTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onEnable,
                child: Text(context.l10n.onboardingEnable),
              ),
              TextButton(
                onPressed: onExplore,
                child: Text(context.l10n.onboardingExplore),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
