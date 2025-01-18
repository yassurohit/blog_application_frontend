import 'package:blog_flutter/bloc/blog_bloc.dart';
import 'package:blog_flutter/bloc/blog_event.dart';
import 'package:blog_flutter/bloc/blog_state.dart';
import 'package:blog_flutter/components/blog_cart.dart';
import 'package:blog_flutter/models/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State createState() => _State();
}

class _State extends State<BlogPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<BlogPost> posts = [];
  final BlogBloc blogBloc = BlogBloc();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Fetch posts when the page initializes
    blogBloc.add(FetchPostsEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {},
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'MyPosts'),
            Tab(text: 'AllPosts'),
          ],
        ),
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        bloc: blogBloc,
        listener: (context, state) {
          if (state is FetchPostsState) {
            print("state posts:${state.posts}");
            setState(() {
              posts = List.from(state.posts);
            });
          }
        },
        builder: (context, state) {
          return buildTabBarView();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/new-post');
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildTabBarView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildPostList(),
                buildPostList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPostList() {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        BlogPost post = posts[index];
        return GestureDetector(
          onTap: () {
            context.push(
              '/blog-details/${Uri.encodeComponent(post.title)}/${Uri.encodeComponent(post.content)}/${Uri.encodeComponent(post.image)}',
            );
          },
          child: BlogCard(
            imageUrl: post.image,
            title: post.title,
            date: 'Jan 12',
            readTime: '8 min read',
          ),
        );
      },
    );
  }
}
