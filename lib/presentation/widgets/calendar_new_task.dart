//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/constants/constraints.dart';
import 'package:taskmanager/data/models/task.dart';
import 'package:taskmanager/data/providers/tasks.dart';
import 'package:taskmanager/presentation/widgets/calendar_input_field.dart';
import 'package:taskmanager/presentation/widgets/calendar_rounded_button.dart';

class NewTask extends StatefulWidget {
  // final Tasks tasksData;
  final String action;
  final Task task;
  final DateTime date;

  const NewTask({Key key, this.action, this.task, this.date}) : super(key: key);
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  var isCompleted = false;
  var isLoading = false;

  var selectedDate;

  void _submitData() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });
    if (titleController.text.isEmpty || descController.text.isEmpty) return;
    final enteredTitle = titleController.text;
    final enteredDesc = descController.text;

    try {
      if (widget.action == 'add')
        // Creating a new task
        Provider.of<Tasks>(context, listen: false)
            .createTask(
          Task(
            title: enteredTitle,
            description: enteredDesc,
            date: widget.date,
          ),
        )
            .then((_) {
          setState(() {
            isLoading = false;
            Navigator.of(context).pop();
          });
        });
      if (widget.action == 'edit')
        // Updating task
        Provider.of<Tasks>(context, listen: false)
            .updateTask(
          Task(
            id: widget.task.id,
            title: enteredTitle,
            description: enteredDesc,
            completed: isCompleted,
            date: selectedDate != null ? selectedDate : widget.date,
          ),
        )
            .then((_) {
          setState(() {
            isLoading = false;
            Navigator.of(context).pop();
          });
        });
    } catch (error) {
      print('TASKS:' + error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.action == 'edit' ? widget.task.title : '';
    descController.text =
        widget.action == 'edit' ? widget.task.description : '';
    isCompleted = widget.action == 'edit' ? widget.task.completed : false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var viewInsets = mediaQuery.viewInsets.bottom;
    var devHeight = mediaQuery.size.height;

    void _presentDatePicker() {
      var dateOfTaskCreation = widget.task.date;
      var currentDate = DateTime.now();
      showDatePicker(
        context: context,
        initialDate: widget.task.date,
        firstDate: currentDate.compareTo(dateOfTaskCreation) > 0
            ? dateOfTaskCreation
            : currentDate,
        lastDate: DateTime(2023),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: Theme.of(context).copyWith(
              primaryColor: kPrimaryColor,
              accentColor: kPrimaryColor,
              colorScheme: ColorScheme.light(primary: kPrimaryColor),
            ),
            child: child,
          );
        },
      ).then((pickedDate) {
        if (pickedDate == null) return;
        setState(() {
          selectedDate = pickedDate;
        });
      });
    }

    return Container(
      decoration: kBoxDecorationWhite,
      height: viewInsets + devHeight * (widget.action == 'edit' ? 0.45 : 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.0),
            color: kPrimaryColor,
            width: mediaQuery.size.width * 0.10,
            height: 3.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              UserInputField(
                controller: titleController,
                text: 'Title',
              ),
              UserInputField(
                controller: descController,
                text: 'Description',
              ),
            ],
          ),
          Column(
            children: [
              if (widget.action == 'edit')
                Container(
                  height: 80,
                  width: mediaQuery.size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate == null
                            ? 'Current Date: ${DateFormat.yMMMd().format(widget.date)}'
                            : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}',
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Reschedule Task',
                          style: TextStyle(
                            color: kSecondaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              Container(
                height: 80,
                width: mediaQuery.size.width * 0.80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (widget.action == 'edit')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Completed",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 18,
                            ),
                          ),
                          Checkbox(
                            value: isCompleted,
                            onChanged: (value) {
                              setState(() {
                                isCompleted = value;
                              });
                            },
                            activeColor: kSecondaryColor,
                            checkColor: Colors.white,
                          )
                        ],
                      ),
                    isLoading
                        ? Container(
                            width: 80,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: kAccentColor,
                              ),
                            ),
                          )
                        : RoundedButton(
                            title: 'SAVE',
                            onClick: () {
                              _submitData();
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      //  Stack(
      //   alignment: Alignment.center,
      //   fit: StackFit.expand,
      //   children: [
      //     Positioned(
      //       top: 0,
      //       child: Container(
      //         margin: EdgeInsets.only(top: 5.0),
      //         color: kPrimaryColor,
      //         width: mediaQuery.size.width * 0.10,
      //         height: 3.0,
      //       ),
      //     ),
      //     Positioned(
      //       top: 30,
      //       child: Column(
      //         children: [
      //           UserInputField(
      //             controller: titleController,
      //             text: 'Title',
      //           ),
      //           UserInputField(
      //             controller: descController,
      //             text: 'Description',
      //           ),
      //         ],
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 20,
      //       child: Column(
      //         children: [
      //           if (widget.action == 'edit')
      //             Container(
      //               height: 80,
      //               width: mediaQuery.size.width * 0.80,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(
      //                     selectedDate == null
      //                         ? 'Current Date: ${DateFormat.yMMMd().format(widget.date)}'
      //                         : 'Picked Date: ${DateFormat.yMMMd().format(selectedDate)}',
      //                     style: TextStyle(
      //                       color: kPrimaryColor,
      //                     ),
      //                   ),
      //                   TextButton(
      //                     onPressed: _presentDatePicker,
      //                     child: Text(
      //                       'Reschedule Task',
      //                       style: TextStyle(
      //                         color: kSecondaryColor,
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               if (widget.action == 'edit')
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text(
      //                       "Completed",
      //                       style: TextStyle(
      //                         color: kPrimaryColor,
      //                         fontSize: 18,
      //                       ),
      //                     ),
      //                     Checkbox(
      //                       value: isCompleted,
      //                       onChanged: (value) {
      //                         setState(() {
      //                           isCompleted = value;
      //                         });
      //                       },
      //                       activeColor: kSecondaryColor,
      //                       checkColor: Colors.white,
      //                     )
      //                   ],
      //                 ),
      //               isLoading
      //                   ? Container(
      //                       width: 80,
      //                       child: Center(
      //                         child: CircularProgressIndicator(
      //                           color: kAccentColor,
      //                         ),
      //                       ),
      //                     )
      //                   : RoundedButton(
      //                       title: 'SAVE',
      //                       onClick: () {
      //                         _submitData();
      //                       },
      //                     ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: mediaQuery.viewInsets.bottom,
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
