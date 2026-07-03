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
  }) = FeedOk;
}

@injectable
class FeedCubit extends Cubit<FeedState> {
  static const _perPage = 10;
  bool _isFetchingNextPage = false;

  final BreweryRepository _repository;
  final ErrorReporter _errorReporter;

  FeedCubit({required this._repository, required this._errorReporter})
    : super(const FeedLoading()) {
    _onStart();
  }

  Future<void> _onStart() async {
    try {
      final breweries = await _repository.getAll(page: 1, perPage: _perPage);
      emit(
        FeedOk(
          breweries: breweries,
          currentPage: 1,
          paginationStatus: breweries.length < _perPage
              ? PaginationStatus.reachedEnd
              : PaginationStatus.idle,
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
      final newBreweries = await _repository.getAll(
        page: nextPage,
        perPage: _perPage,
      );

      final newState = state.copyWith(
        breweries: [...state.breweries, ...newBreweries],
        currentPage: nextPage,
        paginationStatus: newBreweries.length < _perPage
            ? PaginationStatus.reachedEnd
            : PaginationStatus.idle,
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
