import 'package:isar/isar.dart';

part 'task_data.g.dart';

@Collection()
class TaskData {
  Id id = Isar.autoIncrement;
  late DateTime date;
  late int completedPercentage;
}
