import 'package:brewery_forest/core/di/injection.dart';
import 'package:brewery_forest/features/010_location_onboarding/location_onboarding_cubit.dart';
import 'package:brewery_forest/features/010_location_onboarding/location_onboarding_page.dart';
import 'package:brewery_forest/features/020_feed/feed_cubit.dart';
import 'package:brewery_forest/features/020_feed/feed_page.dart';
import 'package:brewery_forest/features/020_feed/search_bloc.dart';
import 'package:brewery_forest/features/030_brewery_detail/brewery_detail_cubit.dart';
import 'package:brewery_forest/features/030_brewery_detail/brewery_detail_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      name: 'location-onboarding',
      builder: (context, state) => BlocProvider(
        create: (_) => getIt<LocationOnboardingCubit>(),
        child: const LocationOnboardingPage(),
      ),
    ),

    GoRoute(
      path: "/feed",
      name: 'feed',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<FeedCubit>()),
          BlocProvider(create: (_) => getIt<SearchBloc>()),
        ],
        child: const FeedPage(),
      ),
    ),

    GoRoute(
      path: "/brewery-detail/:id",
      name: 'brewery-detail',
      builder: (context, state) => BlocProvider(
        create: (_) =>
            getIt<BreweryDetailCubit>(param1: state.pathParameters['id']!),
        child: const BreweryDetailPage(),
      ),
    ),
  ],
);
