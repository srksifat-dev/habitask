import 'package:flutter/material.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../../../common/app_textfield.dart';
import '../../../common/formate_dateTime.dart';
import '../../../models/task.dart';

class AddHabitualTask extends StatefulWidget {
  AddHabitualTask({required this.isVisible, Key? key}) : super(key: key);
  bool isVisible;
  @override
  _AddHabitualTaskState createState() => _AddHabitualTaskState();
}

class _AddHabitualTaskState extends State<AddHabitualTask> {
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
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Add Habitual Task",
                              style: TextStyle(fontSize: 20),
                            ),
                            // TextButton.icon(
                            //   onPressed: () {},
                            //   icon: Icon(Icons.calendar_month),
                            //   label: Text(FormateDateTime.d2sWithoutHM(
                            //       dateTime: taskFor)),
                            // ),
                          ],
                        ),
                        // SizedBox(
                        //   height: 50,
                        //   width: 300,
                        //   child: CupertinoDatePicker(
                        //     mode: CupertinoDatePickerMode.date,
                        //     dateOrder: DatePickerDateOrder.ymd,
                        //     initialDateTime: DateTime.now(),
                        //     onDateTimeChanged: (value) {
                        //       setState(() {
                        //         taskFor = value;
                        //       });
                        //     },
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        AppTextField(
                          controller: taskController,
                          textCapitalization: TextCapitalization.sentences,
                          textInputType: TextInputType.text,
                          hintText: "Enter your task",
                          onChanged: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                isEmpty = true;
                              });
                            } else {
                              setState(() {
                                isEmpty = false;
                              });
                            }
                          },
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
                            Visibility(
                              visible: !isEmpty,
                              maintainAnimation: true,
                              maintainState: true,
                              child: FilledButton(
                                  onPressed: () {
                                    isarService.addTask(Task()
                                      ..isComplete = false
                                      ..taskFor = taskFor
                                      ..title = taskController.text
                                      ..taskType = "ht");
                                    taskController.clear();
                                    Navigator.pop(context);
                                    taskFor = FormateDateTime.onlyDate(
                                        dateTime: DateTime.now());
                                  },
                                  child: const Text("Add")),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
        },
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.autorenew,
              size: 40,
            ),
            Icon(
              Icons.done,
              size: 15,
            )
          ],
        ),
      ),
    );
  }
}
