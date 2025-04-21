import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scalping_helper/presentation/screen/home/home_screen.dart';
import 'package:scalping_helper/presentation/screen/sign_in/sign_in_screen.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 아직 Firebase 상태 확인 중
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 로그인 된 상태
        if (snapshot.hasData) {
          return const HomeScreen();
        }

        // 로그인 안 된 상태
        return const SignInScreen();
      },
    );
  }
}
