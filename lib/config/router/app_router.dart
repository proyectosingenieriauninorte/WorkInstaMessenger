import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:work_insta_messenger/ui/pages/index.dart';
import 'package:work_insta_messenger/ui/central.dart';


  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Central(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    ),
  );

