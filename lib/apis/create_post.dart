import 'dart:convert';
import 'package:blog_flutter/helpers/print_debug.dart';
import 'package:blog_flutter/helpers/sharedPref_helper.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> createPostApiCall(String title, String content) async {
  String? token = SharedPrefsHelper().getString('token');
  List<dynamic> apiResponse = [];
  print("title:$title");
  print("content:$content");
  try {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request(
        'POST', Uri.parse('http://127.0.0.1:8000/blog/send-post/'));
    request.body = json.encode({"title": title, "content": content});
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 60));
    if (response.statusCode == 200) {
      PrintUtils.debug("Successfully created the post");
      apiResponse.add(true);
    } else {
      PrintUtils.debug("Failed to create the post");
      apiResponse.add(false);
    }
  } catch (e) {
    PrintUtils.debug("error in login api:$e");
  }

  return apiResponse;
}
