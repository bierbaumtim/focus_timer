import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';

import '../../database/app_database.dart';
import '../../state_models/tasks_model.dart';
import '../soft/soft_container.dart';

class TaskTile extends ViewModelWidget<TasksModel> {
  final Task task;

  const TaskTile({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, TasksModel model) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(task.uuid),
      onDismissed: (_) => model.removeTask(task),
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
                model.updateTask(task.copyWith(isCompleted: !task.isCompleted)),
            title: AnimatedDefaultTextStyle(
              child: Text(
                task.name,
              ),
              style: task.isCompleted
                  ? theme.textTheme.bodyText2.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2.0,
                      color: theme.textTheme.bodyText2.color.withOpacity(0.75),
                    )
                  : theme.textTheme.bodyText2,
              duration: Duration(milliseconds: 550),
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
