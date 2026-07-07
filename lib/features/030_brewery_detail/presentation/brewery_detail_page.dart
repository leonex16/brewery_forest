import 'package:brewery_forest/core/env.dart';
import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/030_brewery_detail/application/brewery_detail_cubit.dart';
import 'package:brewery_forest/features/030_brewery_detail/presentation/widgets/detail_error_view.dart';
import 'package:brewery_forest/features/030_brewery_detail/presentation/widgets/detail_info_card.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class BreweryDetailPage extends StatelessWidget {
  const BreweryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BfTopBar(showBack: true),
      body: BlocBuilder<BreweryDetailCubit, BreweryDetailState>(
        builder: (context, state) => switch (state) {
          BreweryDetailLoading() => LoadingView(
            message: context.l10n.detailLoading,
          ),

          BreweryDetailNotFound() => StatusView(
            icon: AppIcons.error,
            headline: context.l10n.errBreweryNotFound,
            actions: [
              TextButton(
                onPressed: () => context.goNamed('feed'),
                child: Text(context.l10n.detailGoHome),
              ),
            ],
          ),

          BreweryDetailFailure(:final error, :final eventId) => DetailErrorView(
            error: error,
            eventId: eventId,
            onRetry: context.read<BreweryDetailCubit>().retry,
            onGoHome: () => context.goNamed('feed'),
          ),

          BreweryDetailSuccess(:final brewery) => _DetailContent(
            brewery: brewery,
          ),
        },
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.brewery});
  final Brewery brewery;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final contact = brewery.contact;

    return ListView(
      padding: const .all(AppSpacing.containerPadding),
      children: [
        _MapHero(brewery: brewery),
        const Gap.block(),

        DetailInfoCard(
          icon: AppIcons.location,
          label: context.l10n.detailAddress,
          value: _addressText,
          onTap: () {
            final c = brewery.address.coordinates;
            _launch(
              context,
              Uri.parse(
                'https://www.google.com/maps/search/?api=1&query=${c.latitude},${c.longitude}',
              ),
            );
          },
        ),
        const Gap.group(),

        if (contact.phone case final phone?) ...[
          DetailInfoCard(
            icon: AppIcons.phone,
            iconBackground: colors.secondaryContainer,
            iconForeground: colors.onSecondaryContainer,
            label: context.l10n.detailPhone,
            value: phone,
            onTap: () => _launch(context, Uri.parse('tel:$phone')),
          ),
          const Gap.group(),
        ],

        if (contact.websiteUrl case final web?) ...[
          DetailInfoCard(
            icon: AppIcons.website,
            iconBackground: colors.tertiaryContainer,
            iconForeground: colors.onTertiaryContainer,
            label: context.l10n.detailWebsite,
            value: web,
            onTap: () => _launch(context, _webUri(web)),
          ),
          const Gap.group(),
        ],
      ],
    );
  }

  String get _addressText {
    final a = brewery.address;
    final cityLine = [a.city, a.stateProvince, a.postalCode].joinNonEmpty();
    return [...a.lines, cityLine, a.country].joinNonEmpty('\n') ?? '';
  }
}

class _MapHero extends StatelessWidget {
  const _MapHero({required this.brewery});
  final Brewery brewery;

  @override
  Widget build(BuildContext context) {
    final b = Theme.of(context).brightness;

    return SizedBox(
      height: 260,
      child: ClipRRect(
        borderRadius: .circular(AppRadius.xl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: _staticMapUrl(brewery.address.coordinates, b),
              placeholder: (_, _) => const Skeleton(),
              errorWidget: (_, _, _) => const SizedBox.shrink(),
              imageBuilder: (context, imageProvider) => Semantics(
                identifier: 'detail_map',
                image: true,
                child: Image(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    context.colors.scrim.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              left: AppSpacing.gutter,
              right: AppSpacing.gutter,
              bottom: AppSpacing.gutter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CategoryChip(label: brewery.breweryType.label),
                  const Gap.group(),
                  AppText.headlineLgMobile(
                    brewery.name,
                    color: Colors.white.withValues(alpha: 0.9),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launch(BuildContext context, Uri uri) async {
  final messenger = ScaffoldMessenger.of(context);
  final errorText = context.l10n.detailLaunchError;

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    messenger.showSnackBar(SnackBar(content: Text(errorText)));
  }
}

Uri _webUri(String url) =>
    Uri.parse(url.startsWith('http') ? url : 'https://$url');

String _staticMapUrl(GeoCoordinates c, Brightness brightness) {
  final style = brightness == Brightness.dark ? 'dark-v11' : 'light-v11';
  return 'https://api.mapbox.com/styles/v1/mapbox/$style/static/'
      'pin-s+d97706(${c.longitude},${c.latitude})/'
      '${c.longitude},${c.latitude},14/600x300@2x'
      '?access_token=${Env.mapboxAccessToken}';
}

extension on BreweryType {
  String get label =>
      name.isEmpty ? name : '${name[0].toUpperCase()}${name.substring(1)}';
}
