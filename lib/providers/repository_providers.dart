import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/habit_repository.dart';
import '../repositories/habit_log_repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>((ref) {
  return HabitRepository();
});

final habitLogRepositoryProvider = Provider<HabitLogRepository>((ref) {
  return HabitLogRepository();
});