import 'package:flutter/material.dart';
import 'package:lemun/models/city.dart';
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/link_scooter.dart';
import 'package:lemun/models/vehicle.dart';

class ScooterProvider extends ChangeNotifier {
  List<LinkScooter>? links;
  List<Vehicle>? limes;
  bool hasUpdated = false;
  Cities _city = Cities.seattle;

  Cities get city => _city;
  set city(Cities city) {
    _city = city;
    notifyListeners();
  }

  updateScooters(List<LinkScooter> updatedLink, List<Lime> updatedLime) {
    links = updatedLink;
    limes = updatedLime;
    hasUpdated = true;
    notifyListeners();
  }

  updateLinks(List<LinkScooter> updatedLink) {
    links = updatedLink;
    hasUpdated = true;
    notifyListeners();
  }

  updateLimes(List<Lime> updatedLime) {
    limes = updatedLime;
    hasUpdated = true;
    notifyListeners();
  }
}