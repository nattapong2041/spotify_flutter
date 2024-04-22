import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';

import '../../data/local/realm/credential_rmodel.dart';
import '../base/app_interceptor.dart';
import '../config/config.dart';
import 'app_dependency_injection.dart';

class AppSettingInjection {
  static void inject() {
    BaseOptions options = BaseOptions(baseUrl: Config.apiService, headers: {
      // "Authorization": Config.apiKey,
    });
    BaseOptions accountOptions = BaseOptions(baseUrl: Config.accountUrl, headers: {
      // "Authorization": Config.apiKey,
    }, contentType: Headers.formUrlEncodedContentType);
    final dio = Dio(options);
    final accountDio = Dio(accountOptions);
    injector.pushNewScope(
        scopeName: 'App Setting',
        init: (GetIt getIt) {
          getIt.registerLazySingleton<Realm>(() => Realm(Configuration.local(
                [
                  CredentialRModel.schema,
                ],
                schemaVersion: Config.realmVersion,
              )));
          getIt.registerLazySingleton<Dio>(
            () => dio
              ..interceptors.add(AppInterceptor(dio))
              ..interceptors.add(LogInterceptor(responseBody: true)),
          );
          getIt.registerLazySingleton<Dio>(
              () => accountDio
                ..interceptors.add(AppInterceptor(accountDio))
                ..interceptors.add(LogInterceptor(responseBody: true)),
              instanceName: 'account');
        });
  }
}
