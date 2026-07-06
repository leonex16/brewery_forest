import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  const Skeleton({super.key, this.width, this.height = 16, this.radius = 8});

  final double? width;
  final double height;
  final double radius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onSurface = context.colors.onSurface;

    Widget box(double alpha) => Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: onSurface.withValues(alpha: alpha),
        borderRadius: BorderRadius.circular(widget.radius),
      ),
    );

    if (MediaQuery.disableAnimationsOf(context)) return box(0.08);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = Curves.easeInOut.transform(_controller.value);
        return box(0.05 + 0.09 * t);
      },
    );
  }
}
