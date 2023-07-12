import 'package:isar/isar.dart';

part 'everyday_data.g.dart';

@Collection()
class EverydayData {
  Id id = Isar.autoIncrement;
  late DateTime dateTime;
  late int percent;

}
