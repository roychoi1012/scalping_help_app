import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 화면'),
        backgroundColor: const Color(0xFF1976D2), // 파랑 계열
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/signup'); // 회원가입으로 이동
          },
          child: const Text('회원가입 하러가기'),
        ),
      ),
    );
  }
}
