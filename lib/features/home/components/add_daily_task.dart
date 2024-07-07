import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../../../common/app_textfield.dart';
import '../../../common/formate_date_time.dart';
import '../../../models/task.dart';

class AddDailyTask extends StatefulWidget {
  AddDailyTask({required this.isVisible, super.key});
  bool isVisible;
  @override
  _AddDailyTaskState createState() => _AddDailyTaskState();
}

class _AddDailyTaskState extends State<AddDailyTask> {
  TextEditingController taskController = TextEditingController();
  DateTime taskFor = FormateDateTime.onlyDate(dateTime: DateTime.now());
  bool isEmpty = false;
  IsarService isarService = IsarService();
  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: widget.isVisible,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Add Daily Task",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.calendar_month,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              label: Text(
                                FormateDateTime.d2sWithoutHM(dateTime: taskFor),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          width: 300,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            dateOrder: DatePickerDateOrder.ymd,
                            initialDateTime: FormateDateTime.onlyDate(
                                dateTime: DateTime.now()),
                            onDateTimeChanged: (value) {
                              setState(() {
                                taskFor =
                                    FormateDateTime.onlyDate(dateTime: value);
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextField(
                          controller: taskController,
                          textCapitalization: TextCapitalization.sentences,
                          textInputType: TextInputType.text,
                          hintText: "Enter your task",
                          onSubmitted: (_) {
                            taskController.text.length > 1
                                ? isarService.addTask(Task()
                                  ..isComplete = false
                                  ..taskFor = taskFor
                                  ..title = taskController.text
                                  ..taskType = "dt")
                                : null;
                            taskController.clear();
                            Navigator.pop(context);
                            taskFor = FormateDateTime.onlyDate(
                                dateTime: DateTime.now());
                          },
                          autoFocus: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  taskController.clear();
                                  Navigator.pop(context);
                                  taskFor = DateTime.now();
                                },
                                child: const Text("Cancel")),
                            FilledButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                ),
                              ),
                              onPressed: () {
                                taskController.text.length > 1
                                    ? isarService.addTask(Task()
                                      ..isComplete = false
                                      ..taskFor = taskFor
                                      ..title = taskController.text
                                      ..taskType = "dt")
                                    : null;
                                taskController.clear();
                                Navigator.pop(context);
                                taskFor = FormateDateTime.onlyDate(
                                    dateTime: DateTime.now());
                              },
                              child: Text(
                                "Add",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ));
        },
        child: Icon(
          Icons.done,
          size: 40,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
      ),
    );
  }
}
