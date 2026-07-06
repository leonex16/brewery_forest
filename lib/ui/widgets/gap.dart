import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:flutter/widgets.dart';

class Gap extends StatelessWidget {
  final double _size;
  final Axis axis;

  const Gap.section({super.key, this.axis = Axis.vertical})
    : _size = AppSpacing.stackLg;
  const Gap.block({super.key, this.axis = Axis.vertical})
    : _size = AppSpacing.stackMd;
  const Gap.gutter({super.key, this.axis = Axis.vertical})
    : _size = AppSpacing.gutter;
  const Gap.group({super.key, this.axis = Axis.vertical})
    : _size = AppSpacing.stackSm;
  const Gap.tiny({super.key, this.axis = Axis.vertical})
    : _size = AppSpacing.base;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: axis == Axis.horizontal ? _size : null,
    height: axis == Axis.vertical ? _size : null,
  );
}
