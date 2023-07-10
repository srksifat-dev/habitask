import 'package:flutter/material.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../../../common/app_textfield.dart';
import '../../../common/formate_dateTime.dart';
import '../../../models/task.dart';

FloatingActionButton addHabitualTask({
  required BuildContext context,
  required DateTime habitualTaskDate,
  required TextEditingController habitualTaskController,
  required bool isEmpty,
  required IsarService isarService,
}) {
  return FloatingActionButton(
    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
                      "Add Habitual Task",
                      style: TextStyle(fontSize: 18),
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
                            habitualTaskDate = value!;
                          });
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                      label: Text(FormateDateTime.d2sWithoutHM(
                          dateTime: habitualTaskDate)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                AppTextField(
                  controller: habitualTaskController,
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
                          habitualTaskController.clear();
                          Navigator.pop(context);
                          habitualTaskDate = DateTime.now();
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
                              ..taskCreated = habitualTaskDate
                              ..title = habitualTaskController.text
                              ..taskType = "ht");
                            habitualTaskController.clear();
                            Navigator.pop(context);
                            habitualTaskDate = DateTime.now();
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
    child: Stack(
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
  );
}
