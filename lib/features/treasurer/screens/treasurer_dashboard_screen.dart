import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money/features/auth/notifiers/auth_notifier.dart';

class TreasurerDashboardScreen extends ConsumerWidget {
  const TreasurerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treasurer Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authNotifierProvider.notifier).logout();
              // AuthWrapper will handle navigation to LoginScreen
            },
          ),
        ],
      ),
      body: const Center(child: Text('Welcome, Treasurer!')),
    );
  }
}
