import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/arc.dart';
import '../models/habit.dart';
import '../models/habit_log.dart';
import '../models/quest.dart';
import '../models/weekly_review.dart';
import '../models/daily_plan.dart';

class IsarService {
  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open(
      [
        ArcSchema,
        HabitSchema,
        HabitLogSchema,
        QuestSchema,
        WeeklyReviewSchema,
        DailyPlanSchema,
      ],
      directory: dir.path,
    );
  }
}