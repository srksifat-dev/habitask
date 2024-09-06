
class Task {
  final DateTime taskFor;
  final String title;
  final bool isComplete;
  final String taskType;

  const Task({
    required this.taskFor,
    required this.title,
    required this.isComplete,
    required this.taskType,
  });
}
