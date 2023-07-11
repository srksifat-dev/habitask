import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

class IsarService {
  late Future<Isar> db;
  IsarService() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [TaskSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> addTask(Task task) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.tasks.putSync(task));
  }

  Future<void> editTaskStatus(Id id, bool isComplete) async {
    final isar = await db;
    final Task? task = await isar.tasks.get(id);

    task!.isComplete = isComplete;
    isar.writeTxn(() => isar.tasks.put(task));
  }

  Future<void> editTask(
      {required Id id,
      required String title,
      required DateTime dateTime}) async {
    final isar = await db;
    final Task? task = await isar.tasks.get(id);

    task!.title = title;
    task.taskFor = dateTime;
    isar.writeTxn(() => isar.tasks.put(task));
  }

  Future<List<Task>> getAllTask() async {
    final isar = await db;
    return await isar.tasks.where().findAll();
  }

  Stream<List<Task>> taskStream() async* {
    final isar = await db;
    yield* isar.tasks.where().watch(fireImmediately: true);
  }

  Future<void> deleteTask(Id id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.tasks.delete(id));
  }
}
