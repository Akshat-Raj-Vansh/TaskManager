//@dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskmanager/constants/colors.dart';

class ShowDate extends StatelessWidget {
  final DateTime selectedDay, today;

  const ShowDate({Key key, this.selectedDay, this.today}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = new DateFormat.yMMMMEEEEd();
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        dateFormat.format(selectedDay) == dateFormat.format(today)
            ? 'Today'
            : dateFormat.format(selectedDay).toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: kColorWhite,
          fontWeight: FontWeight.w400,
          fontSize: 24,
        ),
      ),
    );
  }
}
