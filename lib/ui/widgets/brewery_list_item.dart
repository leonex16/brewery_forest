import 'package:brewery_forest/core/domain/brewery.dart';
import 'package:brewery_forest/ui/theme/app_icons.dart';
import 'package:brewery_forest/ui/theme/theme_context.dart';
import 'package:brewery_forest/ui/widgets/app_text.dart';
import 'package:brewery_forest/ui/widgets/icon_circle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BreweryListItem extends StatelessWidget {
  final Brewery brewery;
  final VoidCallback? onTap;
  final String? semanticsIdentifier;
  final bool showChevron;

  const BreweryListItem({
    super.key,
    required this.brewery,
    this.onTap,
    this.semanticsIdentifier,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      onTap: onTap,
      leading: _Leading(brewery: brewery),
      title: AppText.labelMd(brewery.name),
      subtitle: AppText.labelSm(
        _subtitle,
        color: context.colors.onSurfaceVariant,
      ),
      trailing: showChevron
          ? Icon(AppIcons.chevronRight, color: context.colors.outline)
          : null,
    );

    if (semanticsIdentifier == null) return tile;
    return Semantics(identifier: semanticsIdentifier, child: tile);
  }

  String get _subtitle {
    final type = _capitalize(brewery.breweryType.name);
    final place = [
      brewery.address.city,
      brewery.address.stateProvince,
    ].where((e) => e != null && e.isNotEmpty).join(', ');
    return place.isEmpty ? type : '$type · $place';
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
}

class _Leading extends StatelessWidget {
  const _Leading({required this.brewery});

  final Brewery brewery;

  @override
  Widget build(BuildContext context) {
    final circle = IconCircle(icon: iconForBreweryType(brewery.breweryType));
    final flagUrl = brewery.address.flagUrl;
    if (flagUrl == null) return circle;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        circle,
        Positioned(
          right: -2,
          bottom: -2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: CachedNetworkImage(
              imageUrl: flagUrl,
              width: 18,
              height: 12,
              fit: BoxFit.cover,
              errorWidget: (_, _, _) => const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}
