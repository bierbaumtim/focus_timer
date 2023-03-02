import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../state_models/tasks_model.dart';

/// {@template addtasktile}
/// A [TextInput] and a [CustomButton] inside a [CustomContainer]
/// to enter a new task and add it to the tasks
/// {@endtemplate}
class AddTaskTile extends StatefulWidget {
  /// {@macro addtasktile}
  const AddTaskTile({Key? key}) : super(key: key);

  @override
  State<AddTaskTile> createState() => _AddTaskTileState();
}

class _AddTaskTileState extends State<AddTaskTile> {
  late TextEditingController taskNameController;

  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Card(
              elevation: 2,
              child: TextField(
                controller: taskNameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Task hinzufügen...',
                  hintStyle: TextStyle(
                    color: theme.textTheme.titleLarge!.color,
                  ),
                ),
                onSubmitted: createTask,
              ),
            ),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            heroTag: 'add_task_button',
            onPressed: () {
              if (taskNameController.text.isNotEmpty) {
                createTask(taskNameController.text);
              }
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  void createTask(String taskName) {
    if (taskName.isNotEmpty) {
      context.read<TasksModel>().createTask(taskName);
      taskNameController.clear();
    }
  }
}
