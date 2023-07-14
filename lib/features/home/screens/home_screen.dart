import 'package:flutter/material.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime dailyTaskDate = DateTime.now();
  DateTime habitualTaskDate = DateTime.now();

  TextEditingController dailyTaskController = TextEditingController();
  TextEditingController habitualTaskController = TextEditingController();
  TextEditingController taskEditingController = TextEditingController();
  String appBarDate = FormateDateTime.d2sWithoutHM(dateTime: DateTime.now());
  final IsarService isarService = IsarService();
  bool isEmpty = true;
  bool hasDailyTask = false;

  List<Task> allTasks = [];
  List<Task> completedTasks = [];
  int percent = 0;

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
      floatingActionButton: const SizedBox(
        height: 128,
        child: Column(
          children: [
            AddDailyTask(),
            SizedBox(
              height: 16,
            ),
            AddHabitualTask(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      ? HeatMap(
                          colorsets: Theme.of(context).brightness == Brightness.dark
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
                          textColor: Theme.of(context).colorScheme.onBackground,
                          startDate: DateTime.parse(GetStorage().read("firstDay")),
                          datasets: resultList,
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
                          startDate: DateTime.parse(GetStorage().read("firstDay")),
                          datasets: const{},
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
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    StreamBuilder(
                        stream: isarService.taskStream(
                            FormateDateTime.onlyDate(dateTime: DateTime.now())),
                        builder: (context, snapshot) {
                          allTasks = snapshot.hasData ? snapshot.data! : [];
                          completedTasks = snapshot.hasData
                              ? allTasks
                                  .where(
                                      (element) => element.isComplete == true)
                                  .toList()
                              : [];
                          percent = snapshot.hasData
                              ? completedTasks.length * 10 ~/ allTasks.length
                              : 0;
                          if (snapshot.hasData) {
                            isarService.updateTaskData(
                                FormateDateTime.onlyDate(
                                    dateTime: DateTime.now()),
                                percent);
                          }
                          print(percent);
                          return snapshot.hasData
                              ? Container(
                                  height: 5,
                                  width: ((MediaQuery.of(context).size.width *
                                              0.65) *
                                          percent) /
                                      10,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                )
                              : Container();
                        }),
                  ],
                )
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
                        ? ListView.builder(
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
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          isarService
                                              .deletePreviousTask(task.id);
                                        },
                                        backgroundColor:
                                            Theme.of(context).colorScheme.error,
                                        icon: Icons.delete,
                                        label: "Delete",
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ]),
                                child: Card(
                                  color: task.taskType == "dt"
                                      ? Theme.of(context).colorScheme.secondary
                                      : Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  child: CheckboxListTile(
                                    checkColor: task.taskType == "dt"
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondary
                                        : Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                    fillColor: task.taskType == "dt"
                                        ? MaterialStatePropertyAll(
                                            Theme.of(context)
                                                .colorScheme
                                                .onSecondary)
                                        : MaterialStatePropertyAll(
                                            Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant),
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
                                                .onSurfaceVariant,
                                        decoration: task.isComplete
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        decorationColor: task.taskType == "dt"
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
