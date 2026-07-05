import 'package:brewery_forest/core/index.dart';
import 'package:brewery_forest/shared/api/ipwhois/ipwhois_datasource.dart';
import 'package:brewery_forest/shared/api/ipwhois/models/ipwhois_mapper.dart';
import 'package:injectable/injectable.dart';

/// Resolves an approximate location from the device's public IP (ipwho.is),
/// the middle step of the GPS -> IP -> default location cascade.
abstract class IpLocationRepository {
  /// The IP-based location, or null when it can't be determined (unsuccessful
  /// response, or data that can't form a valid location). Throws [AppEx] on
  /// transport errors (mapped by the datasource).
  Future<IpLocation?> resolve();
}

@LazySingleton(as: IpLocationRepository)
final class IpWhoisLocationRepository implements IpLocationRepository {
  final IpWhoisDatasource _datasource;

  IpWhoisLocationRepository(this._datasource);

  @override
  Future<IpLocation?> resolve() async {
    final res = await _datasource.lookup();
    if (res == null) return null;

    try {
      return res.toEntity();
    } on DomainEx catch (_) {
      return null;
    }
  }
}
