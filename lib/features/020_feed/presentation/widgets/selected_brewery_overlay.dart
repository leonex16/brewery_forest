import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SelectedBreweryScrim extends StatelessWidget {
  const SelectedBreweryScrim({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, FeedState>(
      buildWhen: (a, b) => _hasSelection(a) != _hasSelection(b),
      builder: (context, state) {
        if (!_hasSelection(state)) return const SizedBox.shrink();

        return Positioned.fill(
          child: GestureDetector(
            behavior: .opaque,
            onTap: () => context.read<FeedCubit>().clearSelection(),
            child: ColoredBox(color: context.colors.scrim.withValues(alpha: 0.4)),
          ),
        );
      },
    );
  }
}

class SelectedBreweryCard extends StatelessWidget {
  const SelectedBreweryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, FeedState>(
      buildWhen: (a, b) => _selected(a) != _selected(b),
      builder: (context, state) {
        final brewery = _selected(state);
        if (brewery == null) return const SizedBox.shrink();

        return Align(
          alignment: .topCenter,
          child: SafeArea(child: _PinCard(brewery: brewery)),
        );
      },
    );
  }
}

Brewery? _selected(FeedState state) => state is FeedOk ? state.selectedBrewery : null;

bool _hasSelection(FeedState state) => _selected(state) != null;

class _PinCard extends StatelessWidget {
  const _PinCard({required this.brewery});
  final Brewery brewery;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();
    final subtitle = [brewery.address.city, brewery.address.stateProvince].joinNonEmpty();

    return Semantics(
      identifier: 'brewery_card',
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.gutter,
            vertical: AppSpacing.stackMd,
          ),
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText.headlineMd(
                      brewery.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(icon: const Icon(AppIcons.close), onPressed: cubit.clearSelection),
                ],
              ),
              if (subtitle?.isNotEmpty == true)
                AppText.labelSm(subtitle!, color: context.colors.onSurfaceVariant),
              const Gap.group(),
              Align(
                alignment: Alignment.bottomRight,
                child: FilledButton(
                  onPressed: () {
                    final id = brewery.id;
                    cubit.clearSelection();
                    context.pushNamed('brewery-detail', pathParameters: {'id': id});
                  },
                  child: Text(context.l10n.breweryCardCta),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
