import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class TasksStatus extends StatelessWidget {
  final status;
  const TasksStatus({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.width * 0.3,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(40.0),
        ),
        border: Border.all(
          color: kPrimaryColor,
          width: 3,
        ),
      ),
      padding: EdgeInsets.all(size.width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.timer,
                color: Color(0xffff9e00),
                size: 40,
              ),
              Icon(
                Icons.done,
                color: Color(0xff00cf8d),
                size: 40,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                status.incomplete.toString(),
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                status.completed.toString(),
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
