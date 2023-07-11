import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_be_done/service/isar_service.dart';

import '../../../common/app_textfield.dart';
import '../../../common/formate_dateTime.dart';
import '../../../models/task.dart';

class EditTask extends StatefulWidget {
  const EditTask({required this.task, Key? key}) : super(key: key);
  final Task task;

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController taskEditingController = TextEditingController();
  late DateTime taskFor;
  bool isEmpty = false;
  IsarService isarService = IsarService();

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
              Text(
                "Edit Task",
                style: TextStyle(fontSize: 20),
              ),
              widget.task.taskType == "ht"
                  ? Container()
                  : TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.calendar_month),
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
                        taskFor = value;
                      });
                    },
                  ),
                ),
          SizedBox(
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
                  child: Text("Cancel")),
              Visibility(
                visible: !isEmpty,
                maintainAnimation: true,
                maintainState: true,
                child: FilledButton(
                    onPressed: () {
                      isarService.editTask(
                          id: widget.task.id,
                          title: taskEditingController.text,
                          dateTime: taskFor);
                      Navigator.pop(context);
                    },
                    child: Text("Update")),
              )
            ],
          )
        ],
      ),
    );
  }
}
