import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:flutter/material.dart';

class IconCircle extends StatelessWidget {
  const IconCircle({
    super.key,
    required this.icon,
    this.size = 48,
    this.background,
    this.foreground,
    this.shape = BoxShape.circle,
    this.borderRadius,
  });

  final IconData icon;
  final double size;
  final Color? background;
  final Color? foreground;
  final BoxShape shape;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final bg = background ?? context.colors.primaryFixed;
    final fg = foreground ?? context.colors.onPrimaryFixedVariant;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        shape: shape,
        borderRadius: borderRadius,
      ),
      child: Icon(icon, size: size * 0.5, color: fg),
    );
  }
}
