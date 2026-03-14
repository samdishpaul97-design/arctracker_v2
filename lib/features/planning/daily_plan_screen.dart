import 'package:flutter/material.dart';

class DailyPlanScreen extends StatelessWidget {
  const DailyPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Plan'),
      ),
      body: const Center(
        child: Text('Daily Plan Screen'),
      ),
    );
  }
}