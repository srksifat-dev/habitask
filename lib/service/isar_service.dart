import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:to_be_done/common/formate_dateTime.dart';
import 'package:to_be_done/models/everyday_data.dart';

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
        [TaskSchema, EverydayDataSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> addTask(Task task) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.tasks.putSync(task));
    var allTasks = await getTaskFor(task.taskFor);
    var allCompletedTasks = await getCompletedTaskFor(task.taskFor);
    var percent = (allCompletedTasks.length * 10) ~/ allTasks.length;
    await addEverydayData(
        EverydayData()
          ..dateTime = task.taskFor
          ..percent = percent,
        task.taskFor);
  }

  Future<void> editTaskStatus(Id id, bool isComplete) async {
    final isar = await db;
    final Task? task = await isar.tasks.get(id);

    task!.isComplete = isComplete;
    isar.writeTxn(() => isar.tasks.put(task));
    var allTasks = await getTaskFor(task.taskFor);
    var allCompletedTasks = await getCompletedTaskFor(task.taskFor);
    var percent = (allCompletedTasks.length * 10) ~/ allTasks.length;
    await addEverydayData(
        EverydayData()
          ..dateTime = task.taskFor
          ..percent = percent,
        task.taskFor);
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
    var allTasks = await getTaskFor(dateTime);
    var allCompletedTasks = await getCompletedTaskFor(dateTime);
    var percent = (allCompletedTasks.length * 10) ~/ allTasks.length;
    await addEverydayData(
        EverydayData()
          ..dateTime = task.taskFor
          ..percent = percent,
        task.taskFor);
  }

  Future<void> editHabitualTask({required DateTime date}) async {
    final isar = await db;
    var allHabitualTasks = await getAllHabitualTask();
    if (allHabitualTasks.isNotEmpty && allHabitualTasks.first.taskFor != date) {
      for (Task task in allHabitualTasks) {
        task.taskFor = date;
        if (task.isComplete == true) {
          task.isComplete = false;
        }
        isar.writeTxn(() => isar.tasks.put(task));
        var allTasks = await getTaskFor(date);
        var allCompletedTasks = await getCompletedTaskFor(date);
        var percent = (allCompletedTasks.length * 10) ~/ allTasks.length;
        await addEverydayData(
            EverydayData()
              ..dateTime = task.taskFor
              ..percent = percent,
            task.taskFor);
      }
    }
  }

  Future<void> editDailyTask({required DateTime date}) async {
    final isar = await db;
    var previousDayDailyTasks =
        await getDailyTaskFor(date.subtract(const Duration(days: 1)));
    if (previousDayDailyTasks.isNotEmpty) {
      for (Task task in previousDayDailyTasks) {
        if (task.isComplete == true) {
          await deletePreviousTask(task.id, date);
        } else {
          task.taskFor = date;
          isar.writeTxn(() => isar.tasks.put(task));
          var allTasks = await getTaskFor(date);
          var allCompletedTasks = await getCompletedTaskFor(date);
          var percent = (allCompletedTasks.length * 10) ~/ allTasks.length;
          await addEverydayData(
              EverydayData()
                ..dateTime = task.taskFor
                ..percent = percent,
              task.taskFor);
        }
      }
    }
  }

  Future<List<Task>> getAllTask() async {
    final isar = await db;
    var tasks = await isar.tasks.where().findAll();
    return tasks;
  }

  Future<List<Task>> getAllHabitualTask() async {
    final isar = await db;
    var tasks = await isar.tasks.filter().taskTypeEqualTo("ht").findAll();
    return tasks;
  }

  Future<List<Task>> getAllDailyTask() async {
    final isar = await db;
    var tasks = await isar.tasks.filter().taskTypeEqualTo("dt").findAll();
    return tasks;
  }

  Future<List<Task>> getAllCompletedTask() async {
    final isar = await db;
    return await isar.tasks.filter().isCompleteEqualTo(true).findAll();
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

  Stream<List<Task>> completedTaskLengthStream() async* {
    final isar = await db;
    yield* isar.tasks
        .filter()
        .isCompleteEqualTo(true)
        .watch(fireImmediately: true);
  }

  Future<List<Task>> getCompletedTaskFor(DateTime date) async {
    final isar = await db;
    return await isar.tasks
        .filter()
        .taskForEqualTo(date)
        .isCompleteEqualTo(true)
        .findAll();
  }

  Future<void> deletePreviousTask(Id id, DateTime date) async {
    final isar = await db;

    var allTasks = await getTaskFor(date);
    if (allTasks.length > 1) {
      await isar.writeTxn(() => isar.tasks.delete(id));
      var tasks = await getTaskFor(date);
      var allCompletedTasks = await getCompletedTaskFor(date);
      var percent = tasks.isNotEmpty
          ? (allCompletedTasks.length * 10) ~/ tasks.length
          : 0;
      await addEverydayData(
          EverydayData()
            ..dateTime = date
            ..percent = percent,
          date);
    } else {
      editTask(
          id: id,
          title: "You have to be productive! Come onnn...",
          dateTime: FormateDateTime.onlyDate(dateTime: DateTime.now()));
    }
  }

  Future<void> deleteTask(Id id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.tasks.delete(id));
    await getAllTask();
  }

  Future<void> addEverydayData(EverydayData data, DateTime date) async {
    final isar = await db;
    EverydayData? everydayData =
        await isar.everydayDatas.filter().dateTimeEqualTo(date).findFirst();
    if (everydayData != null) {
      var allTasks = await getTaskFor(date);
      var allCompletedTasks = await getCompletedTaskFor(date);

      everydayData.percent = (allCompletedTasks.length * 10) ~/ allTasks.length;
      isar.writeTxn(() => isar.everydayDatas.put(everydayData));
    } else {
      isar.writeTxnSync(() => isar.everydayDatas.putSync(data));
    }
  }

  Stream<List<EverydayData>> allDataStream() async* {
    final isar = await db;
    yield* isar.everydayDatas.where().watch(fireImmediately: true);
  }

  Stream<List<EverydayData>> todayDataStream(DateTime date) async* {
    final isar = await db;
    yield* isar.everydayDatas
        .filter()
        .dateTimeEqualTo(date)
        .watch(fireImmediately: true);
  }

  Future<void> deleteEveryDayData() async {
    final isar = await db;
    await isar.writeTxn(() => isar.everydayDatas.clear());
    await getAllTask();
  }
}
