// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_rmodel.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CredentialRModel extends _CredentialRModel
    with RealmEntity, RealmObjectBase, RealmObject {
  CredentialRModel(
    String id,
    String token,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'token', token);
  }

  CredentialRModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get token => RealmObjectBase.get<String>(this, 'token') as String;
  @override
  set token(String value) => RealmObjectBase.set(this, 'token', value);

  @override
  Stream<RealmObjectChanges<CredentialRModel>> get changes =>
      RealmObjectBase.getChanges<CredentialRModel>(this);

  @override
  Stream<RealmObjectChanges<CredentialRModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CredentialRModel>(this, keyPaths);

  @override
  CredentialRModel freeze() =>
      RealmObjectBase.freezeObject<CredentialRModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'token': token.toEJson(),
    };
  }

  static EJsonValue _toEJson(CredentialRModel value) => value.toEJson();
  static CredentialRModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'token': EJsonValue token,
      } =>
        CredentialRModel(
          fromEJson(id),
          fromEJson(token),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CredentialRModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CredentialRModel, 'CredentialRModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('token', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
