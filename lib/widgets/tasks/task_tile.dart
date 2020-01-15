import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_timer/blocs/tasks/bloc.dart';
import 'package:focus_timer/models/task.dart';
import 'package:focus_timer/widgets/soft/soft_container.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile({Key key, @required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tasksBloc = BlocProvider.of<TasksBloc>(context);

    return Dismissible(
      key: ValueKey(task.uuid),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: SoftContainer(
          radius: 15,
          child: CheckboxListTile(
            value: task.isCompleted,
            onChanged: (_) =>
                tasksBloc.add(UpdateTask(task..toggleIsCompleted())),
            title: Text(task.name),
            // activeColor: isDark ? Colors.grey[500] : Colors.grey[900],
          ),
        ),
      ),
      onDismissed: (_) => tasksBloc.add(RemoveTask(task.uuid)),
    );
  }
}
