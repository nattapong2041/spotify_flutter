import 'package:async/async.dart';

import '../../../common/base/usecase.dart';
import '../../entity/playlist/playlist_detail_entity.dart';
import '../../repository/playlist_repository.dart';

class GetPlaylistByIdUsecase
    implements UseCase<PlaylistDetailEntity, GetPlaylistByIdUsecaseParams> {
  final PlaylistRepository _repository;

  GetPlaylistByIdUsecase({required PlaylistRepository repository}) : _repository = repository;

  @override
  Future<Result<PlaylistDetailEntity>> call(GetPlaylistByIdUsecaseParams param) {
    return _repository.getById(id: param.id);
  }
}

class GetPlaylistByIdUsecaseParams {
  final String id;

  const GetPlaylistByIdUsecaseParams({
    required this.id,
  });
}
