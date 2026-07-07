import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/feed_bottom_sheet.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/feed_map.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/location_floating_banner.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/selected_brewery_overlay.dart';
import 'package:brewery_forest/ui/theme/app_icons.dart';
import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: context.l10n.fabSearchHere,
        onPressed: () => context.read<FeedCubit>().refreshLocation(),
        child: const Icon(AppIcons.myLocation),
      ),
      body: const Stack(
        children: [
          FeedMap(),
          SelectedBreweryScrim(),
          FeedBottomSheet(),
          LocationFloatingBanner(),
          SelectedBreweryCard(),
        ],
      ),
    );
  }
}
