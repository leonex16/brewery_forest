import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/010_location_onboarding/enable_location_page.dart';
import 'package:brewery_forest/features/010_location_onboarding/location_disabled_page.dart';
import 'package:brewery_forest/features/010_location_onboarding/location_onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationOnboardingPage extends StatelessWidget {
  const LocationOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationOnboardingCubit, LocationOnboardingState>(
      listener: (context, state) {
        if (state is LocationGranted) context.goNamed('feed');
      },

      builder: (context, state) => switch (state) {
        LocationChecking() || LocationGranted() => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),

        LocationDenied() => EnableLocationPage(
          onEnable: () =>
              context.read<LocationOnboardingCubit>().requestPermission(),
          onExplore: () => context.goNamed('feed'),
        ),

        LocationServiceDisabled() => LocationDisabledPage(
          onOpenSettings: context
              .read<LocationOnboardingCubit>()
              .openLocationSettings,
          onExplore: () => context.goNamed('feed'),
        ),
        LocationDeniedForever() => LocationDisabledPage(
          onOpenSettings: context
              .read<LocationOnboardingCubit>()
              .openAppSettings,
          onExplore: () => context.goNamed('feed'),
        ),
      },
    );
  }
}
