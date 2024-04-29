import 'package:flutter/material.dart';
import 'package:fmtc_example/screens/main/pages/RTK_Views/Main_Screen/Main_Screen.dart';

import 'SplashScreen.dart';
import '../screens/main/pages/RTK_Views/Dashboard_Screen/Dashboard_Screen.dart';


class MySplash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MySplashState();
}

class MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Splash Screen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(), // Set the SplashScreen as the initial route
        routes: {
          '/main_screen': (context) =>
               MyApp(), // Define the main screen route
        },
      );
}