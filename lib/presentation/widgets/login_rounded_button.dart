//@dart=2.9
import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const RoundedButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        width: size.width * 0.8,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: kPrimaryColor,
        ),
        padding: EdgeInsets.symmetric(vertical: 20.0),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
