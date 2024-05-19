import 'package:flutter/material.dart';
import 'package:lemun/models/link_scooter.dart';

class ScooterProvider extends ChangeNotifier {
  List<LinkScooter>? links;
  bool hasUpdated = false;

  updateScooters(List<LinkScooter> updatedLink) {
    links = updatedLink;
    hasUpdated = true;
    notifyListeners();
  }
}