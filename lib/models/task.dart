import 'package:isar/isar.dart';

part 'task.g.dart';

@Collection()
class Task {
  Id id = Isar.autoIncrement;
  late DateTime taskFor;
  late String title;
  late bool isComplete;
  late String taskType;
}
