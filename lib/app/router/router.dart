import 'package:go_router/go_router.dart';
import 'package:scalping_helper/presentation/screen/home/home_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_up/sign_up_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(), // 임시 홈
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),
  ],
);
