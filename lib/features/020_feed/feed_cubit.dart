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

  FeedCubit({required this._repository}) : super(FeedLoading()) {
    _onStart();
  }

  Future<void> _onStart() async {
    try {
      final breweries = await _repository.getAll();
      emit(FeedReady(breweries: breweries));
    } on AppEx catch (e) {
      emit(FeedError(error: e));
    }
  }
}
