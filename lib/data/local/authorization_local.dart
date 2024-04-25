import 'package:realm/realm.dart';

import 'realm/credential_rmodel.dart';

class AuthorizationLocal {
  final Realm _realm;

  const AuthorizationLocal({required Realm realm}) : _realm = realm;

  Future<void> saveToken(String token) async {
    var credential = CredentialRModel('user', token);
    _realm.write(() {
      _realm.add(credential, update: true);
    });
  }

  Future<String?> getToken() async {
    var credential = _realm.all<CredentialRModel>().firstOrNull;
    return credential?.token;
  }

  Future<void> deleteToken() async {
    _realm.write(() {
      _realm.deleteAll<CredentialRModel>();
    });
  }
}
