import '../database/isar_service.dart';
import '../models/habit_log.dart';

class HabitLogRepository {
  Future<void> logHabit(int habitId, {int count = 1}) async {
    final isar = IsarService.isar;

    final log = HabitLog()
      ..habitId = habitId
      ..date = DateTime.now()
      ..count = count;

    await isar.writeTxn(() async {
      await isar.habitLogs.put(log);
    });
  }

  Future<List<HabitLog>> getLogsForHabit(int habitId) async {
    final isar = IsarService.isar;
    // TODO: Fix Isar query
    return [];
  }

  Future<List<HabitLog>> getLogsForDate(DateTime date) async {
    final isar = IsarService.isar;
    // TODO: Fix Isar query
    return [];
  }

  Future<List<HabitLog>> getLogsForWeek(DateTime weekStart) async {
    final isar = IsarService.isar;
    // TODO: Fix Isar query for date range
    return [];
  }
}