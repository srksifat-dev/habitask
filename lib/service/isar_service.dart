import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_be_done/common/formate_dateTime.dart';
import 'package:to_be_done/models/task_data.dart';

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
        [TaskSchema, TaskDataSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> addTask(Task task) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.tasks.putSync(task));
    var taskData = await getTaskData(task.taskFor);
    if (taskData == null) {
      await addTaskData(TaskData()
        ..date = task.taskFor
        ..completedPercentage = 0);
    }
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

  Future<void> editHabitualTask({required DateTime date}) async {
    final isar = await db;
    var allHabitualTasks = await getAllHabitualTask();
    if (allHabitualTasks.isNotEmpty && allHabitualTasks.first.taskFor != date) {
      if (await getTaskData(date) == null) {
        addTaskData(TaskData()
          ..date = date
          ..completedPercentage = 0);
      }

      for (Task task in allHabitualTasks) {
        task.taskFor = date;
        if (task.isComplete == true) {
          task.isComplete = false;
        }
        isar.writeTxn(() => isar.tasks.put(task));
      }
    }
  }

  Future<void> editDailyTask({required DateTime date}) async {
    final isar = await db;
    var previousDayDailyTasks =
        await getDailyTaskFor(date.subtract(const Duration(days: 1)));
    if (previousDayDailyTasks.isNotEmpty) {
      if (await getTaskData(date) == null) {
        addTaskData(TaskData()
          ..date = date
          ..completedPercentage = 0);
      }
      for (Task task in previousDayDailyTasks) {
        if (task.isComplete == true) {
          await deleteTask(task.id);
        } else {
          task.taskFor = date;
          isar.writeTxn(() => isar.tasks.put(task));
        }
      }
    }
  }

  Future<List<Task>> getAllHabitualTask() async {
    final isar = await db;
    var tasks = await isar.tasks.filter().taskTypeEqualTo("ht").findAll();
    return tasks;
  }

  Future<List<Task>> getTaskFor(DateTime date) async {
    final isar = await db;
    return await isar.tasks.filter().taskForEqualTo(date).findAll();
  }

  Future<List<Task>> getDailyTaskFor(DateTime date) async {
    final isar = await db;
    return await isar.tasks
        .filter()
        .taskTypeEqualTo("dt")
        .taskForEqualTo(date)
        .findAll();
  }

  Stream<List<Task>> taskStream(DateTime date) async* {
    final isar = await db;
    yield* isar.tasks
        .where()
        .filter()
        .taskForEqualTo(date)
        .watch(fireImmediately: true);
  }

  Future<void> deleteTask(Id id) async {
    final isar = await db;
    var task = await isar.tasks.get(id);
    var allTasks = await getTaskFor(task!.taskFor);
    if (allTasks.length > 1) {
      await isar.writeTxn(() => isar.tasks.delete(id));
    } else {
      editTask(
          id: id,
          title: "You have to be productive! Come onnn...",
          dateTime: FormateDateTime.onlyDate(dateTime: DateTime.now()));
    }
  }

  Future<void> addTaskData(TaskData data) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.taskDatas.putSync(data));
  }

  Future<void> updateTaskData(DateTime date, int percentage) async {
    final isar = await db;
    TaskData? data = await getTaskData(date);
    data!.completedPercentage = percentage;
    isar.writeTxn(() => isar.taskDatas.put(data));
  }

  Future<TaskData?> getTaskData(DateTime date) async {
    final isar = await db;
    return await isar.taskDatas.filter().dateEqualTo(date).findFirst();
  }

  Stream<List<TaskData>> taskDataStream() async* {
    final isar = await db;
    yield* isar.taskDatas.where().watch(fireImmediately: true);
  }
}
