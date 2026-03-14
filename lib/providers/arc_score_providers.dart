import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/arc_score_service.dart';

final arcScoresProvider = FutureProvider<Map<String, double>>((ref) async {
  final service = ref.watch(arcScoreServiceProvider);
  return service.calculateArcScores();
});