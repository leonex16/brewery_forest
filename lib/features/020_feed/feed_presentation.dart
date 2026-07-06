import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:flutter/material.dart';

String? locationBannerMessage(
  BuildContext context,
  LocationSource source,
  IpLocation? ip,
) {
  switch (source) {
    case LocationSource.precise:
      return null;
    case LocationSource.none:
      return context.l10n.locationBannerNone;
    case LocationSource.approximate:
      return context.l10n.locationBannerApproximate(
        ip?.city ?? '',
        ip?.country ?? '',
      );
  }
}
