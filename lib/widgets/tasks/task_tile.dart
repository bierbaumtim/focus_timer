import 'package:flutter/material.dart';

import 'package:states_rebuilder/states_rebuilder.dart';

import '../../models/task.dart';
import '../../state_models/tasks_model.dart';
import '../soft/soft_container.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final taskModel = Injector.get<TasksModel>();

    return Dismissible(
      key: ValueKey(task.uuid),
      onDismissed: (_) => taskModel.removeTask(task),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        child: SoftContainer(
          radius: 15,
          child: CheckboxListTile(
            value: task.isCompleted,
            onChanged: (_) => taskModel.updateTask(task..toggleIsCompleted()),
            title: Text(
              task.name,
              style: task.isCompleted
                  ? theme.textTheme.body1.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2.0,
                      color: theme.textTheme.body1.color.withOpacity(0.75),
                    )
                  : theme.textTheme.body1,
            ),
            activeColor:
                theme.accentColor.withOpacity(task.isCompleted ? 0.75 : 1.0),
            checkColor: theme.canvasColor,
          ),
        ),
      ),
    );
  }
}
