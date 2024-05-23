import 'package:flutter/material.dart';

class OpacityProvider extends ChangeNotifier {
  Opacity canvas = Opacity(opacity: 0.0,);
  bool showCanvas = false;
  AppBar? appBar;
  Drawer? drawer;

  updateCanvas(Opacity canv, bool show, AppBar? bar, Drawer? drwr) {
    canvas = canv;
    showCanvas = show;
    appBar = bar;
    drawer = drwr;
    notifyListeners();
  }
}