//@dart=2.9

import 'package:flutter/material.dart';
import 'package:taskmanager/constants/colors.dart';

class SplashScreenUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  fontFamily: 'Montez',
                  fontSize: 100.0,
                  color: kPrimaryColor,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CircularProgressIndicator(
                color: kAccentColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
