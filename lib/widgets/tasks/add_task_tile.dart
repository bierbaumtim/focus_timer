import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../models/task.dart';
import '../../state_models/tasks_model.dart';
import '../soft/soft_button.dart';
import '../soft/soft_container.dart';

/// {@template addtasktile}
/// A [TextInput] and a [SoftButton] inside a [SoftContainer]
/// to enter a new task and add it to the tasks
/// {@endtemplate}
class AddTaskTile extends StatefulWidget {
  /// {@macro addtasktile}
  const AddTaskTile({Key key}) : super(key: key);

  @override
  _AddTaskTileState createState() => _AddTaskTileState();
}

class _AddTaskTileState extends State<AddTaskTile> {
  TextEditingController taskNameController;

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

    return SoftContainer(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: TextField(
                  controller: taskNameController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Task hinzufügen...',
                    hintStyle: TextStyle(
                      color: theme.textTheme.title.color,
                    ),
                  ),
                  onSubmitted: createTask,
                ),
              ),
            ),
            const SizedBox(width: 16),
            SoftButton(
              radius: 15,
              onTap: () {
                if (taskNameController.text.isNotEmpty) {
                  createTask(taskNameController.text);
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  void createTask(String taskName) {
    if (taskName.isNotEmpty) {
      final model = Injector.get<TasksModel>();
      final task = Task.create(taskName);
      model.addTask(task);
      taskNameController.clear();
    }
  }
}
