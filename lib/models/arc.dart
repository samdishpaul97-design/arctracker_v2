import 'package:isar/isar.dart';

part 'arc.g.dart';

@collection
class Arc {
  Id id = Isar.autoIncrement;

  late String name;

  String? description;

  String? color;

  double weight = 1.0;

  DateTime createdAt = DateTime.now();
}