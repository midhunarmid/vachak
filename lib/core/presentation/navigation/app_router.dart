import 'package:flutter/material.dart';
import 'package:vachak/core/presentation/pages/dummy_screen.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_selection_screen.dart';
import 'package:vachak/core/presentation/pages/language_selection/language_type.dart';
import 'package:vachak/core/presentation/pages/signin_screen.dart';
import 'package:vachak/core/presentation/utils/widget_helper.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  errorBuilder: (context, state) => const DummyScreen(text: "Error Screen"),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LanguageSelectionScreen(
          languageType: LanguageType.source,
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'signin',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const SigninScreen(),
          ),
        ),
        GoRoute(
          path: 'forgotPassword',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const DummyScreen(text: "Forgot Password Screen"),
          ),
        ),
        GoRoute(
          path: 'home',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const DummyScreen(text: "Home Screen"),
          ),
        ),
        GoRoute(
          path: 'sourceLanguage',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const LanguageSelectionScreen(
              languageType: LanguageType.source,
            ),
          ),
        ),
      ],
    ),
  ],
);
