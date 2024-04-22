import 'package:dio/dio.dart';


class AuthorizationRemote {
  final Dio _dio;

  const AuthorizationRemote({required Dio dio}) : _dio = dio;

  final clientId = '5b857c8a015845d492da0accd529b596';
  final clientSecret = '8e15bf38ad3147edbad4cbfffec7761e';

  final scope = 'user-read-private user-read-email';

  Future<String?> login() async {
    final response = await _dio.post('/api/token', data: {
      'grant_type': 'client_credentials',
      'client_id': clientId,
      'client_secret': clientSecret
    });
    
    return response.data['access_token'];
  }
}
