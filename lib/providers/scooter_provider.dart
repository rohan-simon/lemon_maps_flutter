import 'package:flutter/material.dart';
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/link_scooter.dart';

class ScooterProvider extends ChangeNotifier {
  List<LinkScooter>? links;
  List<Lime>? limes;
  bool hasUpdated = false;

  updateScooters(List<LinkScooter> updatedLink, List<Lime> updatedLime) {
    links = updatedLink;
    limes = updatedLime;
    hasUpdated = true;
    notifyListeners();
  }
}