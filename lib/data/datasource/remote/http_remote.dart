import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:teamvisual/data/datasource/remote/remote.dart';
import 'package:teamvisual/data/datasource/remote/send_request.dart';
import 'package:teamvisual/data/model/generic_response.dart';
import 'package:teamvisual/data/model/sync_response.dart';
import 'package:teamvisual/data/model/user_response.dart';
import 'package:http/http.dart';
import 'package:teamvisual/data/model/val_version_response.dart';
import 'package:teamvisual/domain/model/save_evaluation_entity.dart';
import 'package:teamvisual/domain/model/sign_in_entity.dart';
import 'package:teamvisual/domain/model/sync_entity.dart';
import 'package:teamvisual/domain/model/val_version_entity.dart';
import 'package:teamvisual/domain/model/assist_list_entity.dart';

class HttpRemote extends Remote {

  final Client _client;
  final Dio _dio;

  HttpRemote(this._client, this._dio);

  @override
  Future<UserResponse> signIn(SignInEntity signInEntity) async {
    final response = await sendRequest(
        endPoint: "/login",
        body: signInEntity.toRequest(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return UserResponse.fromMap(json);
  }

  @override
  Future<ValVersionResponse?> valVersion(ValVersionEntity valVersionEntity) async {
    final response = await sendRequest(
        endPoint: "/valVersion",
        body: valVersionEntity.toRequest(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return ValVersionResponse.fromMap(json);
  }

  @override
  Future<SyncResponse?> sync(SyncEntity syncEntity) async {
    final response = await sendRequest(
        endPoint: "/sincronizar",
        body: syncEntity.toRequest(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return SyncResponse.fromMap(json);
  }

  @override
  Future<GenericResponse?> sendAssist(AssistListEntity assists) async {
    final response = await sendRequest(
        endPoint: "/asistencia",
        body: assists.toRequest(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return GenericResponse.fromMap(json);
  }

  @override
  Future<GenericResponse?> sendEvaluations(
      SaveEvaluationListEntity evaluations) async {
    final response = await sendRequest(
        endPoint: "/evaluacion",
        body: evaluations.toRequest(),
        client: _client);

    final Map<String, dynamic> json = jsonDecode(response.body);
    return GenericResponse.fromMap(json);
  }

  @override
  Future<String> downloadFile(List<String> data) async {
    String filePath = '${data[2]}${data[1]}';
    try {
        await _dio.download(data[0], filePath,
            onReceiveProgress: (rec, total) {
              debugPrint("Rec: $rec , Total: $total");
        });
    } catch (e) {
      debugPrint("error download ${e.toString()}");
      filePath = "";
    }
    return filePath;
  }

}