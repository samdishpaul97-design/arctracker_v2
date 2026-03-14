import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit.dart';
import '../repositories/habit_repository.dart';
import 'repository_providers.dart';

final habitsProvider = FutureProvider<List<Habit>>((ref) async {
  final repo = ref.read(habitRepositoryProvider);
  return repo.getAllHabits();
});