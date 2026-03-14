import 'package:isar/isar.dart';

part 'quest.g.dart';

@collection
class Quest {
  Id id = Isar.autoIncrement;

  late String name;

  String? description;

  late int arcId;

  String? status;

  DateTime createdAt = DateTime.now();
}