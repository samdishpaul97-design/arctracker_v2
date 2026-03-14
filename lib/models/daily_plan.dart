import 'package:isar/isar.dart';

part 'daily_plan.g.dart';

@collection
class DailyPlan {
  Id id = Isar.autoIncrement;

  late DateTime date;

  String? tasks;

  String? notes;

  DateTime createdAt = DateTime.now();
}