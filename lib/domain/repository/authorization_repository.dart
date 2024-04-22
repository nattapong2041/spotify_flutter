import 'package:async/async.dart';

abstract interface class AuthorizationRepository {
  Future<Result<String>> login();
}