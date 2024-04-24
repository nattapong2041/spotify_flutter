import 'package:async/async.dart';

import '../common/base/pagination.dart';
import '../domain/entity/playlist/playlist_entity.dart';

import '../domain/repository/search_repository.dart';
import 'remote/search_remote.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemote _remote;

  SearchRepositoryImpl({required SearchRemote remote}) : _remote = remote;

  @override
  Future<Result<Pagination<PlaylistEntity>>> search({required String query, required List<String> type, required int limit, required int offset}) async {
        try {
      final result = await _remote.search(
        query: query,
        type: type,
        limit: limit,
        offset: offset,
      );

      if (result.isValue) {
        final data = result.asValue!.value;
        return Result.value(
          Pagination(
            offset: data.offset!,
            limit: data.limit!,
            total: data.total!,
            hasNext: data.next != null,
            items: data.items?.map((e) => PlaylistEntity(
              id: e.id ?? "",
              title: e.name ?? "",
              description: e.albumType,
              owner: e.artists?.map((e) => e.name).join(", "),
              coverImage: e.images?.first.url
            )).toList() ?? []
          )
        );
      }

      return Result.error(result.asError!.error.toString());
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
