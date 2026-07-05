import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/020_feed/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    const thresthold = 200.0;
    final scrollPosition = _scrollController.position;

    if (scrollPosition.pixels < (scrollPosition.maxScrollExtent - thresthold)) {
      return;
    }

    context.read<FeedCubit>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final feedCubit = context.read<FeedCubit>();
    final searchBloc = context.read<SearchBloc>();

    return Scaffold(
      appBar: AppBar(
        title: SearchAnchor(
          builder: (_, controller) {
            return SearchBar(
              controller: controller,
              hintText: 'Search breweries...',
              leading: const Icon(Icons.search),
              onTap: () => controller.openView(),
              onChanged: (_) => controller.openView(),
            );
          },
          suggestionsBuilder: ((context, controller) async {
            final query = controller.text;

            searchBloc.add(SearchQueryChanged(query));

            return [
              BlocBuilder<SearchBloc, SearchState>(
                bloc: searchBloc,
                builder: (context, state) {
                  return switch (state) {
                    SearchIdle() => const SizedBox.shrink(),

                    SearchLoading() => const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    ),

                    SearchFailure(:final error) => ListTile(
                      title: Text(userMessage(error)),
                    ),

                    SearchSuccess(:final breweries) when breweries.isEmpty =>
                      const ListTile(title: Text('No breweries found')),

                    SearchSuccess(:final breweries) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final brewery in breweries)
                          ListTile(
                            title: Text(brewery.name),
                            subtitle: Text(brewery.breweryType.name),
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
                  };
                },
              ),
            ];
          }),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            tooltip: 'Search on current location',
            onPressed: () => feedCubit.refreshLocation(),
          ),
        ],
      ),

      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (_, state) => switch (state) {
          FeedLoading() => const Center(child: CircularProgressIndicator()),
          FeedError(:final error) => Center(child: Text(userMessage(error))),

          FeedOk(:final breweries) when breweries.isEmpty => const Center(
            child: Text('No breweries found'),
          ),

          FeedOk(:final breweries) => ListView.separated(
            controller: _scrollController,
            itemCount: breweries.length + 1,
            separatorBuilder: (_, _) => const Divider(),

            itemBuilder: (_, index) {
              if (index < breweries.length) {
                final brewery = breweries[index];
                return ListTile(
                  title: Text("${index + 1}. ${brewery.name}"),
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
                PaginationStatus.reachedEnd => const SizedBox.shrink(),

                PaginationStatus.loadingMore => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                ),

                PaginationStatus.error => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextButton(
                      onPressed: () => feedCubit.loadNextPage(),
                      child: Text(
                        'Reintentar (${userMessage(state.paginationError!)})',
                      ),
                    ),
                  ),
                ),
              };
            },
          ),
        },
      ),
    );
  }
}
