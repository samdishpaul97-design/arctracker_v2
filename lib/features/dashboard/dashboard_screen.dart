import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../ui/widgets/habit_log_tile.dart';
import '../../providers/habit_providers.dart';
import '../../providers/habit_log_providers.dart';
import '../../providers/arc_score_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    final todayLogsAsync = ref.watch(todayHabitLogsProvider);
    final scoresAsync = ref.watch(arcScoresProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ArcTracker Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Text(
            "Arc Scores",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          scoresAsync.when(
            data: (scores) => Column(
              children: scores.entries.map((entry) {
                return _arcRow(entry.key, entry.value);
              }).toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error loading arc scores: $err')),
          ),

          const SizedBox(height: 32),

          const Text(
            "Today's Habits",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          habitsAsync.when(
            data: (habits) => habits.isEmpty
              ? const Text('No habits found. Create some habits first!')
              : todayLogsAsync.when(
                  data: (logs) => Column(
                    children: habits.map((habit) {
                      final completedToday = logs.any((log) => log.habitId == habit.id);
                      return HabitLogTile(
                        habitId: habit.id,
                        habitName: habit.name,
                        completedToday: completedToday,
                      );
                    }).toList(),
                  ),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Error loading logs: $err')),
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error loading habits: $err')),
          ),

        ],
      ),
    );
  }

  Widget _arcRow(String name, double score) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text("${score.toStringAsFixed(1)} / 10"),
        ],
      ),
    );
  }
}