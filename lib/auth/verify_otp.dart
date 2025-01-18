import 'dart:convert';
import 'package:blog_flutter/helpers/print_debug.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> verifyOTPApicall(String email, String otp) async {
  List<dynamic> apiResponse = [];
  try {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/users/login/verify-otp'));
    request.body = json.encode({"email": email, "otp": otp});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      apiResponse.add(true);
      String jsonResponseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(jsonResponseString);
      apiResponse.add(jsonResponse);
      PrintUtils.debug("OTP verified successfully");
    } else {
      apiResponse.add(false);
      PrintUtils.debug("Wrong otp! or something went wrong");
    }
  } catch (e) {
    PrintUtils.debug("error in login api:$e");
  }

  return apiResponse;
}
