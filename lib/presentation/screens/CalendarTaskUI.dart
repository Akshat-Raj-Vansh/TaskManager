//@dart=2.9
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/constants/constraints.dart';
import 'package:taskmanager/constants/strings.dart';
import 'package:taskmanager/data/providers/tasks.dart';
import 'package:taskmanager/presentation/widgets/calendar_new_task.dart';
import 'package:taskmanager/presentation/widgets/calendar_show_date.dart';
import 'package:taskmanager/presentation/widgets/calendar_task_list.dart';

class CalendarTaskUI extends StatefulWidget {
  @override
  _CalendarTaskUIState createState() => _CalendarTaskUIState();
}

class _CalendarTaskUIState extends State<CalendarTaskUI> {
  TextEditingController tfTitleController = TextEditingController();
  TextEditingController tfDecController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  CalendarFormat format = CalendarFormat.month;
  DateTime _today = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateFormat dateFormat = new DateFormat.yMMMMEEEEd();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _taskList = Provider.of<Tasks>(context, listen: false).tasks;

    void addTaskSheet(BuildContext context, String action) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTask(action: action, date: _selectedDay));
        },
      );
    }

    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Are you sure?',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
              content: Text(
                'Do you want to exit an App',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: kPrimaryColor,
                  fontSize: 15,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(
                      color: kSecondaryColor,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: kSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text(
            TASK_SCREEN_TITLE,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 25.0,
            ),
          ),
          leading: InkWell(
            onTap: () {
              setState(() {
                format = format == CalendarFormat.month
                    ? CalendarFormat.week
                    : CalendarFormat.month;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 15.0,
                left: 5.0,
                bottom: 15.0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 2.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: kPrimaryColor,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  format == CalendarFormat.month ? 'Month' : 'Week',
                  style: TextStyle(
                    fontSize: 14,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle_outlined),
              color: kPrimaryColor,
              iconSize: 28.0,
              onPressed: () {
                Navigator.pushNamed(context, PROFILE_SCREEN_ROUTE);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              // Calendar Widget
              TableCalendar(
                focusedDay: _focusedDay,
                firstDay: DateTime(2018),
                lastDay: DateTime(2025),
                calendarFormat: format,
                onFormatChanged: (CalendarFormat _format) {
                  setState(() {
                    format = _format;
                  });
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                daysOfWeekVisible: true,
                onDaySelected: (DateTime selectDay, DateTime focusDay) {
                  setState(() {
                    _selectedDay = selectDay;
                    _focusedDay = focusDay;
                  });
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                ),
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(_selectedDay, date);
                },
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, date, today) {
                    var taskListIn = _taskList
                        .where((task) =>
                            isSameDay(task.date, date) && !task.completed)
                        .toList();
                    var taskListCo = _taskList
                        .where((task) =>
                            isSameDay(task.date, date) && task.completed)
                        .toList();
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: taskListIn.isNotEmpty
                            ? Border.all(color: Colors.red)
                            : taskListCo.isNotEmpty
                                ? Border.all(color: Colors.green)
                                : null,
                      ),
                      child: Text(
                        date.day.toString(),
                      ),
                    );
                  },
                  selectedBuilder: (context, date, events) => Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSameDay(_selectedDay, _today)
                          ? kPrimaryColor
                          : kAccentColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: isSameDay(_selectedDay, _today)
                            ? kColor3
                            : kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  todayBuilder: (context, date, events) => Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(
                        color: kColor3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: kSecondaryColor,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: kSecondaryColor,
                    )),
              ),

              SizedBox(height: 30),

              // Blue Sliding Window
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: size.height * 0.80,
                width: size.width,
                decoration: kBoxDecorationPrimary,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // White handle bar on Blue Window
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      color: Colors.white,
                      width: size.width * 0.10,
                      height: 3.0,
                    ),

                    // Date Showing on Blue Window
                    ShowDate(
                      selectedDay: _selectedDay,
                      today: _today,
                    ),

                    // Task List
                    TaskList(
                      date: _selectedDay,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white12,
                blurRadius: 30,
              ),
            ],
          ),
          child: RawMaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              // Add Task
              addTaskSheet(context, 'add');
            },
            child: Icon(
              Icons.add,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
