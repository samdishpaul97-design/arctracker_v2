import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/arc.dart';
import '../repositories/arc_repository.dart';

final arcRepositoryProvider = Provider<ArcRepository>((ref) {
  return ArcRepository();
});

final arcsProvider = FutureProvider<List<Arc>>((ref) async {
  final repo = ref.read(arcRepositoryProvider);
  return repo.getAllArcs();
});