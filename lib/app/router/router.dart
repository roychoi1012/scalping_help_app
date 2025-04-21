import 'package:go_router/go_router.dart';
import 'package:scalping_helper/presentation/auth/auth_gate.dart';
import 'package:scalping_helper/presentation/screen/sign_in/sign_in_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_up/sign_up_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthGate(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: '/sign_in',
      builder: (_, __) => const SignInScreen(),
    ),
  ],
);
