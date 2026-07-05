import 'package:brewery_forest/core/errors/error_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'brewery_detail_cubit.dart';

class BreweryDetailPage extends StatelessWidget {
  const BreweryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BreweryDetailCubit, BreweryDetailState>(
        builder: (context, state) => switch (state) {
          BreweryDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          BreweryDetailNotFound() => const Center(
            child: Text('Brewery not found'),
          ),
          BreweryDetailError(:final error) => Center(
            child: Text(userMessage(error)),
          ),
          BreweryDetailReady(:final brewery) => Center(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text("id: ${brewery.id}"),
                Text("name: ${brewery.name}"),
                Text("breweryType: ${brewery.breweryType}"),
                Text("address: ${brewery.address}"),
                Text("country: ${brewery.address.country}"),
                if (brewery.address.flagUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Image.network(
                      brewery.address.flagUrl!,
                      width: 48,
                      errorBuilder: (_, _, _) => const SizedBox.shrink(),
                    ),
                  ),
                Text("websiteUrl: ${brewery.contact.websiteUrl}"),
                Text("phone: ${brewery.contact.phone}"),
              ],
            ),
          ),
        },
      ),
    );
  }
}
