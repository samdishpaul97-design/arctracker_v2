import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/arc_repository.dart';
import '../repositories/habit_repository.dart';
import '../providers/repository_providers.dart';
import '../providers/arc_providers.dart';
import '../models/arc.dart';

class SeedService {
  final ArcRepository _arcRepository;
  final HabitRepository _habitRepository;

  SeedService(this._arcRepository, this._habitRepository);

  static Future<void> seedInitialData() async {
    final arcRepo = ArcRepository();
    final habitRepo = HabitRepository();
    final seedService = SeedService(arcRepo, habitRepo);
    
    await seedService.seedArcs();
    await seedService.seedHabits();
  }

  Future<void> seedArcs() async {
    final existingArcs = await _arcRepository.getAllArcs();
    if (existingArcs.isNotEmpty) return; // Already seeded

    final arcs = [
      'Health',
      'Stability',
      'Creative',
      'Growth',
      'Social',
      'Spiritual',
      'Work',
      'Finance',
    ];

    for (final arcName in arcs) {
      await _arcRepository.createArc(arcName);
    }
  }

  Future<void> seedHabits() async {
    final existingHabits = await _habitRepository.getAllHabits();
    if (existingHabits.isNotEmpty) return; // Already seeded

    final arcs = await _arcRepository.getAllArcs();
    final arcMap = {for (final arc in arcs) arc.name: arc.id};

    final habitData = {
      'Health': ['Gym', 'Daily Sets', 'Morning Activation', 'Run'],
      'Work': ['Work Priority Block', 'Work Light Block'],
      'Growth': ['Reading', 'Learning'],
    };

    for (final entry in habitData.entries) {
      final arcName = entry.key;
      final arcId = arcMap[arcName];
      if (arcId == null) continue;

      for (final habitName in entry.value) {
        await _habitRepository.createHabit(habitName, arcId);
      }
    }
  }
}

final seedServiceProvider = Provider<SeedService>((ref) {
  final arcRepo = ref.watch(arcRepositoryProvider);
  final habitRepo = ref.watch(habitRepositoryProvider);
  return SeedService(arcRepo, habitRepo);
});