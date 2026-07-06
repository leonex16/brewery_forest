import 'package:brewery_forest/core/domain/brewery.dart';
import 'package:brewery_forest/ui/index.dart';
import 'package:flutter/material.dart';

class DevGalleryPage extends StatelessWidget {
  const DevGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sample = Brewery.raw(
      id: 'sample',
      name: 'Oak & Amber Artisans',
      breweryType: BreweryType.micro,
      city: 'Portland',
      stateProvince: 'Oregon',
      countryCode: 'us',
      latitude: 45.5,
      longitude: -122.6,
      websiteUrl: 'https://oakandamber.com',
    );

    return Scaffold(
      appBar: const BfTopBar(title: 'DS Gallery', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.gutter),
        children: [
          const _Section('Tipografía'),
          const AppText.headlineXl('headline-xl'),
          const AppText.headlineLg('headline-lg'),
          const AppText.headlineLgMobile('headline-lg-mobile'),
          const AppText.headlineMd('headline-md'),
          const AppText.bodyLg('body-lg'),
          const AppText.bodyMd('body-md'),
          const AppText.labelMd('label-md'),
          const AppText.labelSm('label-sm'),

          const _Section('Icon circle + chip'),
          Row(
            children: [
              const IconCircle(icon: AppIcons.search),
              const SizedBox(width: AppSpacing.gutter),
              const IconCircle(icon: AppIcons.userPin, size: 64),
              const SizedBox(width: AppSpacing.gutter),
              const CategoryChip(label: 'Microbrewery'),
            ],
          ),

          const _Section('Brewery list item'),
          BreweryListItem(brewery: sample, onTap: () {}),

          const _Section('Sheet handle + skeleton'),
          const SheetHandle(),
          const SizedBox(height: AppSpacing.stackSm),
          Row(
            children: const [
              Skeleton(width: 120),
              SizedBox(width: AppSpacing.base),
              Expanded(child: Skeleton()),
            ],
          ),

          const _Section('Banner'),
          BfBanner(
            message: 'Approximate location by IP: Portland, US',
            onDismiss: () {},
          ),

          const _Section('Loading view'),
          const SizedBox(height: 160, child: LoadingView(message: 'Loading…')),

          const _Section('Status view'),
          SizedBox(
            height: 320,
            child: StatusView(
              icon: AppIcons.noResults,
              headline: 'No breweries found',
              body: 'Try a different search or clear your filters.',
              actions: [
                FilledButton(onPressed: () {}, child: const Text('Retry')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.stackMd,
        bottom: AppSpacing.stackSm,
      ),
      child: AppText.labelSm(title, color: context.colors.primary),
    );
  }
}
