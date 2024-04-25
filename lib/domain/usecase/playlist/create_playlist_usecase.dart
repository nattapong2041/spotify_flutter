
import 'package:async/async.dart';

import '../../../common/base/usecase.dart';
import '../../entity/playlist/playlist_entity.dart';
import '../../repository/playlist_repository.dart';

class CreatePlaylistListUsecase implements UseCase<PlaylistEntity, CreatePlaylistListUsecaseParams>{
  final PlaylistRepository _repository;

  CreatePlaylistListUsecase({required PlaylistRepository repository}) : _repository = repository;

  @override
  Future<Result<PlaylistEntity>> call(CreatePlaylistListUsecaseParams param) {
    return _repository.create(
      userId: param.userId,
      name: param.title,
      description: param.description,
      public: param.isPublic,
    );
  }
}

class CreatePlaylistListUsecaseParams {
  final String userId;
  final String title;
  final String? description;
  final bool isPublic;

  const CreatePlaylistListUsecaseParams({
    required this.userId,
    required this.title,
    this.description,
    this.isPublic = false,
  });
}