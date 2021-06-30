//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/data/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key key, this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      elevation: 0,
      shadowColor: Colors.white,
      child: Row(
        children: [
          task.completed
              ? Icon(
                  Icons.done,
                  color: Color(0xff00cf8d),
                  size: 30,
                )
              : Icon(
                  Icons.timer,
                  color: Color(0xffff9e00),
                  size: 30,
                ),
          SizedBox(
            width: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10),
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${task.title}',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  task.description,
                  style: GoogleFonts.poiretOne(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
