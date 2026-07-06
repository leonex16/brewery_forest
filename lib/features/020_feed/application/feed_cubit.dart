import 'package:brewery_forest/core/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'feed_cubit.freezed.dart';

enum PaginationStatus { idle, loadingMore, error, reachedEnd }

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState.loading() = FeedLoading;
  const factory FeedState.failure({required AppEx error}) = FeedError;

  const factory FeedState.success({
    required List<Brewery> breweries,
    required int currentPage,
    @Default(PaginationStatus.idle) PaginationStatus paginationStatus,
    AppEx? paginationError,
    GeoCoordinates? userPosition,
    GeoCoordinates? lastQueryCenter,
    @Default(LocationSource.none) LocationSource locationSource,
    IpLocation? ipLocation,
    Brewery? selectedBrewery,
  }) = FeedOk;
}

@injectable
class FeedCubit extends Cubit<FeedState> {
  static const _perPage = 10;
  bool _isFetchingNextPage = false;

  final BreweryRepository _repository;
  final LocationRepository _locationRepository;
  final IpLocationRepository _ipLocationRepository;
  final ErrorReporter _errorReporter;

  FeedCubit({
    required this._repository,
    required this._locationRepository,
    required this._ipLocationRepository,
    required this._errorReporter,
  }) : super(FeedState.loading()) {
    _onStart();
  }

  Future<void> refreshLocation() async {
    emit(FeedState.loading());
    await _onStart();
  }

  void selectBrewery(Brewery brewery) {
    final state = this.state;
    if (state is! FeedOk) return;
    emit(state.copyWith(selectedBrewery: brewery));
  }

  void clearSelection() {
    final state = this.state;
    if (state is! FeedOk || state.selectedBrewery == null) return;
    emit(state.copyWith(selectedBrewery: null));
  }

  Future<void> _onStart() async {
    GeoCoordinates? position;
    var locationSource = LocationSource.none;
    IpLocation? ipLocation;

    try {
      position = await _locationRepository.getPosition();
      locationSource = LocationSource.precise;
    } on LocationUnavailableEx catch (e, st) {
      _errorReporter.reportError(e, st);

      try {
        final approx = await _ipLocationRepository.resolve();
        if (approx != null) {
          position = approx.coordinates;
          locationSource = LocationSource.approximate;
          ipLocation = approx;
        }
      } on AppEx catch (e2, st2) {
        _errorReporter.reportError(e2, st2);
      }
    }

    try {
      final result = await _repository.getAll(
        page: 1,
        perPage: _perPage,
        near: position,
      );

      if (result == null) return;

      final (breweries, hasMore) = result;

      emit(
        FeedState.success(
          breweries: breweries,
          currentPage: 1,
          userPosition: position,
          lastQueryCenter: position,
          locationSource: locationSource,
          ipLocation: ipLocation,
          paginationStatus: hasMore
              ? PaginationStatus.idle
              : PaginationStatus.reachedEnd,
        ),
      );
    } on AppEx catch (e, st) {
      _errorReporter.reportError(e, st);
      emit(FeedState.failure(error: e));
    }
  }

  Future<void> loadNextPage() async {
    final state = this.state;

    if (_isFetchingNextPage) return;
    if (state is! FeedOk) return;
    if (state.paginationStatus == .reachedEnd) return;

    _isFetchingNextPage = true;

    emit(state.copyWith(paginationStatus: .loadingMore, paginationError: null));

    try {
      final nextPage = state.currentPage + 1;
      final result = await _repository.getAll(
        page: nextPage,
        perPage: _perPage,
        near: state.lastQueryCenter,
      );

      if (result == null) return;

      final (newBreweries, hasMore) = result;

      final newState = state.copyWith(
        breweries: [...state.breweries, ...newBreweries],
        currentPage: nextPage,
        paginationStatus: hasMore
            ? PaginationStatus.idle
            : PaginationStatus.reachedEnd,
        paginationError: null,
      );

      emit(newState);
    } on AppEx catch (e, st) {
      _errorReporter.reportError(
        e,
        st,
        context: {'per_page': _perPage, 'current_page': state.currentPage},
      );

      final newState = state.copyWith(
        paginationStatus: .error,
        paginationError: e,
      );

      emit(newState);
    } finally {
      _isFetchingNextPage = false;
    }
  }

  Future<void> searchArea(GeoCoordinates target) async {
    if (state is! FeedOk) return;

    final current = state as FeedOk;

    emit(FeedState.loading());

    try {
      final result = await _repository.getAll(
        page: 1,
        perPage: _perPage,
        near: target,
      );
      if (result == null) return;
      final (breweries, hasMore) = result;

      emit(
        FeedState.success(
          breweries: breweries,
          currentPage: 1,
          userPosition: current.userPosition,
          locationSource: current.locationSource,
          ipLocation: current.ipLocation,
          lastQueryCenter: target,
          paginationStatus: hasMore
              ? PaginationStatus.idle
              : PaginationStatus.reachedEnd,
        ),
      );
    } on AppEx catch (e, st) {
      _errorReporter.reportError(e, st);
      emit(FeedState.failure(error: e));
    }
  }
}
