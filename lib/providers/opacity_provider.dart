import 'package:flutter/material.dart';

class OpacityProvider extends ChangeNotifier {
  Opacity canvas = Opacity(opacity: 0.0,);
  bool showCanvas = false;

  updateCanvas(Opacity canv, bool show) {
    canvas = canv;
    showCanvas = show;
    notifyListeners();
  }
}