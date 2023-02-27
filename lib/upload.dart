// ignore_for_file: library_private_types_in_public_api, unused_field

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:ui';
import 'homepage.dart';
import 'myprofile.dart';
import 'search.dart';
import 'selectmedia.dart';
import 'mediaprovider.dart';
import 'settings.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final picker = ImagePicker();
  String _title = '';
  String _description = '';
  XFile? _mediaFile;
  XFile? _image;
  bool cameraImageLoaded =
      false; // to not reload the image in text input from user
  Uint8List? _imageBytes;

  // image from gallery
  void _setMediaFile(XFile mediaFile) {
    setState(() {
      _mediaFile = mediaFile;
    });
  }

  // image from camera
  void _setImage(XFile image) {
    setState(() {
      _image = image;
      _mediaFile = null; // for retake to work
      cameraImageLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MediaProvider(),
        builder: (context, child) {
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
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
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
                      MaterialPageRoute(
                          builder: (context) => const MyProfilePage()),
                    );
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  const Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Text(
                        'New post',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Sofia Sans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 98, 81, 102),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UploadMediaPage(
                                  onMediaSelected: _setMediaFile,
                                  onImageSelected: _setImage,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: _mediaFile != null
                                  ? Image.file(
                                      File(_mediaFile!.path),
                                      fit: BoxFit.cover,
                                    )
                                  : _image != null
                                      ? cameraImageLoaded == false
                                          ? FutureBuilder<Uint8List>(
                                              future: _image!.readAsBytes(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<Uint8List>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                }
                                                cameraImageLoaded = true;
                                                if (snapshot.hasError) {
                                                  return const Icon(
                                                      Icons.error);
                                                }
                                                if (snapshot.hasData) {
                                                  _imageBytes = snapshot.data;
                                                  return Image.memory(
                                                    _imageBytes!,
                                                    fit: BoxFit.cover,
                                                  );
                                                } else {
                                                  return const Icon(
                                                      Icons.photo);
                                                }
                                              },
                                            )
                                          : Image.memory(
                                              _imageBytes!,
                                              fit: BoxFit.cover,
                                            )
                                      : const Icon(Icons.photo),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            decoration: const InputDecoration(
                                hintText: 'Insert title',
                                labelStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onChanged: (value) {
                              setState(() {
                                _title = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: const TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            decoration: const InputDecoration(
                                hintText: 'Write here a short description',
                                labelStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none),
                            onChanged: (value) {
                              setState(() {
                                _description = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                );
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)))),
                              child: const Text('Upload'),
                            ),
                            const SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                        const SizedBox(height: 15.0)
                      ],
                    ),
                  ),
                ]),
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
                        MaterialPageRoute(
                            builder: (context) => const UploadPage()),
                      );
                    },
                  ),
                  label: 'Add',
                ),
              ],
            ),
          );
        });
  }
}
