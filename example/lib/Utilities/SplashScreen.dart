import 'package:flutter/material.dart';

import '../screens/main/pages/RTK_Views/Main_Screen/Main_Screen.dart';

//splash
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

//
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a long-running task (e.g., loading data, authenticating user)
    _mockCheckForSession().then(
      (status) async {
        if (status) {
          //  await ConnectionPage().createState().showSimpleDialog(context);
          //  navigate to the main screen
          _navigateToMainScreen();
        }
      },
    );
  }

  // Simulate a long-running task
  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(seconds: 2));
    return true; // Replace this with your actual check (e.g., authentication)
  }

  // Navigate to the main screen
  void _navigateToMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => MyApp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          // No need for the Image widget here; the native splash screen will handle it
          child: Image.asset(
            'assets/MARS_ROBOTICS.jpg', // Replace with your actual asset path
            fit: BoxFit.contain, // Adjust the fit as needed
          ),
        ),
      );
}
