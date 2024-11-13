import 'dart:convert';
import 'package:blog_flutter/helpers/print_debug.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> loginApiCall(String username, String password) async {
  PrintUtils.debug("username:$username");
  PrintUtils.debug("password:$password");
  List<dynamic> apiResponse = [];
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.29.136:8000/users/login/'));
    request.body = json.encode({"email": username, "password": password});
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 60));
    PrintUtils.debug("response code:${response.statusCode}");
    if (response.statusCode == 200) {
      PrintUtils.debug('Success');
      apiResponse.add(true);
      apiResponse.add(await response.stream.bytesToString());
    } else {
      PrintUtils.debug('Fail');
      apiResponse.add(false);
    }
  } catch (e) {
    PrintUtils.debug("error in login api:$e");
  }

  return apiResponse;
}
