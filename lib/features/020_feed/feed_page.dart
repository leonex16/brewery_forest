import 'package:brewery_forest/features/020_feed/feed_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FeedCubit>();

    return Scaffold(
      appBar: AppBar(
        title: SearchAnchor(
          builder: (context, controller) {
            return SearchBar(
              controller: controller,
              hintText: 'Search breweries...',
              leading: const Icon(Icons.search),
              onTap: () => controller.openView(),
              onChanged: (_) => controller.openView(),
            );
          },
          suggestionsBuilder: ((context, controller) async {
            final queryResult = await cubit.search(query: controller.text);

            if (queryResult.isEmpty) {
              return const [ListTile(title: Text('Sin resultados'))];
            }

            return queryResult.map(
              (brewery) => ListTile(
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
            );
          }),
        ),
      ),

      body: BlocBuilder<FeedCubit, FeedState>(
        builder: (context, state) => switch (state) {
          FeedLoading() => const Center(child: CircularProgressIndicator()),
          FeedError(:final error) => Center(child: Text(error.message)),
          FeedReady(:final breweries) => ListView.separated(
            itemCount: breweries.length,
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (context, index) {
              final brewery = breweries[index];
              return ListTile(
                title: Text("${index + 1}. ${brewery.name}"),
                leading: const Icon(Icons.local_offer),
                subtitle: Text(
                  'breweryType: ${brewery.breweryType.name}, city: ${brewery.address?.city}, state: ${brewery.address?.stateProvince}',
                ),
                onTap: () => context.pushNamed(
                  'brewery-detail',
                  pathParameters: {'id': brewery.id},
                ),
              );
            },
          ),
        },
      ),
    );
  }
}
