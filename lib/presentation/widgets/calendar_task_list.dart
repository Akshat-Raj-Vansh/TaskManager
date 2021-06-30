//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmanager/data/models/task.dart';
import 'package:taskmanager/data/providers/tasks.dart';
import 'package:taskmanager/presentation/widgets/calendar_background_edit.dart';
import 'package:taskmanager/presentation/widgets/calendar_background_delete.dart';
import 'package:taskmanager/presentation/widgets/calendar_new_task.dart';
import 'package:taskmanager/presentation/widgets/calendar_task_card.dart';

class TaskList extends StatefulWidget {
  final DateTime date;
  final Function refresh;

  const TaskList({Key key, this.date, this.refresh}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    var taskList = Provider.of<Tasks>(context, listen: true)
        .tasks
        .where((tasks) => isSameDay(tasks.date, widget.date))
        .toList();

    return Consumer<Tasks>(
      builder: (ctx, taskData, _) => Container(
        child: Expanded(
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  Task task = taskList[index];

                  // Delete task from database
                  taskData.deleteTask(task);

                  //Show message for deleting task
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text(
                        '${task.title} task deleted',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                } else {
                  // Update Task by opening modal screen
                  Task task = taskList[index];

                  // Show modal sheet
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (_) {
                      return GestureDetector(
                        onTap: () {},
                        behavior: HitTestBehavior.opaque,
                        child: NewTask(
                            action: 'edit', task: task, date: widget.date),
                      );
                    },
                  ).then((value) {
                    setState(() {});
                  });
                }
              },
              background: Background(),
              secondaryBackground: SecondaryBackground(),
              child: TaskCard(
                task: taskList[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
