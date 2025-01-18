import 'package:blog_flutter/models/blog_model.dart';

abstract class BlogState {}

class LoadedState extends BlogState {}

class LoadingState extends BlogState {}

class FetchPostsState extends BlogState {
  final List<BlogPost> posts;
  FetchPostsState({required this.posts});
}
