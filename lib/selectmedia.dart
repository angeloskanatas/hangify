// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'homepage.dart';
import 'mediaprovider.dart';
import 'myprofile.dart';
import 'settings.dart';

class UploadMediaPage extends StatefulWidget {
  const UploadMediaPage({
    Key? key,
    required this.onMediaSelected,
    required this.onImageSelected,
  }) : super(key: key);

  final void Function(XFile mediaFile) onMediaSelected;
  final void Function(XFile image) onImageSelected;

  @override
  _UploadMediaPageState createState() => _UploadMediaPageState();
}

class _UploadMediaPageState extends State<UploadMediaPage> {
  final picker = ImagePicker();

  Future<void> _pickMedia(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final xfile = XFile(file.path);
      final provider = Provider.of<MediaProvider>(context, listen: false);

      if (source == ImageSource.camera) {
        provider.setImage(file);
        widget.onImageSelected(xfile);
      } else if (source == ImageSource.gallery) {
        provider.setMediaFile(file);
        widget.onMediaSelected(xfile);
      }

      // rebuild the UI to display the new image
      setState(() {});

      // go back to the UploadMediaPage
      Navigator.pop(context, xfile);
    } else {
      if (source == ImageSource.camera) {
        // show the camera to retake the picture
        _pickMedia(ImageSource.camera);
      } else if (source == ImageSource.gallery) {
        // do nothing, user canceled the gallery selection
      }
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<MediaProvider>(
                builder: (context, provider, child) {
                  if (provider.image != null) {
                    return Column(
                      children: [
                        Image.file(provider.image!),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _pickMedia(ImageSource.camera),
                              child: const Text('Retake the picture'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () => _pickMedia(ImageSource.gallery),
                              child: const Text('Select from gallery'),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const Text('No photo selected'),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _pickMedia(ImageSource.camera),
                              child: const Text('Take a picture'),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () => _pickMedia(ImageSource.gallery),
                              child: const Text('Select from gallery'),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
