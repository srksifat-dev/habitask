import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_be_done/common/formate_dateTime.dart';
import 'package:to_be_done/features/home/components/add_daily_task.dart';
import 'package:to_be_done/features/home/components/add_habitual_task.dart';
import 'package:to_be_done/features/home/components/edit_task.dart';
import 'package:to_be_done/models/task_data.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../../../models/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String appBarDate = FormateDateTime.d2sWithoutHM(dateTime: DateTime.now());
  final IsarService isarService = IsarService();

  List<Task> allTasks = [];
  List<Task> completedTasks = [];
  int percent = 0;
  double percentForIndicator = 0.0;

  bool isFabVisible = true;

  @override
  void initState() {
    isarService.editHabitualTask(
        date: FormateDateTime.onlyDate(dateTime: DateTime.now()));
    isarService.editDailyTask(
        date: FormateDateTime.onlyDate(dateTime: DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GetStorage().write("installed", 1);
    return Scaffold(
      appBar: AppBar(
        title: const Text("2BDone"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(appBarDate),
          )
        ],
      ),
      floatingActionButton: SizedBox(
        height: 130,
        child: Column(
          children: [
            AddDailyTask(
              isVisible: isFabVisible,
            ),
            const SizedBox(
              height: 16,
            ),
            AddHabitualTask(
              isVisible: isFabVisible,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
        ),
        child: Column(
          children: [
            StreamBuilder(
                stream: isarService.taskDataStream(),
                builder: (context, snapshot) {
                  Map<DateTime, int> resultList = {};
                  if (snapshot.hasData) {
                    List<TaskData> datas = snapshot.data!;

                    for (int i = 0; i < datas.length; i++) {
                      Map<DateTime, int> item = {
                        datas[i].date: datas[i].completedPercentage
                      };
                      resultList.addEntries(item.entries);
                    }
                  }

                  return snapshot.hasData
                      ? Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            SizedBox(
                              height: 225,
                              child: HeatMap(
                                colorsets: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const {
                                        1: Color.fromARGB(20, 57, 211, 83),
                                        2: Color.fromARGB(40, 57, 211, 83),
                                        3: Color.fromARGB(60, 57, 211, 83),
                                        4: Color.fromARGB(80, 57, 211, 83),
                                        5: Color.fromARGB(100, 57, 211, 83),
                                        6: Color.fromARGB(120, 57, 211, 83),
                                        7: Color.fromARGB(150, 57, 211, 83),
                                        8: Color.fromARGB(180, 57, 211, 83),
                                        9: Color.fromARGB(220, 57, 211, 83),
                                        10: Color.fromARGB(255, 57, 211, 83),
                                      }
                                    : const {
                                        1: Color.fromARGB(20, 33, 110, 57),
                                        2: Color.fromARGB(40, 33, 110, 57),
                                        3: Color.fromARGB(60, 33, 110, 57),
                                        4: Color.fromARGB(80, 33, 110, 57),
                                        5: Color.fromARGB(100, 33, 110, 57),
                                        6: Color.fromARGB(120, 33, 110, 57),
                                        7: Color.fromARGB(150, 33, 110, 57),
                                        8: Color.fromARGB(180, 33, 110, 57),
                                        9: Color.fromARGB(220, 33, 110, 57),
                                        10: Color.fromARGB(255, 33, 110, 57),
                                      },
                                showColorTip: false,
                                colorMode: ColorMode.color,
                                textColor:
                                    Theme.of(context).colorScheme.onBackground,
                                datasets: resultList,
                                defaultColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                onClick: (value) {
                                  setState(() {
                                    appBarDate = FormateDateTime.d2sWithoutHM(
                                        dateTime: value);
                                  });
                                },
                                scrollable: true,
                                size: 24,
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 30,
                              color: Theme.of(context).colorScheme.background,
                              child: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sun",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Mon",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Tue",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Wed",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Thu",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Fri",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Sat",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : HeatMap(
                          colorsets:
                              Theme.of(context).brightness == Brightness.dark
                                  ? const {
                                      1: Color.fromARGB(20, 57, 211, 83),
                                      2: Color.fromARGB(40, 57, 211, 83),
                                      3: Color.fromARGB(60, 57, 211, 83),
                                      4: Color.fromARGB(80, 57, 211, 83),
                                      5: Color.fromARGB(100, 57, 211, 83),
                                      6: Color.fromARGB(120, 57, 211, 83),
                                      7: Color.fromARGB(150, 57, 211, 83),
                                      8: Color.fromARGB(180, 57, 211, 83),
                                      9: Color.fromARGB(220, 57, 211, 83),
                                      10: Color.fromARGB(255, 57, 211, 83),
                                    }
                                  : const {
                                      1: Color.fromARGB(20, 33, 110, 57),
                                      2: Color.fromARGB(40, 33, 110, 57),
                                      3: Color.fromARGB(60, 33, 110, 57),
                                      4: Color.fromARGB(80, 33, 110, 57),
                                      5: Color.fromARGB(100, 33, 110, 57),
                                      6: Color.fromARGB(120, 33, 110, 57),
                                      7: Color.fromARGB(150, 33, 110, 57),
                                      8: Color.fromARGB(180, 33, 110, 57),
                                      9: Color.fromARGB(220, 33, 110, 57),
                                      10: Color.fromARGB(255, 33, 110, 57),
                                    },
                          colorMode: ColorMode.color,
                          showColorTip: false,
                          textColor: Theme.of(context).colorScheme.onBackground,
                          startDate: DateTime.now(),
                          datasets: const {},
                          defaultColor:
                              Theme.of(context).colorScheme.surfaceVariant,
                          onClick: (value) {
                            setState(() {
                              appBarDate =
                                  FormateDateTime.d2sWithoutHM(dateTime: value);
                            });
                          },
                          scrollable: true,
                          size: 24,
                        );
                }),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Text("All Tasks"),
                const SizedBox(
                  width: 16,
                ),
                StreamBuilder(
                    stream: isarService.taskStream(
                        FormateDateTime.onlyDate(dateTime: DateTime.now())),
                    builder: (context, snapshot) {
                      allTasks = snapshot.hasData ? snapshot.data! : [];
                      completedTasks = snapshot.hasData
                          ? allTasks
                              .where((element) => element.isComplete == true)
                              .toList()
                          : [];
                      percentForIndicator = snapshot.hasData
                          ? completedTasks.length / allTasks.length
                          : 0.0;
                      percent = snapshot.hasData
                          ? (completedTasks.length * 10) ~/ allTasks.length
                          : 0;
                      if (snapshot.hasData) {
                        isarService.updateTaskData(
                            FormateDateTime.onlyDate(dateTime: DateTime.now()),
                            percent);
                      }
                      return snapshot.hasData
                          ? Expanded(
                              child: LinearProgressIndicator(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                value: percentForIndicator,
                              ),
                            )
                          : Container();
                    })
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: isarService.taskStream(
                      FormateDateTime.onlyDate(dateTime: DateTime.now())),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? NotificationListener<UserScrollNotification>(
                            onNotification: (notification) {
                              if (notification.direction ==
                                  ScrollDirection.forward) {
                                if (!isFabVisible) {
                                  setState(() {
                                    isFabVisible = true;
                                  });
                                }
                              } else if (notification.direction ==
                                  ScrollDirection.reverse) {
                                if (isFabVisible) {
                                  setState(() {
                                    isFabVisible = false;
                                  });
                                }
                              }
                              return true;
                            },
                            child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  final Task task = snapshot.data![index];
                                  return Slidable(
                                    key: ValueKey(task.id),
                                    closeOnScroll: true,
                                    endActionPane: ActionPane(
                                        extentRatio: 0.4,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      EditTask(task: task));
                                            },
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            icon: Icons.edit,
                                            label: "Edit",
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          SlidableAction(
                                            onPressed: (context) {
                                              isarService.deleteTask(
                                                  task.id,
                                                  FormateDateTime.onlyDate(
                                                      dateTime:
                                                          DateTime.now()));
                                            },
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            icon: Icons.delete,
                                            label: "Delete",
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ]),
                                    child: Card(
                                      color: task.taskType == "dt"
                                          ? Theme.of(context)
                                              .colorScheme
                                              .secondary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: CheckboxListTile(
                                        checkColor: task.taskType == "dt"
                                            ? Theme.of(context)
                                                .colorScheme
                                                .secondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondaryContainer,
                                        fillColor: task.taskType == "dt"
                                            ? MaterialStatePropertyAll(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary)
                                            : MaterialStatePropertyAll(
                                                Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer),
                                        value: task.isComplete,
                                        onChanged: (value) async {
                                          await isarService.editTaskStatus(
                                              task.id, value!);
                                        },
                                        title: Text(
                                          task.title,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: task.isComplete
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                            color: task.taskType == "dt"
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .onSecondary
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .onSecondaryContainer,
                                            decoration: task.isComplete
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            decorationColor:
                                                task.taskType == "dt"
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .onSecondary
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .onSecondaryContainer,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
