import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'response/error_response.dart';
import 'response/playlist/playlist_feature_response.dart';

class PlaylistRemote {
  final Dio _dio;

  const PlaylistRemote({required Dio dio}) : _dio = dio;

  Future<Result<PlaylistFeatureResponse>> getFeatureList(
      {required int limit, required int offset}) async {
    try {
      final result = await _dio.get(
        '/v1/browse/featured-playlists',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      return Result.value(PlaylistFeatureResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }    
  }
}
