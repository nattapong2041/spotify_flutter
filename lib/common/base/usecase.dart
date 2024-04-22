
import 'package:async/async.dart';

abstract interface class UseCase<T, Param> {
  Future<Result<T>> call(Param param);
}