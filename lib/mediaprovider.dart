import 'dart:io';
import 'package:flutter/foundation.dart';

class MediaProvider extends ChangeNotifier {
  File? _image;
  File? _mediaFile;

  void setImage(File file) {
    _image = file;
    notifyListeners();
  }

  void setMediaFile(File file) {
    _mediaFile = file;
    notifyListeners();
  }

  File? get image => _image;
  File? get mediaFile => _mediaFile;
}
