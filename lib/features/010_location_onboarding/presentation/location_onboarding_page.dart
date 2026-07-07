import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/010_location_onboarding/application/location_onboarding_cubit.dart';
import 'package:brewery_forest/features/010_location_onboarding/presentation/enable_location_page.dart';
import 'package:brewery_forest/features/010_location_onboarding/presentation/location_disabled_page.dart';
import 'package:brewery_forest/ui/widgets/loading_view.dart';
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
        LocationChecking() ||
        LocationGranted() => const Scaffold(body: LoadingView()),

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
          reCheckPermission: context.read<LocationOnboardingCubit>().recheck,
        ),

        LocationDeniedForever() => LocationDisabledPage(
          onOpenSettings: context
              .read<LocationOnboardingCubit>()
              .openAppSettings,
          onExplore: () => context.goNamed('feed'),
          reCheckPermission: context.read<LocationOnboardingCubit>().recheck,
        ),
      },
    );
  }
}
