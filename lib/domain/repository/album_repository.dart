import 'package:async/async.dart';

import '../../common/base/pagination.dart';
import '../entity/playlist/playlist_detail_entity.dart';
import '../entity/track_entity.dart';

abstract interface class AlbumRepository {
  Future<Result<PlaylistDetailEntity>> getById({required String id});
  Future<Result<Pagination<TrackEntity>>> trackList({required String id, required int limit, required int offset});
}