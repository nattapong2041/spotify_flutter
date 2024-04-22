import 'package:async/async.dart';

import '../../common/base/pagination.dart';
import '../entity/playlist/playlist_entity.dart';
import '../entity/track_entity.dart';

abstract interface class PlaylistRepository {
  Future<Result<(String message, Pagination<PlaylistEntity>)>> getFeatureList({
    required int limit,
    required int offset,
  });

  Future<Result<Pagination<PlaylistEntity>>> getMeList({
    required int limit,
    required int offset,
  });

  Future<Result<Pagination<TrackEntity>>> trackList(
      {required String id, required int limit, required int offset});

  Future<Result<PlaylistEntity>> create({
    required String userId,
    required String name,
    required String description,
    bool public = false,
  });

  Future<Result<String>> addItem({
    required List<String> uri,
    required String playlistId,
  });
}
