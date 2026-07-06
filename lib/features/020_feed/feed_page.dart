import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/020_feed/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/feed_presentation.dart';
import 'package:brewery_forest/features/020_feed/search_bloc.dart';
import 'package:brewery_forest/ui/theme/l10n_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  static const _fallbackLongitude = -79.3832; // Toronto
  static const _fallbackLatitude = 43.6532;

  final _viewportController = ViewportController();
  CircleAnnotationManager? _circleAnnotationManager;

  @override
  void dispose() {
    _viewportController.dispose();
    super.dispose();
  }

  Future<void> _onMapCreated(MapboxMap map) async {
    _circleAnnotationManager = await map.annotations
        .createCircleAnnotationManager();

    if (!mounted) return;

    _circleAnnotationManager?.tapEvents(onTap: _onMarkerTap);
    _updateMarkers(context.read<FeedCubit>().state);
  }

  void _onMarkerTap(CircleAnnotation annotation) {
    final breweryId = annotation.customData?['brewery_id'] as String?;
    if (breweryId == null) return;

    final state = context.read<FeedCubit>().state;
    if (state is! FeedOk) return;

    final matches = state.breweries.where((b) => b.id == breweryId);
    if (matches.isEmpty) return;

    context.read<FeedCubit>().selectBrewery(matches.first);
  }

  Future<void> _updateMarkers(FeedState state) async {
    final manager = _circleAnnotationManager;
    if (manager == null || state is! FeedOk) return;

    await manager.deleteAll();

    for (final brewery in state.breweries) {
      await manager.create(
        CircleAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              brewery.address.coordinates.longitude,
              brewery.address.coordinates.latitude,
            ),
          ),
          circleColor: Colors.deepOrange.toARGB32(),
          circleRadius: 8,
          customData: {'brewery_id': brewery.id},
        ),
      );
    }

    final userPosition = state.userPosition;
    if (userPosition != null) {
      await manager.create(
        CircleAnnotationOptions(
          geometry: Point(
            coordinates: Position(
              userPosition.longitude,
              userPosition.latitude,
            ),
          ),
          circleColor: Colors.blue.toARGB32(),
          circleRadius: 10,
        ),
      );
    }
  }

  void _onFeedStateChanged(BuildContext context, FeedState state) {
    _updateMarkers(state);

    if (state is FeedOk && state.userPosition != null) {
      _viewportController.moveTo(
        CameraViewportState(
          center: Point(
            coordinates: Position(
              state.userPosition!.longitude,
              state.userPosition!.latitude,
            ),
          ),
          zoom: 12,
        ),
      );
    }
  }

  Widget _flagOrIcon(String? flagUrl) {
    if (flagUrl == null) return const Icon(Icons.local_offer);

    return Image.network(
      flagUrl,
      width: 32,
      height: 24,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => const Icon(Icons.local_offer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final feedCubit = context.read<FeedCubit>();
    final searchBloc = context.read<SearchBloc>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: context.l10n.fabSearchHere,
        onPressed: () => feedCubit.refreshLocation(),
        child: const Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          BlocListener<FeedCubit, FeedState>(
            listener: _onFeedStateChanged,
            child: MapWidget(
              onMapCreated: _onMapCreated,
              viewportController: _viewportController,
              viewport: CameraViewportState(
                center: Point(
                  coordinates: Position(_fallbackLongitude, _fallbackLatitude),
                ),
                zoom: 12,
              ),
            ),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, sheetScrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SearchAnchor(
                        builder: (_, controller) => Semantics(
                          identifier: 'feed_search_field',
                          child: SearchBar(
                            controller: controller,
                            hintText: context.l10n.feedSearchHint,
                            leading: const Icon(Icons.search),
                            onTap: () => controller.openView(),
                            onChanged: (_) => controller.openView(),
                          ),
                        ),
                        suggestionsBuilder: (_, controller) async {
                          final query = controller.text;
                          searchBloc.add(SearchQueryChanged(query));

                          return [
                            BlocBuilder<SearchBloc, SearchState>(
                              bloc: searchBloc,
                              builder: (context, state) => switch (state) {
                                SearchIdle() => const SizedBox.shrink(),
                                SearchLoading() => const Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                                SearchFailure(:final error) => ListTile(
                                  title: Text(userMessage(context, error)),
                                ),
                                SearchSuccess(:final breweries)
                                    when breweries.isEmpty =>
                                  ListTile(
                                    title: Text(context.l10n.feedEmptyTitle),
                                  ),
                                SearchSuccess(:final breweries) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final brewery in breweries)
                                      Semantics(
                                        identifier: 'search_result_item',
                                        child: ListTile(
                                          title: Text(brewery.name),
                                          subtitle: Text(
                                            brewery.breweryType.name,
                                          ),
                                          onTap: () {
                                            controller.closeView(brewery.name);
                                            context.pushNamed(
                                              'brewery-detail',
                                              pathParameters: {
                                                'id': brewery.id,
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              },
                            ),
                          ];
                        },
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<FeedCubit, FeedState>(
                        builder: (_, state) => switch (state) {
                          FeedLoading() => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          FeedError(:final error) => Semantics(
                            identifier: 'feed_error',
                            child: Center(child: Text(userMessage(context, error))),
                          ),

                          FeedOk(:final breweries) when breweries.isEmpty =>
                            Center(child: Text(context.l10n.feedEmptyTitle)),

                          FeedOk(:final breweries) =>
                            NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                const threshold = 200.0;
                                final metrics = notification.metrics;

                                if (metrics.pixels >=
                                    metrics.maxScrollExtent - threshold) {
                                  feedCubit.loadNextPage();
                                }

                                return false;
                              },
                              child: ListView.separated(
                                controller: sheetScrollController,
                                itemCount: breweries.length + 1,
                                separatorBuilder: (_, _) => const Divider(),
                                itemBuilder: (_, index) {
                                  if (index < breweries.length) {
                                    final brewery = breweries[index];
                                    return Semantics(
                                      identifier: 'brewery_item',
                                      child: ListTile(
                                        title: Text(
                                          "${index + 1}. ${brewery.name}",
                                        ),
                                        leading: _flagOrIcon(
                                          brewery.address.flagUrl,
                                        ),
                                        subtitle: Text(
                                          'breweryType: ${brewery.breweryType.name}, city: ${brewery.address.city}, state: ${brewery.address.stateProvince}',
                                        ),
                                        onTap: () =>
                                            feedCubit.selectBrewery(brewery),
                                      ),
                                    );
                                  }

                                  return switch (state.paginationStatus) {
                                    PaginationStatus.idle ||
                                    PaginationStatus.reachedEnd =>
                                      const SizedBox.shrink(),

                                    PaginationStatus.loadingMore =>
                                      const Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(16),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),

                                    PaginationStatus.error => Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Semantics(
                                          identifier: 'pagination_retry',
                                          child: TextButton(
                                            onPressed: () =>
                                                feedCubit.loadNextPage(),
                                            child: Text(
                                              '${context.l10n.feedRetry} (${userMessage(context, state.paginationError!)})',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  };
                                },
                              ),
                            ),
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            child: BlocBuilder<FeedCubit, FeedState>(
              builder: (context, state) {
                if (state is! FeedOk) return const SizedBox.shrink();

                final text = locationBannerMessage(
                  context,
                  state.locationSource,
                  state.ipLocation,
                );

                if (text == null) return const SizedBox.shrink();

                return Semantics(
                  identifier: 'location_banner',
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.amber.shade100,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Text(text),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned.fill(
            child: BlocBuilder<FeedCubit, FeedState>(
              builder: (context, state) {
                final brewery = state is FeedOk ? state.selectedBrewery : null;
                if (brewery == null) return const SizedBox.shrink();

                return Stack(
                  children: [
                    Positioned.fill(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => feedCubit.clearSelection(),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 100,
                      child: Semantics(
                        identifier: 'brewery_card',
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _flagOrIcon(brewery.address.flagUrl),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        brewery.name,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text('Type: ${brewery.breweryType.name}'),
                                if (brewery.address.city != null)
                                  Text('City: ${brewery.address.city}'),
                                const SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      final id = brewery.id;
                                      feedCubit.clearSelection();
                                      context.pushNamed(
                                        'brewery-detail',
                                        pathParameters: {'id': id},
                                      );
                                    },
                                    child: const Text('See more'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
