import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_timer/blocs/tasks/bloc.dart';
import 'package:focus_timer/models/task.dart';
import 'package:focus_timer/widgets/soft/soft_button.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';

class AddTaskTile extends StatefulWidget {
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
                ),
              ),
            ),
            SizedBox(width: 16),
            SoftButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.add),
              ),
              radius: 15,
              onTap: () {
                if (taskNameController.text.isNotEmpty) {
                  final task = Task.create(taskNameController.text);
                  BlocProvider.of<TasksBloc>(context).add(AddTask(task));
                  taskNameController.clear();
                }
              },
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
      radius: 20,
    );
  }
}
