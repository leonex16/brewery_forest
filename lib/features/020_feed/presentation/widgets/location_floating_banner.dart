import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/presentation/feed_presentation.dart';
import 'package:brewery_forest/ui/theme/dimensions.dart';
import 'package:brewery_forest/ui/widgets/bf_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationFloatingBanner extends StatefulWidget {
  const LocationFloatingBanner({super.key});

  @override
  State<LocationFloatingBanner> createState() => _LocationFloatingBannerState();
}

class _LocationFloatingBannerState extends State<LocationFloatingBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, FeedState>(
      builder: (context, state) {
        if (_dismissed || state is! FeedOk) return const SizedBox.shrink();

        final msg = locationBannerMessage(
          context,
          state.locationSource,
          state.ipLocation,
        );
        if (msg == null) return const SizedBox.shrink();

        return Positioned(
          top: AppSpacing.stackSm,
          left: AppSpacing.gutter,
          right: AppSpacing.gutter,
          child: BfBanner(
            message: msg,
            semanticsIdentifier: 'location_banner',
            onDismiss: () => setState(() => _dismissed = true),
          ),
        );
      },
    );
  }
}
