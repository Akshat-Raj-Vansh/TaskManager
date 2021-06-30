import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(left: 10),
      child: Icon(
        Icons.edit,
        color: kPrimaryColor,
        size: 25,
      ),
    );
  }
}
