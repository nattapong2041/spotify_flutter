import 'package:async/async.dart';

import '../../../common/base/usecase.dart';
import '../../repository/authorization_repository.dart';

class LoginUseCase implements UseCase<String, void> {
  final AuthorizationRepository _repository;

  LoginUseCase({
    required AuthorizationRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<String>> call(void param)async {
    return await _repository.login();
  }

  
}