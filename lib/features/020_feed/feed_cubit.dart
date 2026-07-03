import 'package:brewery_forest/core/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

sealed class FeedState {}

final class FeedLoading extends FeedState {}

final class FeedReady extends FeedState {
  final List<Brewery> breweries;

  FeedReady({required this.breweries});
}

final class FeedError extends FeedState {
  final AppEx error;

  FeedError({required this.error});
}

@injectable
class FeedCubit extends Cubit<FeedState> {
  final BreweryRepository _repository;
  final ErrorReporter _errorReporter;

  FeedCubit({required this._repository, required this._errorReporter})
    : super(FeedLoading()) {
    _onStart();
  }

  Future<void> _onStart() async {
    try {
      final breweries = await _repository.getAll();
      emit(FeedReady(breweries: breweries));
    } on AppEx catch (e, st) {
      _errorReporter.reportError(e, st);
      emit(FeedError(error: e));
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
