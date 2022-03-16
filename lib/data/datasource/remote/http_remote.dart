import 'dart:convert';

import 'package:teamvisual/data/datasource/remote/remote.dart';
import 'package:teamvisual/data/datasource/remote/send_request.dart';
import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:http/http.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';

class HttpRemote extends Remote {

  final Client _client;

  HttpRemote(this._client);

  @override
  Future<UserResponse> signIn(SignInEntity signInEntity) async {
    final response = await sendRequest(
        endPoint: "/login",
        body: signInEntity.toJson(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    // return (res['entries'] as List).map((e) =>
    //   //     UserResponse.fromMap(e)).toList();
    return UserResponse.fromMap(json);
  }

  @override
  Future<ValVersionResponse?> valVersion(ValVersionEntity valVersionEntity) async {
    final response = await sendRequest(
        endPoint: "/valVersion",
        body: valVersionEntity.toJson(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return ValVersionResponse.fromMap(json);
  }

  @override
  Future<SyncResponse?> sync(SyncEntity syncEntity) async {
    final response = await sendRequest(
        endPoint: "/sincronizar",
        body: syncEntity.toJson(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return SyncResponse.fromMap(json);
  }
}