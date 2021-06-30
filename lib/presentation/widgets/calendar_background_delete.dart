import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class SecondaryBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.delete,
        color: kPrimaryColor,
        size: 25,
      ),
    );
  }
}
