import 'package:async/async.dart';

import '../../../common/base/pagination.dart';
import '../../../common/base/usecase.dart';
import '../../entity/playlist/playlist_entity.dart';
import '../../repository/search_repository.dart';

class SearchUsecase implements UseCase<Pagination<PlaylistEntity>, SearchUsecaseParams> {
  final SearchRepository _repository;

  const SearchUsecase({required SearchRepository repository}) : _repository = repository;

  @override
  Future<Result<Pagination<PlaylistEntity>>> call(param) {
    return _repository.search(
      query: param.query,
      type: param.type.map((type) => type.value).toList(),
      limit: param.limit,
      offset: param.offset,
    );
  }
}

enum SearchType {
  album('album'),
  artist('artist'),
  playlist('playlist'),
  track('track');

  final String value;

  const SearchType(this.value);
}

class SearchUsecaseParams {
  final List<SearchType> type;
  final String query;
  final int limit;
  final int offset;

  const SearchUsecaseParams({
    required this.type,
    required this.query,
    required this.limit,
    required this.offset,
  });
}
