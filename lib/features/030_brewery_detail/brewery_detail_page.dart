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
            child: Text(error.message),
          ),
          BreweryDetailReady(:final brewery) => Center(
            child: Text(brewery.name),
          ),
        },
      ),
    );
  }
}
