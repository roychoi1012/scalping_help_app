import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// 백그라운드 수신 핸들러
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📦 백그라운드 메시지 수신됨: ${message.notification?.title}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _fcmToken;

  @override
  void initState() {
    super.initState();
    initFCM();
  }

  Future<void> initFCM() async {
    // 권한 요청 (Android 13+에선 꼭 필요)
    await FirebaseMessaging.instance.requestPermission();

    // 디바이스 토큰 받아오기
    _fcmToken = await FirebaseMessaging.instance.getToken();
    print('📱 FCM 토큰: $_fcmToken');

    // 포그라운드 알림 수신
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🚀 포그라운드 메시지: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('푸시 알림 수신 중... 앱이 꺼져도 배너 알림이 와요!'),
        ),
      ),
    );
  }
}
