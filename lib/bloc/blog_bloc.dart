import 'dart:convert';

import 'package:blog_flutter/apis/get_posts.dart';
import 'package:blog_flutter/bloc/blog_event.dart';
import 'package:blog_flutter/bloc/blog_state.dart';
import 'package:blog_flutter/models/blog_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  List<BlogPost> posts = [];
  BlogBloc() : super(LoadingState()) {
    on<FetchPostsEvent>(_onFetchPostsEvent);
  }

  Future<void> _onFetchPostsEvent(
      FetchPostsEvent event, Emitter<BlogState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cachedPosts = prefs.getString('blogPosts');
    if (cachedPosts != null) {
      posts = List.from((json.decode(cachedPosts) as List)
          .map((data) => BlogPost.fromRawJson(json.encode(data)))
          .toList());
      print("lenth:${posts.length}");
      emit(FetchPostsState(posts: posts));
    }

    List<dynamic> result = await getPostsApiCall();
    if (result[0]) {
      List<BlogPost> fetchedPosts = result[1];
      List<BlogPost> newPosts = fetchedPosts.where((newPost) {
        return !posts
            .any((existingPost) => existingPost.title == newPost.title);
      }).toList();
      if (newPosts.isNotEmpty) {
        posts.addAll(newPosts);
        await prefs.setString(
            'blogPosts',
            json.encode(
                posts.map((post) => json.decode(post.toRawJson())).toList()));
        print(":$posts");
        emit(FetchPostsState(posts: posts));
      }
    }
  }
}
