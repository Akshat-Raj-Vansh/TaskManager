//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/constants/constraints.dart';
import 'package:taskmanager/constants/strings.dart';
import 'package:taskmanager/data/models/user.dart';
import 'package:taskmanager/data/providers/auth.dart';
import 'package:taskmanager/presentation/widgets/profile_button.dart';
import 'package:taskmanager/presentation/widgets/profile_settings.dart';
import 'package:taskmanager/presentation/widgets/profile_status.dart';

class ProfileScreenUI extends StatelessWidget {
  final status;
  const ProfileScreenUI({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    User _user = Provider.of<Auth>(context, listen: false).user;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 25.0,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: kPrimaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Positioned(
              top: size.height * 0.10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: size.height * 0.85,
                width: size.width,
                decoration: kBoxDecorationPrimary,
              ),
            ),
            Positioned(
              top: size.height * 0.10 - size.width * 0.15,
              left: size.width * 0.30,
              child: TasksStatus(
                status: status,
              ), // ProfilePic(),
            ),
            Positioned(
              top: size.height * 0.10 + size.width * 0.15 + 30,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      ProfileButton(
                        text: _user.name,
                        icon: Icons.person_outline_outlined,
                        function: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Username: ${_user.name}'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      ProfileButton(
                        text: _user.email,
                        icon: Icons.email_outlined,
                        function: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email: ${_user.email}'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      ProfileButton(
                        text: 'Settings',
                        icon: Icons.settings_outlined,
                        function: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (_) {
                              return GestureDetector(
                                onTap: () {},
                                behavior: HitTestBehavior.opaque,
                                child: Settings(size: size),
                              );
                            },
                          );
                        },
                      ),
                      // ProfileButton(
                      //   text: 'Help Centre',
                      //   icon: Icons.help_center_outlined,
                      //   function: () {
                      //     showModalBottomSheet(
                      //       context: context,
                      //       backgroundColor: Colors.transparent,
                      //       isScrollControlled: true,
                      //       builder: (_) {
                      //         return GestureDetector(
                      //           onTap: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //           behavior: HitTestBehavior.opaque,
                      //           child: Container(
                      //             decoration: kBoxDecorationWhite,
                      //             height: size.height * 0.3,
                      //             child: Center(
                      //               child: Text(
                      //                 'Need some help?',
                      //                 style: TextStyle(color: kPrimaryColor),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      // ),
                      ProfileButton(
                        function: () async {
                          await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Are you sure?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor,
                                  fontSize: 20,
                                ),
                              ),
                              content: Text(
                                'Do you want to logout the app?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: kPrimaryColor,
                                  fontSize: 15,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Provider.of<Auth>(context, listen: false)
                                        .logout();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        text: 'Log Out',
                        icon: Icons.logout_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
