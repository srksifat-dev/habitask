import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/common/app_textfield.dart';
import '../../../../core/common/formate_date_time.dart';
import '../../data/models/task.dart';

class EditTask extends StatefulWidget {
  const EditTask({required this.task, super.key});
  final Task task;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController taskEditingController = TextEditingController();
  late DateTime taskFor;
  bool isEmpty = false;

  @override
  void initState() {
    taskEditingController.text = widget.task.title;
    taskFor = widget.task.taskFor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Edit Task",
                style: TextStyle(fontSize: 20),
              ),
              widget.task.taskType == "ht"
                  ? Container()
                  : TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month),
                      label:
                          Text(FormateDateTime.d2sWithoutHM(dateTime: taskFor)),
                    ),
            ],
          ),
          widget.task.taskType == "ht"
              ? Container()
              : SizedBox(
                  height: 50,
                  width: 250,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    dateOrder: DatePickerDateOrder.ymd,
                    initialDateTime: taskFor,
                    onDateTimeChanged: (value) {
                      setState(() {
                        taskFor = FormateDateTime.onlyDate(dateTime: value);
                      });
                    },
                  ),
                ),
          const SizedBox(
            height: 16,
          ),
          AppTextField(
            controller: taskEditingController,
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
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              Visibility(
                visible: !isEmpty,
                maintainAnimation: true,
                maintainState: true,
                child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Update")),
              )
            ],
          )
        ],
      ),
    );
  }
}
