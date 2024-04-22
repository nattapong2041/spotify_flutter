import 'package:async/async.dart';

import '../domain/repository/authorization_repository.dart';
import 'local/authorization_local.dart';
import 'remote/authorization_remote.dart';

class AuthorizationRepositoryImpl implements AuthorizationRepository {
  final AuthorizationRemote _remote;
  final AuthorizationLocal _local;

  const AuthorizationRepositoryImpl({required AuthorizationLocal local ,required AuthorizationRemote remote})
      : _remote = remote, _local = local;

  @override
  Future<Result<String>> login() async {
    try {
      var result = await _remote.login();

      if (result != null) {
       await _local.saveToken(result);
      }

      return Result.value(result!);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
