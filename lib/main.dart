//@dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:taskmanager/data/network_service.dart';
import 'package:taskmanager/data/notification_service.dart';
import 'package:taskmanager/data/providers/auth.dart';
import 'package:taskmanager/data/providers/tasks.dart';
import 'package:taskmanager/presentation/router.dart';
import 'package:taskmanager/presentation/screens/CalendarTaskUI.dart';
import 'package:taskmanager/presentation/screens/LoginScreenUI.dart';
import 'package:taskmanager/presentation/screens/SplashScreenUI.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().init();
  runApp(TaskManager(
    router: AppRouter(),
  ));
}

class TaskManager extends StatelessWidget {
  final AppRouter router;

  const TaskManager({Key key, this.router}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // NotificationService().showNotification('Hello');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(NetworkService()),
        ),
        ChangeNotifierProxyProvider<Auth, Tasks>(
          create: (ctx) => Tasks(null, null, []),
          update: (ctx, auth, prevTasks) => Tasks(
            auth.user,
            auth.api,
            prevTasks == null ? [] : prevTasks.tasks,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: kPrimaryColor,
            accentColor: kAccentColor,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: kSecondaryColor,
              selectionColor: kAccentColor,
              selectionHandleColor: kSecondaryColor,
            ),
            textTheme: GoogleFonts.comfortaaTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          home: auth.isAuth
              ? FutureBuilder(
                  future: Provider.of<Tasks>(ctx, listen: false).fetchTasks(),
                  builder: (ctx, tasksSnapshot) =>
                      tasksSnapshot.connectionState == ConnectionState.waiting
                          ? SplashScreenUI()
                          : CalendarTaskUI(),
                )
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreenUI()
                          : LoginScreenUI(),
                ),
          onGenerateRoute: router.generateRoute,
        ),
      ),
    );
  }
}
