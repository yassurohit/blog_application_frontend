import 'dart:convert';
import 'package:blog_flutter/helpers/print_debug.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> sendOTPApiCall(String email) async {
  List<dynamic> apiResponse = [];
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://192.168.29.136:8000/users/login/send-otp'));
    request.body = json.encode({"email": email});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      apiResponse.add(true);
      PrintUtils.debug("Successfully sended OTP");
    } else {
      apiResponse.add(false);
      PrintUtils.debug("Failed to send OTP");
    }
  } catch (e) {
    PrintUtils.debug("error in login api:$e");
  }

  return apiResponse;
}
