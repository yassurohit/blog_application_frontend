import 'dart:convert';
import 'package:blog_flutter/helpers/print_debug.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> signUpApiCall(
    String username, String email, String password) async {
  List<dynamic> apiResponse = [];
  print("username:$username");
  print("email:$email");
  print("password:$password");
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/users/register/'));
    request.body = json
        .encode({"username": username, "email": email, "password": password});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('response:${await response.stream.bytesToString()}');
    if (response.statusCode == 201) {
      PrintUtils.debug("successfully created Account");
      apiResponse.add(true);
      apiResponse.add(await response.stream.bytesToString());
    } else {
      PrintUtils.debug("Failed to create to Account");
      apiResponse.add(false);
    }
  } catch (e) {
    PrintUtils.debug("error in login api:$e");
  }
  return apiResponse;
}
