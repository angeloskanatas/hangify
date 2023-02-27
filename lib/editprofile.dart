// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui';
import 'homepage.dart';
import 'myprofile.dart';
import 'settings.dart';

class ProfileEditingPage extends StatefulWidget {
  const ProfileEditingPage({Key? key}) : super(key: key);

  @override
  _ProfileEditingPageState createState() => _ProfileEditingPageState();
}

class _ProfileEditingPageState extends State<ProfileEditingPage> {
  // Define variables for profile picture and information editing
  String _username = 'Aggelos Ui/Ux';
  String _currentDescription = 'ui/ux dev 4 life';
  final String _currentPassword = '';
  String _newPassword = '';
  String _reEnteredNewPassword = '';
  File? _imageFile;

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!) as ImageProvider<Object>
                      : const AssetImage('assets/images/aggelos.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _pickImage,
                child: const Text(
                  'Change profile picture',
                  style: TextStyle(
                    color: Color(0xff6750A4),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _username,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _username = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: _currentDescription,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _currentDescription = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Current password',
                        hintText: 'Enter here',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New password',
                        hintText: 'Enter here',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _newPassword = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-enter new password',
                      ),
                      onChanged: (value) {
                        setState(() {
                          _reEnteredNewPassword = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_newPassword != _reEnteredNewPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Passwords do not match"),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff6750A4),
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
                child: const Text(
                  'Save',
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
    );
  }
}
