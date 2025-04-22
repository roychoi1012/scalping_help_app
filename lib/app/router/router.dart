import 'package:go_router/go_router.dart';
import 'package:scalping_helper/presentation/auth/auth_gate.dart';
import 'package:scalping_helper/presentation/screen/asset/asset_screen.dart';
import 'package:scalping_helper/presentation/screen/notification/notification_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_in/sign_in_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scalping_helper/presentation/screen/home/home_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_in/sign_in_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_up/sign_up_screen.dart';
import 'package:scalping_helper/presentation/auth/auth_gate.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    /// ShellRoute: 아이콘만 있는 3개 탭 구조
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _calculateIndex(state.uri.toString()),
            onTap: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                  break;
                case 1:
                  context.go('/asset');
                  break;
                case 2:
                  context.go('/notification');
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none),
                label: '',
              ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: '/asset',
          builder: (_, __) => const AssetScreen(),
        ),
        GoRoute(
          path: '/notification',
          builder: (_, __) => const NotificationScreen(),
        ),
      ],
    ),

    // 로그인 상태 판단용 AuthGate
    GoRoute(
      path: '/',
      builder: (_, __) => const AuthGate(),
    ),

    GoRoute(
      path: '/sign_in',
      builder: (_, __) => const SignInScreen(),
    ),

    GoRoute(
      path: '/signup',
      builder: (_, __) => const SignUpScreen(),
    ),
  ],
);

int _calculateIndex(String location) {
  if (location.startsWith('/asset')) return 1;
  if (location.startsWith('/notification')) return 2;
  return 0;
}
