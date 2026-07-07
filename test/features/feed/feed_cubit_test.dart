import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/features/020_feed/application/feed_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockBreweryRepository extends Mock implements BreweryRepository {}

class _MockLocationRepository extends Mock implements LocationRepository {}

class _MockIpLocationRepository extends Mock implements IpLocationRepository {}

class _FakeErrorReporter implements ErrorReporter {
  @override
  String reportError(
    Object e,
    StackTrace st, {
    Map<String, Object?>? context,
  }) => 'bf-test';
  @override
  void addBreadcrumb(
    String message, {
    String? category,
    Map<String, Object?>? data,
  }) {}
}

void main() {
  late _MockBreweryRepository repository;
  late _MockLocationRepository locationRepository;
  late _MockIpLocationRepository ipLocationRepository;
  late _FakeErrorReporter errorReporter;

  final position = GeoCoordinates.raw(latitude: 43.6532, longitude: -79.3832);
  final brewery = Brewery.raw(
    id: '1',
    name: 'Test Brewery',
    breweryType: BreweryType.micro,
    city: 'Toronto',
    latitude: 43.6,
    longitude: -79.4,
    websiteUrl: 'https://example.com',
  );

  setUp(() {
    repository = _MockBreweryRepository();
    locationRepository = _MockLocationRepository();
    ipLocationRepository = _MockIpLocationRepository();
    errorReporter = _FakeErrorReporter();
    when(
      () => locationRepository.getPosition(),
    ).thenAnswer((_) async => position);
  });

  FeedCubit buildCubit() => FeedCubit(
    repository: repository,
    locationRepository: locationRepository,
    ipLocationRepository: ipLocationRepository,
    errorReporter: errorReporter,
  );

  test(
    'Loading to Success: emits FeedOk with the repository breweries',
    () async {
      when(
        () => repository.getAll(page: 1, perPage: 10, near: position),
      ).thenAnswer((_) async => ([brewery], false));

      final cubit = buildCubit();
      addTearDown(cubit.close);

      expect(cubit.state, isA<FeedLoading>());
      await expectLater(
        cubit.stream,
        emits(
          isA<FeedOk>()
              .having((s) => s.breweries, 'breweries', [brewery])
              .having(
                (s) => s.paginationStatus,
                'paginationStatus',
                PaginationStatus.reachedEnd,
              ),
        ),
      );
    },
  );

  test(
    'Loading to Error: emits FeedError when the repository throws',
    () async {
      when(
        () => repository.getAll(page: 1, perPage: 10, near: position),
      ).thenThrow(NetworkEx());

      final cubit = buildCubit();
      addTearDown(cubit.close);

      expect(cubit.state, isA<FeedLoading>());
      await expectLater(cubit.stream, emits(isA<FeedError>()));
    },
  );
}
