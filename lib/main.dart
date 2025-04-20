import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scalping_helper/app/router/router.dart';
import 'package:scalping_helper/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ← flutterfire configure로 생성된 파일
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
