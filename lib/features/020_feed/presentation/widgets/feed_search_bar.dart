import 'package:brewery_forest/core/errors/error_messages.dart';
import 'package:brewery_forest/features/020_feed/application/search_bloc.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedSearchBar extends StatelessWidget {
  const FeedSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchBloc = context.read<SearchBloc>();

    return SearchAnchor(
      builder: (context, controller) => Semantics(
        identifier: 'feed_search_field',
        child: SearchBar(
          controller: controller,
          hintText: context.l10n.feedSearchHint,
          leading: const Icon(AppIcons.search),
          onTap: controller.openView,
          onChanged: (_) => controller.openView(),
        ),
      ),
      suggestionsBuilder: (context, controller) {
        searchBloc.add(SearchQueryChanged(controller.text));

        return [
          BlocBuilder<SearchBloc, SearchState>(
            bloc: searchBloc,
            builder: (context, state) => switch (state) {
              SearchIdle() => Padding(
                padding: const EdgeInsets.all(AppSpacing.gutter),
                child: AppText.labelSm(
                  context.l10n.searchMinChars,
                  color: context.colors.onSurfaceVariant,
                ),
              ),

              SearchLoading() => Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(6, (_) => BreweryTileSkeleton()),
              ),

              SearchFailure(:final error) => Padding(
                padding: const .all(AppSpacing.gutter),
                child: Row(
                  children: [
                    Icon(AppIcons.error, color: context.colors.error),
                    const Gap.gutter(axis: Axis.horizontal),
                    Expanded(
                      child: AppText.bodyMd(userMessage(context, error)),
                    ),
                  ],
                ),
              ),

              SearchSuccess(:final breweries) when breweries.isEmpty => Padding(
                padding: const EdgeInsets.all(AppSpacing.gutter),
                child: AppText.bodyMd(context.l10n.feedEmptyTitle),
              ),

              SearchSuccess(:final breweries) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final b in breweries)
                    BreweryListItem(
                      brewery: b,
                      semanticsIdentifier: 'search_result_item',
                      onTap: () {
                        controller.closeView(b.name);
                        context.pushNamed(
                          'brewery-detail',
                          pathParameters: {'id': b.id},
                        );
                      },
                    ),
                ],
              ),
            },
          ),
        ];
      },
    );
  }
}
