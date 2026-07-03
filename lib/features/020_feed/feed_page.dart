import 'package:brewery_forest/features/020_feed/brewery_list_sheet.dart';
import 'package:brewery_forest/features/020_feed/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) => switch (state) {
          FeedLoading() => const Center(child: CircularProgressIndicator()),
          FeedError(:final error) => Center(child: Text(error.message)),
          FeedReady(:final breweries) => Stack(
            children: [
              Container(
                color: Colors.blueGrey.shade100,
                child: const Center(child: Text('Mapa (Mapbox pendiente)')),
              ),
              DraggableScrollableSheet(
                initialChildSize: 0.35,
                minChildSize: 0.15,
                maxChildSize: 0.9,
                builder: (context, scrollController) => BreweryListSheet(
                  breweries: breweries,
                  scrollController: scrollController,
                ),
              ),
            ],
          ),
        },
      ),
    );
  }
}
