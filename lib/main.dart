import 'package:blog_flutter/helpers/blog_provider.dart';
import 'package:blog_flutter/helpers/sharedPref_helper.dart';
import 'package:blog_flutter/screens/blog_details.dart';
import 'package:blog_flutter/screens/blog_page.dart';
import 'package:blog_flutter/screens/login_page.dart';
import 'package:blog_flutter/screens/new_post.dart';
import 'package:blog_flutter/screens/otp_page.dart';
import 'package:blog_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => BlogProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  //Routes for Navigation
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      if (state.uri.toString() == '/') {
        String? token = SharedPrefsHelper().getString('token');
        if (token != null) {
          return '/blog';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUp(),
      ),
      GoRoute(
        path: '/blog',
        builder: (context, state) => const BlogPage(),
      ),
      GoRoute(
        path: '/new-post',
        builder: (context, state) => const NewPostPage(),
      ),
      GoRoute(
        path: '/otp-page',
        builder: (context, state) => const OTPPage(),
      ),
      GoRoute(
        path: '/blog-details/:title/:content/:image',
        builder: (context, state) {
          final title = state.pathParameters['title']!;
          final content = state.pathParameters['content']!;
          final image = state.pathParameters['image']!;
          return BlogDetails(
            title: title,
            content: content,
            image: image,
          );
        },
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
