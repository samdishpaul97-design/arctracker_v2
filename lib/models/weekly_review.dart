import 'package:isar/isar.dart';

part 'weekly_review.g.dart';

@collection
class WeeklyReview {
  Id id = Isar.autoIncrement;

  late DateTime weekStart;

  String? notes;

  double? rating;

  DateTime createdAt = DateTime.now();
}