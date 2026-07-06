import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:flutter/material.dart';

enum _Slot {
  headlineXl,
  headlineLg,
  headlineLgMobile,
  headlineMd,
  bodyLg,
  bodyMd,
  labelMd,
  labelSm,
}

class AppText extends StatelessWidget {
  const AppText.headlineXl(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.headlineXl;

  const AppText.headlineLg(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.headlineLg;

  const AppText.headlineLgMobile(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.headlineLgMobile;

  const AppText.headlineMd(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.headlineMd;

  const AppText.bodyLg(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.bodyLg;

  const AppText.bodyMd(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.bodyMd;

  const AppText.labelMd(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.labelMd;

  const AppText.labelSm(
    this.content, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : _slot = _Slot.labelSm;

  final String content;
  final _Slot _slot;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  TextStyle? _styleOf(BuildContext context) {
    final t = context.text;
    return switch (_slot) {
      _Slot.headlineXl => t.displaySmall,
      _Slot.headlineLg => t.headlineLarge,
      _Slot.headlineLgMobile => t.headlineMedium,
      _Slot.headlineMd => t.headlineSmall,
      _Slot.bodyLg => t.bodyLarge,
      _Slot.bodyMd => t.bodyMedium,
      _Slot.labelMd => t.labelLarge,
      _Slot.labelSm => t.labelMedium,
    };
  }

  @override
  Widget build(BuildContext context) {
    final base = _styleOf(context);
    return Text(
      content,
      style: color == null ? base : base?.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
