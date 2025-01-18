import 'package:blog_flutter/helpers/sharedPref_helper.dart';
import 'package:blog_flutter/screens/blog_details.dart';
import 'package:blog_flutter/screens/blog_page.dart';
import 'package:blog_flutter/screens/login_page.dart';
import 'package:blog_flutter/screens/new_post.dart';
import 'package:blog_flutter/screens/otp_page.dart';
import 'package:blog_flutter/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_flutter/bloc/blog_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }

  // Define routes using GoRouter
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      // Retrieve token to check user authentication
      final String? token = SharedPrefsHelper().getString('token');
      final isLoggingIn = state.uri.toString() == '/';

      // If the user is not authenticated and not logging in, redirect to login page
      if (token == null && !isLoggingIn) {
        return '/';
      }

      // If the user is authenticated, redirect to the blog page
      if (token != null && isLoggingIn) {
        return '/blog';
      }

      return null; // No redirect needed
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
            title: Uri.decodeComponent(title),
            content: Uri.decodeComponent(content),
            image: Uri.decodeComponent(image),
          );
        },
      ),
    ],
  );
}
