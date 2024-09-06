import 'package:flutter/material.dart';

// Initially I clean up all unnecessary things
// And I create task screen where all task are showed
// See you in the next video
// Thank you for watching

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HABITASK",
          style: TextStyle(
            letterSpacing: 5,
          ),
        ),
      ),
    );
  }
}
