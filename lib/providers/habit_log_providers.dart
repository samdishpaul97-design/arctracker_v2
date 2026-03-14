import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit_log.dart';
import '../repositories/habit_log_repository.dart';
import 'repository_providers.dart';

final todayHabitLogsProvider = FutureProvider<List<HabitLog>>((ref) async {
  final repo = ref.read(habitLogRepositoryProvider);
  final today = DateTime.now();
  return repo.getLogsForDate(today);
});