import 'package:brewery_forest/core/errors/error_messages.dart';
import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/presentation/widgets/pagination_footer.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BreweryList extends StatelessWidget {
  final ScrollController scrollController;

  const BreweryList({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, FeedState>(
      builder: (context, state) => switch (state) {
        FeedLoading() => ListView(
          controller: scrollController,
          padding: .zero,
          children: List.generate(6, (_) => BreweryTileSkeleton()),
        ),

        FeedError(:final error) => StatusView(
          icon: AppIcons.error,
          headline: userMessage(context, error),
          semanticsIdentifier: 'feed_error',
          actions: [
            FilledButton(
              onPressed: () => context.read<FeedCubit>().refreshLocation(),
              child: Text(context.l10n.feedRetry),
            ),
          ],
        ),
        FeedOk(:final breweries) when breweries.isEmpty => StatusView(
          icon: AppIcons.noResults,
          headline: context.l10n.feedEmptyTitle,
          body: context.l10n.feedEmptyBody,
        ),
        FeedOk() => _LoadedList(state: state, controller: scrollController),
      },
    );
  }
}

class _LoadedList extends StatelessWidget {
  final FeedOk state;
  final ScrollController controller;

  const _LoadedList({required this.state, required this.controller});

  @override
  Widget build(BuildContext context) {
    final breweries = state.breweries;
    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n.metrics.pixels >= n.metrics.maxScrollExtent - 200) {
          context.read<FeedCubit>().loadNextPage();
        }
        return false;
      },
      child: ListView.separated(
        controller: controller,
        itemCount: breweries.length + 1,
        padding: .zero,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          if (index < breweries.length) {
            final b = breweries[index];
            return BreweryListItem(
              brewery: b,
              semanticsIdentifier: 'brewery_item',
              showChevron: false,
              onTap: () => context.read<FeedCubit>().selectBrewery(b),
            );
          }

          return PaginationFooter(
            status: state.paginationStatus,
            error: state.paginationError,
            onRetry: () => context.read<FeedCubit>().loadNextPage(),
          );
        },
      ),
    );
  }
}
