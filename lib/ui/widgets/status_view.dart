import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:brewery_forest/ui/widgets/app_text.dart';
import 'package:brewery_forest/ui/widgets/icon_circle.dart';
import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  const StatusView({
    super.key,
    required this.icon,
    required this.headline,
    this.body,
    this.actions = const [],
    this.semanticsIdentifier,
  });

  final IconData icon;
  final String headline;
  final String? body;
  final List<Widget> actions;
  final String? semanticsIdentifier;

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.stackMd),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconCircle(
              icon: icon,
              size: 80,
              background: context.colors.surfaceContainerHighest,
              foreground: context.colors.onSurfaceVariant,
            ),
            const SizedBox(height: AppSpacing.stackMd),
            AppText.headlineMd(headline, textAlign: TextAlign.center),
            if (body != null) ...[
              const SizedBox(height: AppSpacing.stackSm),
              AppText.bodyMd(
                body!,
                textAlign: TextAlign.center,
                color: context.colors.onSurfaceVariant,
              ),
            ],
            if (actions.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.stackMd),
              ...actions,
            ],
          ],
        ),
      ),
    );

    if (semanticsIdentifier == null) return content;
    return Semantics(identifier: semanticsIdentifier, child: content);
  }
}
