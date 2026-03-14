import 'package:isar/isar.dart';
import '../database/isar_service.dart';
import '../models/arc.dart';

class ArcRepository {

  Future<List<Arc>> getAllArcs() async {
    final isar = IsarService.isar;

    return await isar.arcs.where().findAll();
  }

  Future<void> createArc(String name, {String? description, String? color}) async {
    final isar = IsarService.isar;

    final arc = Arc()
      ..name = name
      ..description = description
      ..color = color;

    await isar.writeTxn(() async {
      await isar.arcs.put(arc);
    });
  }

  Future<void> deleteArc(Id id) async {
    final isar = IsarService.isar;

    await isar.writeTxn(() async {
      await isar.arcs.delete(id);
    });
  }

}