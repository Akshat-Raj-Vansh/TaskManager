//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/presentation/widgets/login_input_form.dart';

class LoginScreenUI extends StatefulWidget {
  @override
  _LoginScreenUIState createState() => _LoginScreenUIState();
}

class _LoginScreenUIState extends State<LoginScreenUI>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;
  Animation<double> containerSize;
  AnimationController animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);

    animationController =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom;
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize =
        Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize)
            .animate(
      CurvedAnimation(parent: animationController, curve: Curves.linear),
    );

    return Scaffold(
      body: Stack(
        children: [
          // Log in Page
          AnimatedOpacity(
            opacity: isLogin ? 1.0 : 0.0,
            duration: animationDuration * 3,
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  height: size.height * 0.8,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Task Manager',
                        style: GoogleFonts.montez(
                          fontSize: 60.0,
                          color: kPrimaryColor,
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Image.asset(
                        'assets/images/checklist.png',
                        height: 200,
                        width: 200,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      InputForm(type: 'login'),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Sign up Page
          AnimatedBuilder(
            animation: animationController,
            builder: (ctx, child) {
              if (viewInset == 0 && isLogin)
                return buildRegisterContainer();
              else if (!isLogin) return buildRegisterContainer();

              // Returning empty container to hide the widget
              return Container();
            },
          ),

          AnimatedOpacity(
            opacity: isLogin ? 0.0 : 1.0,
            duration: animationDuration * 3,
            child: Visibility(
              visible: !isLogin,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height * 0.9,
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Task Manager',
                          style: GoogleFonts.montez(
                            fontSize: 60.0,
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Image.asset(
                          'assets/images/checklist.png',
                          height: 200,
                          width: 200,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        InputForm(type: 'signup'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Cancel Button
          AnimatedOpacity(
            opacity: isLogin ? 0.0 : 1.0,
            duration: animationDuration,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                  ),
                  onPressed: isLogin
                      ? null
                      : () {
                          animationController.reverse();
                          setState(() {
                            isLogin = !isLogin;
                          });
                        },
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100.0),
            topRight: Radius.circular(100.0),
          ),
          color: kBackgroundColor,
        ),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: isLogin
              ? () {
                  animationController.forward();
                  setState(() {
                    isLogin = !isLogin;
                  });
                }
              : null,
          child: isLogin
              ? Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 18.0,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
