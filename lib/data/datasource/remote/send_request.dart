import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

Future<Response> sendRequest({
  required String endPoint,
  required Object body,
  required Client client,
  }) async {
    debugPrint('REQUEST: '+body.toString());
    final url = AppConstants.baseUrl + endPoint;
    final Uri uri = Uri.parse(url);
    debugPrint(url);
    final response = await client.post(
      uri,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: body,
    ).timeout(const Duration(seconds: 30));

    debugPrint('RESPONSE: '+response.body);
    debugPrint(' ================================ '* 4);
    return response;
  }