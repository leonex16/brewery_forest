import 'package:brewery_forest/core/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

sealed class BreweryDetailState {}

final class BreweryDetailLoading extends BreweryDetailState {}

final class BreweryDetailReady extends BreweryDetailState {
  final Brewery brewery;

  BreweryDetailReady(this.brewery);
}

final class BreweryDetailNotFound extends BreweryDetailState {}

final class BreweryDetailError extends BreweryDetailState {
  final AppEx error;

  BreweryDetailError(this.error);
}

@injectable
final class BreweryDetailCubit extends Cubit<BreweryDetailState> {
  final BreweryRepository _repository;
  final ErrorReporter _errorReporter;
  final String id;

  BreweryDetailCubit(
    this._repository,
    this._errorReporter,
    @factoryParam this.id,
  ) : super(BreweryDetailLoading()) {
    _onStart();
  }

  Future<void> _onStart() async {
    try {
      final brewery = await _repository.getById(id);

      if (brewery == null) {
        emit(BreweryDetailNotFound());
        return;
      }

      emit(BreweryDetailReady(brewery));
    } on AppEx catch (e) {
      _errorReporter.reportError(
        e,
        StackTrace.current,
        context: {
          'breweryId': id,
          'cubit': 'BreweryDetailCubit',
          'method': '_onStart',
        },
      );
      emit(BreweryDetailError(e));
    }
  }
}
