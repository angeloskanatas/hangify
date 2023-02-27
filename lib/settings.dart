// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:ui';
import 'homepage.dart';
import 'main.dart';
import 'search.dart';
import 'upload.dart';
import 'myprofile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // initial state
  bool _enableGPS = false;
  bool _enableCamera = false;
  double _searchRange = 5.0;
  String _display = '5';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.settings),
          color: Colors.black,
          onPressed: () {},
        ),
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Text(
            'Hangify',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'mySofia',
              fontWeight: FontWeight.w400,
              fontSize: 25,
              letterSpacing: 0.01,
              fontFeatures: [
                FontFeature.enable('pnum'),
                FontFeature.enable('lnum')
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyProfilePage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Sofia Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 24.0,
                  letterSpacing: 0.01,
                  fontFeatures: [
                    FontFeature.enable('pnum'),
                    FontFeature.enable('lnum')
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  const Text(
                    'Enable GPS',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Switch(
                    value: _enableGPS,
                    onChanged: (value) {
                      setState(() {
                        _enableGPS = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text(
                    'Enable Camera',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Expanded(child: Container()),
                  Switch(
                    value: _enableCamera,
                    onChanged: (value) {
                      setState(() {
                        _enableCamera = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Search range',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Expanded(
                    child: Slider(
                      value: _searchRange,
                      min: 0.0,
                      max: 10.0,
                      divisions: 10,
                      onChanged: (value) {
                        setState(() {
                          _searchRange = value;
                          if (_searchRange == 10) {
                            _display = '>10';
                          } else if (_searchRange == 0) {
                            _display = '<1';
                          } else {
                            _display = _searchRange.toStringAsFixed(0);
                          }
                        });
                      },
                    ),
                  ),
                  Text(_display),
                ],
              ),
              const SizedBox(height: 25.0),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginSignUpPage()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xff6750A4),
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  // todo:delete user
                },
                child: const Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 102, 102, 102),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            label: 'Back',
          ),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Image.asset('assets/icons/HangifyLogo.png'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                iconSize: 10.0,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
            icon: GestureDetector(
              child: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 102, 102, 102),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadPage()),
                );
              },
            ),
            label: 'Add',
          ),
        ],
      ),
    );
  }
}
