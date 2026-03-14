import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/habits/arc-detail'),
          child: const Text('Go to Arc Detail'),
        ),
      ),
    );
  }
}