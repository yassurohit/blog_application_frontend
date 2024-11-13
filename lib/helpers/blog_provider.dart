import 'dart:convert';

import 'package:blog_flutter/apis/get_posts.dart';
import 'package:blog_flutter/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogProvider with ChangeNotifier {
  List<BlogPost> _posts = [];

  List<BlogPost> get posts => _posts;

  Future<void> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedPosts = prefs.getString('blogPosts');
    if (cachedPosts != null) {
      _posts = (json.decode(cachedPosts) as List)
          .map((data) => BlogPost.fromRawJson(json.encode(data)))
          .toList();
      notifyListeners();
    }

    List<dynamic> result = await getPostsApiCall();
    if (result[0]) {
      List<BlogPost> fetchedPosts = result[1];
      List<BlogPost> newPosts = fetchedPosts.where((newPost) {
        return !_posts
            .any((existingPost) => existingPost.title == newPost.title);
      }).toList();
      if (newPosts.isNotEmpty) {
        _posts.addAll(newPosts);
        await prefs.setString(
            'blogPosts',
            json.encode(
                _posts.map((post) => json.decode(post.toRawJson())).toList()));
        notifyListeners();
      }
    }
  }
}
