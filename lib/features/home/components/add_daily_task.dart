import 'package:flutter/material.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../../../common/app_textfield.dart';
import '../../../common/formate_dateTime.dart';
import '../../../models/task.dart';

FloatingActionButton addDailyTask({
  required BuildContext context,
  required DateTime dailyTaskDate,
  required TextEditingController dailyTaskController,
  required bool isEmpty,
  required IsarService isarService,
}) {
  return FloatingActionButton(
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Daily Task",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    DateTime.now().year, DateTime.now().month),
                                lastDate: DateTime(2030))
                            .then((value) {
                          setState(() {
                            dailyTaskDate = value!;
                          });
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                      label: Text(FormateDateTime.d2sWithoutHM(
                          dateTime: dailyTaskDate)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                AppTextField(
                  controller: dailyTaskController,
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
                          dailyTaskController.clear();
                          Navigator.pop(context);
                          dailyTaskDate = DateTime.now();
                        },
                        child: Text("Cancel")),
                    Visibility(
                      visible: !isEmpty,
                      maintainAnimation: true,
                      maintainState: true,
                      child: FilledButton(
                          onPressed: () {
                            isarService.addTask(Task()
                              ..isComplete = false
                              ..taskCreated = dailyTaskDate
                              ..title = dailyTaskController.text
                              ..taskType = "dt");
                            dailyTaskController.clear();
                            Navigator.pop(context);
                            dailyTaskDate = DateTime.now();
                          },
                          child: Text("Add")),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      );
    },
    child: Icon(
      Icons.done,
      size: 40,
    ),
  );
}
