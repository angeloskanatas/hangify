// ignore_for_file: sized_box_for_whitespace, unused_field, no_leading_underscores_for_local_identifiers, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hangify/main.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'questionnaire.dart';
import 'database.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();
  String? _username;
  String? _email;
  DateTime? _birthDate;
  String? _password;
  String? _reEnterPassword;

  @override
  void dispose() {
    _birthDateController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_password != _reEnterPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Passwords do not match"),
          ),
        );
        return;
      }

      // create a new user object
      User newUser = User(
        name: _username!,
        email: _email!,
        birthDate: _birthDate!,
        password: _password!,
      );

      // add the user to the database
      DatabaseHelper databaseHelper = DatabaseHelper.instance;
      await databaseHelper.insertUser(newUser);

      // navigate to the questionnaire page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const QuestionnairePage()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontFamily: 'Sofia-Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                        color: Colors.black,
                        letterSpacing: 0.01,
                        fontFeatures: [
                          FontFeature.enable('pnum'),
                          FontFeature.enable('lnum')
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: 312,
                    child: TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username *',
                        hintText: 'Enter here',
                      ),
                      onSaved: (String? value) {
                        _username = value;
                      },
                      validator: (String? _username) {
                        if (_username == null || _username.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 312,
                    child: TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail *',
                        hintText: 'Enter here',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (String? value) {
                        _email = value;
                      },
                      validator: (String? _email) {
                        if (_email == null || _email.isEmpty) {
                          return 'Please enter your e-mail address';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 312,
                    child: TextFormField(
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        labelText: 'Birth date',
                        hintText: 'Enter birth date',
                        suffixIcon: InkWell(
                          onTap: () async {
                            final DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (selectedDate != null) {
                              setState(() {
                                _birthDate = selectedDate;
                                _birthDateController.text =
                                    DateFormat('MM/dd/yyyy')
                                        .format(_birthDate!);
                              });
                            }
                          },
                          child: const Icon(Icons.calendar_today),
                        ),
                      ),
                      enabled: true,
                      keyboardType: TextInputType.name,
                      controller: _birthDateController,
                      onSaved: (value) {
                        _birthDate = DateFormat('MM/dd/yyyy').parse(value!);
                        _birthDateController.text =
                            DateFormat('MM/dd/yyyy').format(_birthDate!);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter birth date';
                        }
                        final validFormat = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                        if (!validFormat.hasMatch(value)) {
                          return 'Non-valid birth date format';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 312,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password *',
                        hintText: 'Enter here',
                      ),
                      onSaved: (String? value) {
                        _password = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 312,
                    child: TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-enter password *',
                        hintText: 'Enter here',
                      ),
                      onSaved: (String? value) {
                        _reEnterPassword = value;
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter your password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        primary: myPrimaryColor,
                        onPrimary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                      ),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
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
