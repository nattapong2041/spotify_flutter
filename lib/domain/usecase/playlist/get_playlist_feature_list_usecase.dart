
import 'package:async/async.dart';

import '../../../common/base/pagination.dart';
import '../../../common/base/usecase.dart';
import '../../entity/playlist/playlist_entity.dart';
import '../../repository/playlist_repository.dart';

class GetPlaylistFeatureListUsecase implements UseCase<(String message, Pagination<PlaylistEntity>), GetPlaylistFeatureListUsecaseParams>{
  final PlaylistRepository _repository;

  GetPlaylistFeatureListUsecase({required PlaylistRepository repository}) : _repository = repository;

  @override
  Future<Result<(String message, Pagination<PlaylistEntity>)>> call(GetPlaylistFeatureListUsecaseParams param) {
    return _repository.getFeatureList(
      limit: param.limit,
      offset: param.offset,
    );
  }
}

class GetPlaylistFeatureListUsecaseParams {
  final int limit;
  final int offset;

  const GetPlaylistFeatureListUsecaseParams({
    required this.limit,
    required this.offset
  });
}