import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:teamvisual/presentation/utils/app_constants.dart';

Future<Response> sendRequest({
  required String endPoint,
  required Object body,
  required Client client,
  }) async {
    final url = AppConstants.baseUrl + endPoint;
    final Uri uri = Uri.parse(url);
    log(url);
    log(body.toString());
    final response = await client.post(
      uri,
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: body,
    );

    log(response.body);
    return response;
  }