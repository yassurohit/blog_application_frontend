import 'dart:convert';
import 'package:blog_flutter/helpers/print_debug.dart';
import 'package:blog_flutter/helpers/sharedPref_helper.dart';
import 'package:blog_flutter/models/blog_model.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getPostsApiCall() async {
  String? token = SharedPrefsHelper().getString('token');
  List<BlogPost> postObjects = [];
  List<dynamic> apiResponse = [];
  try {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('http://192.168.29.136:8000/blog/posts/'));
    request.headers.addAll(headers);
    http.StreamedResponse response =
        await request.send().timeout(const Duration(seconds: 100));
    if (response.statusCode == 200) {
      apiResponse.add(true);
      String jsonResponse = await response.stream.bytesToString();
      var results = json.decode(jsonResponse);
      if (results != null) {
        for (var result in results) {
          BlogPost post = BlogPost(
              title: result['title'] ?? '',
              content: result['content'] ?? '',
              author: result['author_name'] ?? '',
              postId: result['id'] ?? 0,
              image: result['image'] ?? '');
          postObjects.add(post);
        }
      }
      apiResponse.add(postObjects);
    } else {
      apiResponse.add(false);
      print(response.reasonPhrase);
    }
  } catch (e) {
    PrintUtils.debug("error in login api:$e");
  }

  return apiResponse;
}
