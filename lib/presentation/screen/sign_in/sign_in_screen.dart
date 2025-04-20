import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  Future<void> signIn() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 로그인 성공 시 홈으로 이동 (예시)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('로그인 성공!')),
        );
      }

    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: '이메일'),
                validator: (value) => (value == null || !value.contains('@')) ? '이메일을 확인하세요' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: '비밀번호'),
                validator: (value) => (value == null || value.length < 6) ? '비밀번호 6자 이상 입력' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: signIn,
                child: const Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
