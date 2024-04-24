import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'response/error_response.dart';
import 'response/search/search_response.dart';

class SearchRemote {
  final Dio _dio;

  const SearchRemote({required Dio dio}) : _dio = dio;

  Future<Result<SearchResponse>> search({
    required String query,
    required List<String> type,
    required int limit,
    required int offset,
  }) async {
    try {
      final result = await _dio.get(
        '/v1/search',
        queryParameters: {
          'q': query,
          'limit': limit,
          'offset': offset,
          'type': type,
        },
      );

      return Result.value(SearchResponse.fromJson(result.data['albums']));
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }
  }
}
