import 'package:brewery_forest/core/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'feed_cubit.freezed.dart';

enum PaginationStatus { idle, loadingMore, error, reachedEnd }

@freezed
sealed class FeedState with _$FeedState {
  const factory FeedState.loading() = FeedLoading;
  const factory FeedState.error({required AppEx error}) = FeedError;

  const factory FeedState.ok({
    required List<Brewery> breweries,
    required int currentPage,
    @Default(PaginationStatus.idle) PaginationStatus paginationStatus,
    AppEx? paginationError,
    GeoCoordinates? userPosition,
  }) = FeedOk;
}

@injectable
class FeedCubit extends Cubit<FeedState> {
  static const _perPage = 10;
  bool _isFetchingNextPage = false;

  final BreweryRepository _repository;
  final LocationRepository _locationRepository;
  final ErrorReporter _errorReporter;

  FeedCubit({
    required this._repository,
    required this._locationRepository,
    required this._errorReporter,
  }) : super(const FeedLoading()) {
    _onStart();
  }

  Future<void> refreshLocation() async {
    emit(const FeedLoading());
    await _onStart();
  }

  Future<void> _onStart() async {
    GeoCoordinates? position;

    try {
      position = await _locationRepository.getPosition();
    } on LocationUnavailableEx catch (e, st) {
      _errorReporter.reportError(e, st);
    }

    try {
      final (breweries, hasMore) = await _repository.getAll(
        page: 1,
        perPage: _perPage,
        near: position,
      );
      emit(
        FeedOk(
          breweries: breweries,
          currentPage: 1,
          userPosition: position,
          paginationStatus: hasMore
              ? PaginationStatus.idle
              : PaginationStatus.reachedEnd,
        ),
      );
    } on AppEx catch (e, st) {
      _errorReporter.reportError(e, st);
      emit(FeedError(error: e));
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
      final (newBreweries, hasMore) = await _repository.getAll(
        page: nextPage,
        perPage: _perPage,
        near: state.userPosition,
      );

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

  Future<List<Brewery>> search({required String query}) async {
    if (query.isEmpty || query.length < 3) {
      return [];
    }

    try {
      final breweries = await _repository.search(query);
      return breweries;
    } on AppEx catch (e, st) {
      _errorReporter.reportError(e, st, context: {'query': query});
      emit(FeedError(error: e));
      return [];
    }
  }
}
