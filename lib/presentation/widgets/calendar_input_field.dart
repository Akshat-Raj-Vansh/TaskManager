//@dart=2.9
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/constants/colors.dart';

class UserInputField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const UserInputField({Key key, this.controller, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.80,
      child: TextFormField(
        controller: controller,
        cursorColor: kPrimaryColor,
        maxLines: text == 'Title' ? 1 : 3,
        style: text == 'Title'
            ? GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              )
            : GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                letterSpacing: 1.2,
                fontSize: 18.0,
              ),
        decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(color: kSecondaryColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
        ),
      ),
    );
  }
}
