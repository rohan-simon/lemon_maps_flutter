import 'package:flutter/material.dart';
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/link_scooter.dart';
import 'package:lemun/models/vehicle.dart';

class ScooterProvider extends ChangeNotifier {
  List<LinkScooter>? links;
  List<Vehicle>? limes;
  bool hasUpdated = false;

  updateScooters(List<LinkScooter> updatedLink, List<Lime> updatedLime) {
    links = updatedLink;
    limes = updatedLime;
    hasUpdated = true;
    notifyListeners();
  }
}