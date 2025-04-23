import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scalping_helper/app/router/router.dart';
import 'package:scalping_helper/firebase_options.dart';
import 'package:scalping_helper/presentation/screen/notification/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init(); // 🔔 알림 초기화
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
