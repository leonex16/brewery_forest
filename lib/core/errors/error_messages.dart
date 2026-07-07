import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:flutter/material.dart';

String userMessage(BuildContext context, AppEx error) => switch (error) {
  // DomainEx
  InvalidBreweryEx() => context.l10n.errInvalidBrewery,
  InvalidCoordinatesEx() => context.l10n.errInvalidCoordinates,
  InvalidContactEx() => context.l10n.errInvalidContact,

  // InfraEx
  NetworkEx() => context.l10n.errNetwork,
  ServerEx() => context.l10n.errServer,
  LocationUnavailableEx() => context.l10n.errLocationUnavailable,
};
