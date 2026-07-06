import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:brewery_forest/core/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'search_bloc.freezed.dart';

class SearchQueryChanged {
  final String query;

  SearchQueryChanged(this.query);
}

EventTransformer<T> debounceRestartable<T>(Duration duration) {
  return (events, mapper) {
    final debouncedEvents = events.debounce(duration);
    return restartable<T>()(debouncedEvents, mapper);
  };
}

@freezed
sealed class SearchState with _$SearchState {
  const factory SearchState.idle() = SearchIdle;
  const factory SearchState.loading() = SearchLoading;
  const factory SearchState.failure({required AppEx error}) = SearchFailure;
  const factory SearchState.success({required List<Brewery> breweries}) =
      SearchSuccess;
}

@injectable
class SearchBloc extends Bloc<SearchQueryChanged, SearchState> {
  final BreweryRepository _repository;
  final ErrorReporter _errorReporter;
  CancelToken? _cancelToken;

  SearchBloc({required this._repository, required this._errorReporter})
    : super(SearchState.idle()) {
    on<SearchQueryChanged>(
      _onQueryChanged,
      transformer: debounceRestartable(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onQueryChanged(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    _cancelToken?.cancel('canceled by newer query');

    final query = event.query;

    if (query.isEmpty || query.length < 5) {
      emit(const SearchState.idle());
      return;
    }

    _cancelToken = CancelToken();

    emit(const SearchState.loading());

    try {
      final breweries = await _repository.search(
        query,
        cancelToken: _cancelToken,
      );

      if (breweries == null) return;

      emit(SearchState.success(breweries: breweries));
    } on AppEx catch (e, st) {
      _errorReporter.reportError(e, st);
      emit(SearchState.failure(error: e));
    }
  }
}
