import 'package:realm/realm.dart';

part 'credential_rmodel.realm.dart';

@RealmModel()
class _CredentialRModel {
  @PrimaryKey()
  late String id;
  
  late String token;
}