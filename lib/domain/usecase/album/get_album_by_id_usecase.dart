import 'package:async/async.dart';

import '../../../common/base/usecase.dart';
import '../../entity/playlist/playlist_detail_entity.dart';
import '../../repository/album_repository.dart';

class GetAlbumByIdUsecase
    implements UseCase<PlaylistDetailEntity, GetAlbumByIdUsecaseParams> {
  final AlbumRepository _repository;

  const GetAlbumByIdUsecase({required AlbumRepository repository})
      : _repository = repository;

  @override
  Future<Result<PlaylistDetailEntity>> call(param) {
    return _repository.getById(id: param.id);
  }
}

class GetAlbumByIdUsecaseParams {
  final String id;

  const GetAlbumByIdUsecaseParams({
    required this.id,
  });
}
