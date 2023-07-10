import 'package:flutter/material.dart';
import 'package:to_be_done/features/home/components/add_daily_task.dart';
import 'package:to_be_done/features/home/components/add_habitual_task.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../components/app_heatmap.dart';

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
  final IsarService isarService = IsarService();
  bool isEmpty = true;
  bool hasDailyTask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2BDone"),
        centerTitle: true,
      ),
      floatingActionButton: SizedBox(
        height: 128,
        child: Column(
          children: [
            addDailyTask(
                context: context,
                dailyTaskDate: dailyTaskDate,
                dailyTaskController: dailyTaskController,
                isEmpty: isEmpty,
                isarService: isarService),
            SizedBox(
              height: 16,
            ),
            addHabitualTask(
              context: context,
              habitualTaskDate: habitualTaskDate,
              habitualTaskController: habitualTaskController,
              isEmpty: isEmpty,
              isarService: isarService,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppHeatmap(),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text("All Tasks"),
                SizedBox(
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
                    Container(
                      height: 5,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: isarService.taskStream(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: snapshot.data![index].taskType == "dt"
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                child: CheckboxListTile(
                                  value: snapshot.data![index].isComplete,
                                  onChanged: (value) {
                                    isarService.editTaskStatus(
                                        snapshot.data![index].id, value!);
                                  },
                                  title: Text(
                                    snapshot.data![index].title,
                                    style: TextStyle(
                                      decoration:
                                          snapshot.data![index].isComplete
                                              ? TextDecoration.lineThrough
                                              : TextDecoration.none,
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
