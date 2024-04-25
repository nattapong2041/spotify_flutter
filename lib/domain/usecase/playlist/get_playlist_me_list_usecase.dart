
import 'package:async/async.dart';

import '../../../common/base/pagination.dart';
import '../../../common/base/usecase.dart';
import '../../entity/playlist/playlist_entity.dart';
import '../../repository/playlist_repository.dart';

class GetPlaylistMeListUsecase implements UseCase<(String userId, Pagination<PlaylistEntity>), GetPlaylistMeListUsecaseParams>{
  final PlaylistRepository _repository;

  GetPlaylistMeListUsecase({required PlaylistRepository repository}) : _repository = repository;

  @override
  Future<Result<(String userId, Pagination<PlaylistEntity>)>> call(GetPlaylistMeListUsecaseParams param) {
    return _repository.getMeList(
      limit: param.limit,
      offset: param.offset,
    );
  }
}

class GetPlaylistMeListUsecaseParams {
  final int limit;
  final int offset;

  const GetPlaylistMeListUsecaseParams({
    required this.limit,
    required this.offset
  });
}