// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'login.dart';
import 'mediaprovider.dart';
import 'signup.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MediaProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

// Palette
MaterialColor myPrimaryColor = const MaterialColor(0xff6750A4, {
  50: Color(0xffe1dfec),
  100: Color(0xffc3c0d8),
  200: Color(0xffa29fc4),
  300: Color(0xff827eaf),
  400: Color(0xff6c6ca1),
  500: Color(0xff6750A4),
  600: Color(0xff5b4893),
  700: Color(0xff4d3f81),
  800: Color(0xff3f366f),
  900: Color(0xff2e254f)
});

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hangify',
      theme: ThemeData(
        primarySwatch: myPrimaryColor,
        fontFamily: 'Roboto',
      ),
      home: const LoginSignUpPage(),
    );
  }
}

class LoginSignUpPage extends StatelessWidget {
  const LoginSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Hangify',
                  style: TextStyle(
                    fontFamily: 'mySofia',
                    fontWeight: FontWeight.w400,
                    fontSize: 64,
                    color: Colors.black,
                    letterSpacing: 0.01,
                    fontFeatures: [
                      FontFeature.enable('pnum'),
                      FontFeature.enable('lnum')
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 172),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: myPrimaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(37.5),
                  ),
                  minimumSize: const Size(180, 75.5),
                ),
                child: const Text(
                  'Signup',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: myPrimaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(37.5),
                  ),
                  minimumSize: const Size(180, 75.5),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
