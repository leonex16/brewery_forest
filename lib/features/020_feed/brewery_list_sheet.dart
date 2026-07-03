import 'package:brewery_forest/core/index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BreweryListSheet extends StatelessWidget {
  const BreweryListSheet({
    super.key,
    required this.breweries,
    required this.scrollController,
  });

  final List<Brewery> breweries;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ListView.builder(
        controller: scrollController,
        itemCount: breweries.length,
        itemBuilder: (context, index) {
          final brewery = breweries[index];
          return ListTile(
            title: Text(brewery.name),
            subtitle: Text(brewery.breweryType.name),
            onTap: () => context.goNamed(
              'brewery-detail',
              pathParameters: {'id': brewery.id},
            ),
          );
        },
      ),
    );
  }
}
