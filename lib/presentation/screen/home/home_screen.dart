import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF6FF), // 부드러운 파란색 배경
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFF1976D2),
        foregroundColor: Colors.white,
        actions: [
          if (user != null)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('로그아웃 되었습니다')),
                );
                context.go('/sign_in');
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Asset Value',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  '₩12,450,000',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Text(
                  '+1.27%',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 간단한 그래프 영역 (Placeholder로)
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Text('Graph Placeholder')),
            ),

            const SizedBox(height: 24),

            const Text(
              'Recent Trades',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            // 최근 거래 리스트
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Samsung'),
                subtitle: const Text('BUY'),
                trailing: Text(
                  '+0.45%',
                  style: TextStyle(color: Colors.green.shade600),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: const Text('Hyundai'),
                subtitle: const Text('SELL'),
                trailing: Text(
                  '-0.31%',
                  style: TextStyle(color: Colors.red.shade600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
