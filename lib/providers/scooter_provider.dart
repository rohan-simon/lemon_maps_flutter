import 'package:flutter/material.dart';
import 'package:lemun/models/link_scooter.dart';

class ScooterProvider extends ChangeNotifier {
  LinkScooter? link;
  bool hasUpdated = false;

  updateScooters(LinkScooter updatedLink) {
    link = updatedLink;
    hasUpdated = true;
    notifyListeners();
  }
}