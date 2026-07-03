part of 'app_ex.dart';

sealed class ApplicationEx extends AppEx {
  ApplicationEx(super.message);
}

final class BreweryNotFoundEx extends ApplicationEx {
  BreweryNotFoundEx(String id) : super('Brewery not found: $id');
}
