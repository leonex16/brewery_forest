import 'package:brewery_forest/core/network/dio_error_mapper.dart';
import 'package:brewery_forest/core/observability/logger.dart';
import 'package:brewery_forest/shared/api/ipwhois/models/ipwhois_res.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
final class IpWhoisDatasource {
  static const _endpoint = '/';

  final Dio _dio;
  final Logger _logger;

  IpWhoisDatasource(@Named('ipwho') this._dio, this._logger);

  Future<IpWhoisRes?> lookup({CancelToken? cancelToken}) async {
    try {
      final response = await _dio.get(_endpoint, cancelToken: cancelToken);
      final data = response.data;
      if (data is! Map<String, dynamic>) return null;

      return IpWhoisRes.fromJson(data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        _logger.debug('ipwhois lookup cancelled: ${e.message}');
        return null;
      }
      throw mapDioException(e);
    }
  }
}
