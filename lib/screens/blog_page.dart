import 'package:blog_flutter/components/blog_cart.dart';
import 'package:blog_flutter/helpers/blog_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:blog_flutter/models/blog_model.dart';
// import 'new_post_page.dart'; // Import the NewPostPage

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  _State createState() => _State();
}

class _State extends State<BlogPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Future.microtask(
        () => Provider.of<BlogProvider>(context, listen: false).fetchPosts());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final posts = blogProvider.posts;

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
      body: Padding(
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
                  //MyPosts Tab
                  ListView.builder(
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
                  ),
                  //AllPostsTab
                  ListView.builder(
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
                  ),
                ],
              ),
            ),
          ],
        ),
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
}
