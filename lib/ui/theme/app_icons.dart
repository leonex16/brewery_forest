import 'package:brewery_forest/core/domain/brewery.dart';
import 'package:flutter/widgets.dart';
import 'package:phosphoricons_flutter/phosphoricons_flutter.dart';

abstract final class AppIcons {
  // Navigation
  static const IconData menu = PhosphorIconsRegular.list;
  static const IconData back = PhosphorIconsRegular.arrowLeft;
  static const IconData close = PhosphorIconsRegular.x;
  static const IconData chevronRight = PhosphorIconsRegular.caretRight;

  // Feed / Map
  static const IconData search = PhosphorIconsRegular.magnifyingGlass;
  static const IconData myLocation = PhosphorIconsRegular.crosshair;
  static const IconData userPin =
      PhosphorIconsFill.mapPin; // pin del usuario (FILL)
  static const IconData searchArea = PhosphorIconsRegular.arrowClockwise;
  static const IconData info = PhosphorIconsRegular.info;
  static const IconData noResults = PhosphorIconsRegular.mapPinLine;

  // States / details
  static const IconData error = PhosphorIconsRegular.warningCircle;
  static const IconData phone = PhosphorIconsRegular.phone;
  static const IconData website = PhosphorIconsRegular.globe;
  static const IconData settings = PhosphorIconsRegular.gearSix;
  static const IconData lock = PhosphorIconsRegular.lockSimple;

  // Onboarding
  static const IconData mapTrifold = PhosphorIconsRegular.mapTrifold;
  static const IconData drink = PhosphorIconsRegular.beerStein;
}

IconData iconForBreweryType(BreweryType type) => switch (type) {
  BreweryType.micro => PhosphorIconsRegular.beerStein,
  BreweryType.brewpub => PhosphorIconsRegular.forkKnife,
  BreweryType.large => PhosphorIconsRegular.beerBottle,
  BreweryType.proprietor => PhosphorIconsRegular.beerBottle,
  BreweryType.closed => PhosphorIconsRegular.prohibit,
  BreweryType.unknown => PhosphorIconsRegular.beerStein,
};
