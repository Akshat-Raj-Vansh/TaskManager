//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/data/providers/auth.dart';

class Settings extends StatelessWidget {
  final Size size;

  const Settings({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.4,
      child: Column(
        children: [
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          //   width: size.width,
          //   padding: EdgeInsets.symmetric(horizontal: 5),
          //   child: TextButton(
          //     onPressed: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text('Notifications Settings'),
          //         ),
          //       );
          //     },
          //     style: TextButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30.0),
          //       ),
          //       primary: kColor1.withAlpha(50),
          //       backgroundColor: kColorWhite,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 20,
          //         vertical: 12,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Icon(
          //             Icons.notifications_active_outlined,
          //             color: kPrimaryColor,
          //             size: 30.0,
          //           ),
          //           Expanded(
          //             child: Padding(
          //               padding: const EdgeInsets.only(left: 10.0),
          //               child: Text(
          //                 'Notifications Settings',
          //                 style: TextStyle(
          //                   color: kPrimaryColor,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios,
          //             color: kPrimaryColor,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
          //   width: size.width,
          //   padding: EdgeInsets.symmetric(horizontal: 5),
          //   child: TextButton(
          //     onPressed: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(
          //           content: Text('Change Password'),
          //         ),
          //       );
          //     },
          //     style: TextButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30.0),
          //       ),
          //       primary: kColor1.withAlpha(50),
          //       backgroundColor: kColorWhite,
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 20,
          //         vertical: 12,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Icon(
          //             Icons.change_circle,
          //             color: kPrimaryColor,
          //             size: 30.0,
          //           ),
          //           Expanded(
          //             child: Padding(
          //               padding: const EdgeInsets.only(left: 10.0),
          //               child: Text(
          //                 'Change Password',
          //                 style: TextStyle(
          //                   color: kPrimaryColor,
          //                   fontSize: 16.0,
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios,
          //             color: kPrimaryColor,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: TextButton(
              onPressed: () async {
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
                      'Do you want to delete the account?',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: kPrimaryColor,
                        fontSize: 15,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: kSecondaryColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false).delete();
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
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                      size: 30.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Delete Account',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
