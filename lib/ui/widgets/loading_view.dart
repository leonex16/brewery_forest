import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:brewery_forest/ui/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.gutter),
            AppText.bodyMd(message!, textAlign: TextAlign.center),
          ],
        ],
      ),
    );
  }
}
