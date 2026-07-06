import 'package:brewery_forest/ui/theme/app_icons.dart';
import 'package:flutter/material.dart';

class BfTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  const BfTopBar({
    super.key,
    this.title = 'Brewery Forest',
    this.showBack = false,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: showBack,
      leading: showBack
          ? IconButton(
              icon: const Icon(AppIcons.back),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          : null,
    );
  }
}
