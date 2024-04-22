import 'package:async/async.dart';

import '../../common/base/pagination.dart';
import '../entity/playlist/playlist_entity.dart';

abstract interface class SearchRepository {
  Future<Result<Pagination<PlaylistEntity>>> search({
    required String query,
    required List<String> type,
    required int limit,
    required int offset,
  });
}
