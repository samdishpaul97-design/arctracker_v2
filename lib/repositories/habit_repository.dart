import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/habit.dart';

class HabitRepository {
  Future<List<Habit>> getAllHabits() async {
    final isar = IsarService.isar;
    return await isar.habits.where().findAll();
  }

  Future<List<Habit>> getHabitsByArc(int arcId) async {
    final isar = IsarService.isar;
    return await isar.habits.filter().arcIdEqualTo(arcId).findAll();
  }

  Future<void> createHabit(String name, int arcId, {String? description, String? frequency}) async {
    final isar = IsarService.isar;

    final habit = Habit()
      ..name = name
      ..arcId = arcId
      ..description = description
      ..frequency = frequency;

    await isar.writeTxn(() async {
      await isar.habits.put(habit);
    });
  }

  Future<void> deleteHabit(Id id) async {
    final isar = IsarService.isar;

    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });
  }
}