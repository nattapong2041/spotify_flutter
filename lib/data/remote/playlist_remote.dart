import 'package:async/async.dart';
import 'package:dio/dio.dart';

import 'response/error_response.dart';
import 'response/playlist/playlist_detail_response.dart';
import 'response/playlist/playlist_feature_response.dart';
import 'response/playlist/playlist_me_response.dart';
import 'response/playlist/playlist_response.dart';

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

  Future<Result<PlaylistMeResponse>> getMeList(
      {required int limit, required int offset}) async {
    try {
      final result = await _dio.get(
        '/v1/me/playlists',
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
      );

      return Result.value(PlaylistMeResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }    
  }

  Future<Result<PlaylistResponse>> createPlaylist({
    required String userId,
    required String name,
    String? description,
    bool public = false,
  }) async {
    try {
      final result = await _dio.post(
        '/v1/users/$userId/playlists',
        data: {
          'name': name,
          'description': description,
          'public': public,
        },
      );

      return Result.value(PlaylistResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }    
  }

  Future<Result<PlaylistDetailResponse>> getById({required String id}) async {
    try {
      final result = await _dio.get(
        '/v1/playlists/$id',
      );

      return Result.value(PlaylistDetailResponse.fromJson(result.data));
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }    
  }

  Future<Result<String>> addItem({
    required String playlistId,
    List<String>? uri,
    int position = 0,
    
  }) async {
    try {
      final result = await _dio.post(
        '/v1/playlists/$playlistId/tracks',
        data: {
          'uris': uri,
          'position': position,
        },
      );

      return Result.value(result.data['snapshot_id']);
    } on DioException catch (e) {
      return Result.error(ErrorResponse.fromJson(e.response!.data['error']).message ?? "");
    } catch (e) {
      return Result.error(ErrorResponse(message: e.toString()));
    }    
  }
}
