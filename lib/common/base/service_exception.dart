sealed class ServiceException implements Exception {
  final String _message;
  ServiceException({required String message}) : _message = message;

  String get message => _message;

  @override
  String toString() {
    return _message;
  }
}

final class ServerException<T> extends ServiceException {
  ServerException({
    String? message,
  }) : super(message: message ?? "Error while connect to server");
}

final class NoInternetConnectionException<T> extends ServiceException {
  NoInternetConnectionException({
    T? data,
  }) : super(message: "No internet connection");
}
