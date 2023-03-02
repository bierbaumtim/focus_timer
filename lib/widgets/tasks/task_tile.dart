import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/task.dart';
import '../../state_models/tasks_model.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  const TaskTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey('${task.uuid}_dismiss'),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) => context.read<TasksModel>().removeTask(task),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => context
                .read<TasksModel>()
                .updateTask(task.copyWith(isCompleted: !task.isCompleted)),
            activeColor: theme.colorScheme.secondary
                .withOpacity(task.isCompleted ? 0.75 : 1.0),
            checkColor: theme.canvasColor,
          ),
          title: AnimatedDefaultTextStyle(
            style: task.isCompleted
                ? theme.textTheme.bodyMedium!.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 2.0,
                    color: theme.textTheme.bodyMedium!.color!.withOpacity(0.75),
                  )
                : theme.textTheme.bodyMedium!,
            duration: const Duration(milliseconds: 550),
            child: Text(
              task.name,
            ),
          ),
        ),
      ),
    );
  }
}
