import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/020_feed/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/search_bloc.dart';
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

    context.pushNamed('brewery-detail', pathParameters: {'id': breweryId});
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

  @override
  Widget build(BuildContext context) {
    final feedCubit = context.read<FeedCubit>();
    final searchBloc = context.read<SearchBloc>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Search on current location',
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
                        builder: (_, controller) => SearchBar(
                          controller: controller,
                          hintText: 'Search breweries...',
                          leading: const Icon(Icons.search),
                          onTap: () => controller.openView(),
                          onChanged: (_) => controller.openView(),
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
                                  title: Text(userMessage(error)),
                                ),
                                SearchSuccess(:final breweries)
                                    when breweries.isEmpty =>
                                  const ListTile(
                                    title: Text('No breweries found'),
                                  ),
                                SearchSuccess(:final breweries) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (final brewery in breweries)
                                      ListTile(
                                        title: Text(brewery.name),
                                        subtitle: Text(
                                          brewery.breweryType.name,
                                        ),
                                        onTap: () {
                                          controller.closeView(brewery.name);
                                          context.pushNamed(
                                            'brewery-detail',
                                            pathParameters: {'id': brewery.id},
                                          );
                                        },
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
                          FeedError(:final error) => Center(
                            child: Text(userMessage(error)),
                          ),

                          FeedOk(:final breweries) when breweries.isEmpty =>
                            const Center(child: Text('No breweries found')),

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
                                    return ListTile(
                                      title: Text(
                                        "${index + 1}. ${brewery.name}",
                                      ),
                                      leading: const Icon(Icons.local_offer),
                                      subtitle: Text(
                                        'breweryType: ${brewery.breweryType.name}, city: ${brewery.address.city}, state: ${brewery.address.stateProvince}',
                                      ),
                                      onTap: () => context.pushNamed(
                                        'brewery-detail',
                                        pathParameters: {'id': brewery.id},
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
                                        child: TextButton(
                                          onPressed: () =>
                                              feedCubit.loadNextPage(),
                                          child: Text(
                                            'Reintentar (${userMessage(state.paginationError!)})',
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
        ],
      ),
    );
  }
}
