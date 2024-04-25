import 'package:dio/dio.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

import '../../common/config/config.dart';

class AuthorizationRemote {
  final Dio _dio;

  AuthorizationRemote({required Dio dio}) : _dio = dio;

  final clientId = '5b857c8a015845d492da0accd529b596';
  final clientSecret = '8e15bf38ad3147edbad4cbfffec7761e';

  final List<String> scope = [
    'user-read-private',
    'user-read-email',
    'playlist-modify-public',
    'playlist-modify-private',
    'playlist-read-private'
  ];

  // Future<Uri> login() async {
  //   var client = await authorizationUrl();

  //   return client;
  // }

  Future<Uri> authorizationUrl() async {
    var grant = oauth2.AuthorizationCodeGrant(
        clientId,
        Uri.parse('https://accounts.spotify.com/authorize'),
        Uri.parse('https://accounts.spotify.com/api/token'),
        secret: clientSecret, getParameters: (mediaType, text) {
      return {'response_type': 'code'};
    });

    var authorizationUrl = grant.getAuthorizationUrl(Uri.parse(Config.redirectUrl), scopes: scope);

    return authorizationUrl;
  }
}
