import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'response/album/album_response.dart';
import 'response/error_response.dart';

class AlbumRemote {
  final Dio _dio;

  const AlbumRemote({required Dio dio}) : _dio = dio;

  Future<Result<AlbumResponse>> getById({required String id}) async {
    try {
      final result = await _dio.get(
        '/v1/albums/$id',
      );

      return Result.value(AlbumResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }
  }
}
