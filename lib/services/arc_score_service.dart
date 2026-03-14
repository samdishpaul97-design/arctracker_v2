import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/arc_repository.dart';
import '../repositories/habit_repository.dart';
import '../repositories/habit_log_repository.dart';
import '../providers/repository_providers.dart';
import '../providers/arc_providers.dart';
import '../models/arc.dart';
import '../models/habit.dart';
import '../models/habit_log.dart';

class ArcScoreService {
  final ArcRepository _arcRepository;
  final HabitRepository _habitRepository;
  final HabitLogRepository _habitLogRepository;

  ArcScoreService(this._arcRepository, this._habitRepository, this._habitLogRepository);

  Future<Map<String, double>> calculateArcScores() async {
    // Get all arcs
    final arcs = await _arcRepository.getAllArcs();
    if (arcs.isEmpty) return {};

    // Get all habits
    final habits = await _habitRepository.getAllHabits();

    // Get current week start (Monday)
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    weekStart.copyWith(hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);

    // Get habit logs for the week
    final logs = await _habitLogRepository.getLogsForWeek(weekStart);

    // Group habits by arcId
    final habitsByArc = <int, List<Habit>>{};
    for (final habit in habits) {
      habitsByArc.putIfAbsent(habit.arcId, () => []).add(habit);
    }

    // Calculate scores
    final scores = <String, double>{};
    for (final arc in arcs) {
      final arcHabits = habitsByArc[arc.id] ?? [];
      if (arcHabits.isEmpty) {
        scores[arc.name] = 0.0;
        continue;
      }

      double score = 0.0;
      for (final habit in arcHabits) {
        final habitLogs = logs.where((log) => log.habitId == habit.id).toList();
        final completionCount = habitLogs.fold(0, (sum, log) => sum + log.count);
        score += arc.weight * completionCount;
      }

      // Normalize to 0-10 (simple cap for now)
      scores[arc.name] = score > 10.0 ? 10.0 : score;
    }

    return scores;
  }
}

final arcScoreServiceProvider = Provider<ArcScoreService>((ref) {
  final arcRepo = ref.watch(arcRepositoryProvider);
  final habitRepo = ref.watch(habitRepositoryProvider);
  final habitLogRepo = ref.watch(habitLogRepositoryProvider);
  return ArcScoreService(arcRepo, habitRepo, habitLogRepo);
});