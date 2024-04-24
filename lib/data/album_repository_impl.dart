import 'package:async/async.dart';

import '../common/base/pagination.dart';
import '../domain/entity/playlist/playlist_detail_entity.dart';
import '../domain/entity/track_entity.dart';

import '../domain/repository/album_repository.dart';
import 'remote/album_remote.dart';
import 'remote/response/track_response.dart';

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumRemote _remote;

  const AlbumRepositoryImpl({required AlbumRemote remote}) : _remote = remote;

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
            description: data.albumType,
            owner: data.artists?.map((e) => e.name).join(", "),
            image: data.images!.first.url!,
            coverImage: data.images!.first.url,
            genres: data.genres!.map((e) => e).toList(),
            tracks: data.tracks?.items
                    ?.map(
                      (e) => e.toEntity(),
                    )
                    .toList() ??
                [],
          ),
        );
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
}
