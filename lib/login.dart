// ignore_for_file: sized_box_for_whitespace, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:hangify/main.dart';
import 'database.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // error dialog
  Future<void> _showErrorDialog(String message) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: myPrimaryColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final dbHelper = DatabaseHelper.instance;
      final user = await dbHelper.getUserByEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );

      if (user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      } else {
        _showErrorDialog(
            'Invalid e-mail/password combination. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 150),
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
                  const SizedBox(height: 133),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: 238,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7E0EC),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Enter here',
                              labelText: 'E-mail',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your e-mail';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 238,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE7E0EC),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Enter here',
                              labelText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      primary: myPrimaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 20),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
