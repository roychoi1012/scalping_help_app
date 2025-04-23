// 파일: lib/presentation/screen/notification/notification_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:scalping_helper/presentation/screen/notification/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int value = 0; // 0: 없음, 1: 1분, 2: 3분, 3: 5분
  Timer? _timer;

  // 순서를 OFF -> 1분 -> 3분 -> 5분 으로 변경
  final Map<int, int> intervalMap = {
    1: 1, // 1은 1분
    2: 3, // 2는 3분
    3: 5, // 3은 5분
  };

  void _startPreciseNotification(int interval) {
    _timer?.cancel();

    final now = DateTime.now();
    final int secondsUntilNextMinute = 60 - now.second;
    final int millisecondsUntilNextMinute =
        (secondsUntilNextMinute * 1000) - now.millisecond;

    Future.delayed(Duration(milliseconds: millisecondsUntilNextMinute), () {
      _showNotification();

      _timer = Timer.periodic(
        Duration(minutes: interval),
        (_) => _showNotification(),
      );
    });
  }

  void _showNotification() {
    final now = DateTime.now();
    final timeString =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    NotificationService.showNotification(
      id: now.minute,
      title: '스캘핑 알림',
      body: '$timeString - 지금 시황을 확인하세요!',
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Color colorBuilder(int i) {
    switch (i) {
      case 1:
        return Colors.blueAccent; // 1분 - 빨간색
      case 2:
        return Colors.orangeAccent; // 3분 - 주황색
      case 3:
        return Colors.greenAccent; // 5분 - 초록색
      default:
        return Colors.redAccent; // OFF - 파란색
    }
  }

  Widget iconBuilder(int i) {
    // 순서를 OFF -> 1분 -> 3분 -> 5분 으로 변경
    final label = ['OFF', '1분', '3분', '5분'][i];
    return Center(
      child: Text(
        label,
        style: TextStyle(
          // 현재 선택된 값이면 흰색, 아니면 검은색으로 설정
          color: value == i ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 설정'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '알림 주기를 선택하세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 32),
            AnimatedToggleSwitch<int>.size(
              current: value,
              values: const [0, 1, 2, 3],
              textDirection: TextDirection.ltr,
              iconOpacity: 0.2,
              indicatorSize: const Size.fromWidth(100),
              iconBuilder: iconBuilder,
              borderWidth: 4.0,
              iconAnimationType: AnimationType.onHover,
              style: ToggleStyle(
                borderColor: Colors.transparent,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1.5),
                  ),
                ],
              ),
              styleBuilder: (i) => ToggleStyle(indicatorColor: colorBuilder(i)),
              onChanged: (i) {
                setState(() => value = i);
                // 기존 타이머 취소
                _timer?.cancel();

                if (i == 0) {
                  // OFF를 선택한 경우 - 예약된 모든 작업 취소
                  _timer = null;
                  // 추가: 알림 취소 로직
                  NotificationService.cancelAllNotifications();
                } else if (intervalMap.containsKey(i)) {
                  // 특정 시간 간격을 선택한 경우
                  _startPreciseNotification(intervalMap[i]!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
