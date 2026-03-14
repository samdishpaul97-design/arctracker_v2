import 'package:flutter/material.dart';

class WeeklyReviewScreen extends StatelessWidget {
  const WeeklyReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Review'),
      ),
      body: const Center(
        child: Text('Weekly Review Screen'),
      ),
    );
  }
}