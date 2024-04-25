import 'package:async/async.dart';

import '../common/base/pagination.dart';
import '../domain/entity/playlist/playlist_detail_entity.dart';
import '../domain/entity/playlist/playlist_entity.dart';
import '../domain/entity/track_entity.dart';

import '../domain/repository/playlist_repository.dart';
import 'remote/playlist_remote.dart';
import 'remote/response/playlist/playlist_response.dart';
import 'remote/response/track_response.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  final PlaylistRemote _remote;

  PlaylistRepositoryImpl({required PlaylistRemote remote}) : _remote = remote;

  @override
  Future<Result<String>> addItem({required List<String> uri, required String playlistId}) {
    // TODO: implement addItem
    throw UnimplementedError();
  }

  @override
  Future<Result<PlaylistEntity>> create({
    required String userId,
    required String name,
    String? description,
    bool public = false,
  }) async {
    try {
      final result = await _remote.createPlaylist(
        userId: userId,
        name: name,
        description: description,
        public: public,
      );

      if (result.isValue) {
        final data = result.asValue!.value;
        return Result.value(data.toEntity());
      }

      return Result.error(result.asError!.error.toString());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<(String message, Pagination<PlaylistEntity>)>> getFeatureList(
      {required int limit, required int offset}) async {
    try {
      final result = await _remote.getFeatureList(limit: limit, offset: offset);

      if (result.isValue) {
        final data = result.asValue!.value;
        return Result.value((
          data.message ?? "",
          Pagination(
              offset: data.playlists!.offset!,
              limit: data.playlists!.limit!,
              total: data.playlists!.total!,
              hasNext: data.playlists?.next != null,
              items: data.playlists!.items?.map((e) => e.toEntity()).toList() ?? [])
        ));
      }

      return Result.error(result.asError!.error.toString());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<(String userId, Pagination<PlaylistEntity>)>> getMeList(
      {required int limit, required int offset}) async {
    try {
      final result = await _remote.getMeList(limit: limit, offset: offset);

      if (result.isValue) {
        final data = result.asValue!.value;
        final userId = data.href?.split("/")[5];
        return Result.value((
          userId!,
          Pagination(
              offset: data.offset!,
              limit: data.limit!,
              total: data.total!,
              hasNext: data.next != null,
              items: data.items?.map((e) => e.toEntity()).toList() ?? [])
        ));
      }

      return Result.error(result.asError!.error.toString());
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<Pagination<TrackEntity>>> trackList(
      {required String id, required int limit, required int offset}) {
    // TODO: implement trackList
    throw UnimplementedError();
  }

  @override
  Future<Result<PlaylistDetailEntity>> getById({required String id}) async {
    try {
      final result = await _remote.getById(id: id);

      if (result.isValue) {
        final data = result.asValue!.value;
        return Result.value(
          PlaylistDetailEntity(
            id: data.id ?? "",
            title: data.name ?? "",
            owner: data.owner?.displayName,
            image: data.images!.first.url!,
            coverImage: data.images!.first.url,
            genres: const [],
            tracks: data.tracks?.items?.map((e) => e.track!.toEntity()).toList() ?? [],
          ),
        );
      }

      return Result.error(result.asError!.error.toString());
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
