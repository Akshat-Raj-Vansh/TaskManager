//@dart=2.9
import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onClick;
  const RoundedButton({Key key, this.title, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kPrimaryColor,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 30.0,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
