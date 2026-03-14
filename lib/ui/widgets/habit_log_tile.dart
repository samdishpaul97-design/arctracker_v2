import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/habit_logging_service.dart';
import '../../providers/habit_log_providers.dart';

class HabitLogTile extends ConsumerWidget {
  final int habitId;
  final String habitName;
  final bool completedToday;

  const HabitLogTile({
    super.key,
    required this.habitId,
    required this.habitName,
    this.completedToday = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text(habitName),
        trailing: IconButton(
          icon: Icon(
            completedToday ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completedToday ? Colors.green : null,
          ),
          onPressed: () async {
            await ref.read(habitLoggingServiceProvider).logHabit(habitId);
            ref.invalidate(todayHabitLogsProvider);
            // Optional: Show feedback to user
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$habitName logged!')),
            );
          },
        ),
      ),
    );
  }
}