import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // 🔥 로그인 되어 있으면 '/home'으로 이동
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/home');
          });
          return const SizedBox(); // 빈 위젯 반환 (잠시 대기)
        }

        // 로그인 안 된 경우
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/sign_in');
        });
        return const SizedBox();
      },
    );
  }
}
