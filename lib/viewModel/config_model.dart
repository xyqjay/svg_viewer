import 'package:flutter/material.dart';

class ImageTheme {
  final Color backGroundColor;
  final Color imgColor;

  const ImageTheme({required this.backGroundColor, required this.imgColor});
}

const _themes = [
  ImageTheme(backGroundColor: Colors.white, imgColor: Colors.black),
  ImageTheme(backGroundColor: Colors.black, imgColor: Colors.white),
  ImageTheme(backGroundColor: Color(0xffff8b8b), imgColor: Color(0xFFF9F7E8)),
  ImageTheme(backGroundColor: Color(0xFFF9F7E8), imgColor: Color(0xFF61BFAD)),
  ImageTheme(backGroundColor: Color(0xFF61BFAD), imgColor: Colors.white),
];

const backGroundColors = [
  Color(0xff999999),
];

const imageColors = [
  Color(0xffffffff),
];

class ConfigModel extends ChangeNotifier {
  ImageTheme _selectedTheme = _themes.first;

  ImageTheme get theme => _selectedTheme;

  List<ImageTheme> get themes => _themes;

  int _scale = 4;
  int get scale => _scale;

  void setTheme(ImageTheme theme) {
    _selectedTheme = theme;
    notifyListeners();
  }

  bool isSelect(ImageTheme theme) {
    return _selectedTheme == theme;
  }

  void zoomIn() {
    if (_scale >= 8) return;
    _scale += 1;
    notifyListeners();
  }

  void zoomOut() {
    if (_scale <= 1) return;
    _scale -= 1;
    notifyListeners();
  }

  void zoomValue(double value) {
    int val = value.toInt();
    if (val > 8) {
      val = 8;
    } else if (val < 1) {
      val = 1;
    }
    _scale = val;
    notifyListeners();
  }
}
