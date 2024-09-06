import 'package:flutter/material.dart';
import '../../../../core/common/app_textfield.dart';
import '../../../../core/common/formate_date_time.dart';

class AddHabitualTask extends StatefulWidget {
  AddHabitualTask({required this.isVisible, super.key});
  bool isVisible;
  @override
  _AddHabitualTaskState createState() => _AddHabitualTaskState();
}

class _AddHabitualTaskState extends State<AddHabitualTask> {
  TextEditingController taskController = TextEditingController();
  DateTime taskFor = FormateDateTime.onlyDate(dateTime: DateTime.now());
  bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: widget.isVisible,
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
                          ],
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
                            Visibility(
                              visible: !isEmpty,
                              maintainAnimation: true,
                              maintainState: true,
                              child: FilledButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .secondaryContainer,
                                    ),
                                  ),
                                  onPressed: () {
                                  },
                                  child: Text(
                                    "Add",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.autorenew,
              size: 40,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            Icon(
              Icons.done,
              size: 15,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            )
          ],
        ),
      ),
    );
  }
}