import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/habit_log_repository.dart';
import '../providers/repository_providers.dart';

class HabitLoggingService {
  final HabitLogRepository _habitLogRepository;

  HabitLoggingService(this._habitLogRepository);

  Future<void> logHabit(int habitId) async {
    await _habitLogRepository.logHabit(habitId);
  }

  Future<void> logHabitMultiple(int habitId, int count) async {
    await _habitLogRepository.logHabit(habitId, count: count);
  }
}

final habitLoggingServiceProvider = Provider<HabitLoggingService>((ref) {
  final habitLogRepository = ref.watch(habitLogRepositoryProvider);
  return HabitLoggingService(habitLogRepository);
});