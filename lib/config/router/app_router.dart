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
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUp(),
    ),
    GoRoute(
      path: '/content',
      builder: (context, state) => ContentPage(),
    ),
    GoRoute(
      path: '/chat/:receiverEmail',
      builder: (context, state) {
        final receiverEmail = state.pathParameters['receiverEmail'] ?? '';
        return ChatPage(receiverEmail: receiverEmail);
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(state.error.toString()),
    ),
  ),
);
