//@dart=2.9
import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class ProfileButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double top;
  final Function function;

  const ProfileButton({Key key, this.function, this.top, this.text, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: TextButton(
        onPressed: () {
          function();
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: kColor1.withAlpha(50),
          backgroundColor: kColorWhite,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: 30.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: kPrimaryColor.withAlpha(150),
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: kPrimaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
