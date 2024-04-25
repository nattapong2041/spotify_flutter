
import 'package:async/async.dart';

import '../../../common/base/usecase.dart';
import '../../repository/playlist_repository.dart';

class AddItemToPlaylistListUsecase implements UseCase<String, AddItemToPlaylistListUsecaseParams>{
  final PlaylistRepository _repository;

  AddItemToPlaylistListUsecase({required PlaylistRepository repository}) : _repository = repository;

  @override
  Future<Result<String>> call(AddItemToPlaylistListUsecaseParams param) {
    return _repository.addItem(
      uri: param.uris,
      playlistId: param.playlistId,
    );
  }
}

class AddItemToPlaylistListUsecaseParams {
  final List<String> uris;
  final String playlistId;

  const AddItemToPlaylistListUsecaseParams({
    required this.playlistId,
    required this.uris,
  });
}