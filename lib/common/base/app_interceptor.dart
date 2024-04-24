import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

import '../../data/local/realm/credential_rmodel.dart';
import '../../domain/usecase/authorization/login_usecase.dart';
import '../config/config.dart';

class AppInterceptor extends Interceptor {
  final Dio dio;

  const AppInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.baseUrl.contains(Config.accountUrl) == false) {
      var token = GetIt.instance.get<Realm>().all<CredentialRModel>().firstOrNull?.token;

      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await GetIt.instance.get<LoginUseCase>().call(null).then((value) {
        _retry(err.requestOptions).then((value) => handler.resolve(value));
      });
      return;
    }
    handler.next(err);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
