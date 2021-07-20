import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/constants/icons.dart';
import 'package:taskmanager/constants/strings.dart';

const kBoxDecorationWhite = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
  ),
);

const kBoxDecorationStatus = BoxDecoration(
  color: kColorWhite,
  borderRadius: BorderRadius.all(
    Radius.circular(40.0),
  ),
);

const kBoxDecorationPrimary = BoxDecoration(
  color: kPrimaryColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40.0),
    topRight: Radius.circular(40.0),
  ),
);

const kPasswordTextfieldDecoration = InputDecoration(
  icon: Icon(
    icon_password,
    color: kPrimaryColor,
  ),
  hintText: hint_password,
  border: InputBorder.none,
);

const kUsernameTextFieldDecoration = InputDecoration(
  icon: Icon(
    icon_username,
    color: kPrimaryColor,
  ),
  hintText: hint_username,
  border: InputBorder.none,
);

const kEmailTextFieldDecoration = InputDecoration(
  icon: Icon(
    icon_email,
    color: kPrimaryColor,
  ),
  hintText: hint_email,
  border: InputBorder.none,
);
