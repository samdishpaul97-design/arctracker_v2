import 'package:flutter/material.dart';

class ArcDetailScreen extends StatelessWidget {
  const ArcDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arc Detail'),
      ),
      body: const Center(
        child: Text('Arc Detail Screen'),
      ),
    );
  }
}