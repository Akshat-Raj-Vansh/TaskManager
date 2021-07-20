//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/constants/colors.dart';
import 'package:taskmanager/constants/strings.dart';
import 'package:taskmanager/data/models/status.dart';
import 'package:taskmanager/data/providers/auth.dart';
import 'package:taskmanager/presentation/screens/CalendarTaskUI.dart';
import 'package:taskmanager/presentation/screens/LoginScreenUI.dart';
import 'package:taskmanager/presentation/screens/ProfileScreenUI.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => LoginScreenUI(),
        );
      case PROFILE_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => Consumer<Auth>(
            builder: (ctx, auth, _) => auth.isAuth
                ? ProfileScreenUI(status: settings.arguments as Status)
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) => authResultSnapshot
                                .connectionState ==
                            ConnectionState.waiting
                        ? Center(
                            child:
                                CircularProgressIndicator(color: kAccentColor),
                          )
                        : LoginScreenUI(),
                  ),
          ),
        );
      case TASK_SCREEN_ROUTE:
        return MaterialPageRoute(
          builder: (_) => CalendarTaskUI(),
        );

      default:
        return null;
    }
  }
}
