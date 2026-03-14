import 'package:isar/isar.dart';

part 'habit_log.g.dart';

@collection
class HabitLog {
  Id id = Isar.autoIncrement;

  late int habitId;

  late DateTime date;

  int count = 1;

  DateTime createdAt = DateTime.now();
}