import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lemun/models/city.dart';
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/link_scooter.dart';
import 'package:lemun/providers/scooter_provider.dart';

class ScooterChecker {

  final ScooterProvider scooterProvider;
  var _latitude = 49.4404395;
  var _longitude = 11.0760811;
  var _city = Cities.seattle;

  // ScooterChecker();
  ScooterChecker(this.scooterProvider);

  updateLocation({required latitude, required longitude})  {
    _latitude = latitude;
    _longitude = longitude;
  }

  fetchLinkScooter() async {

    var client = http.Client();
    try {
      var latitude = _latitude.toString();
      var longitude = _longitude.toString();

      // connect to APIs
      final linkResponse = await client.get(
        Uri.parse('https://vehicles.linkyour.city/reservation-api/local-vehicles/?format=json&latitude=$latitude&longitude=$longitude')
      );
      final linkParsed = (jsonDecode(linkResponse.body));

      // Convert jsons to dart objects
      final List<LinkScooter> links = (linkParsed['vehicles'] as List)
        .map((vehicle) => LinkScooter.fromJson(vehicle)).toList();

      // Update scooter provider
      scooterProvider.updateLinks(links);

    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
  }

  fetchLime() async {
    var client = http.Client();
    _city = scooterProvider.city;
    try {
      var limeResponse = await client.get(
        Uri.parse('https://data.lime.bike/api/partners/v1/gbfs/${_city.name}/free_bike_status')
      );
      var limeParsed = (jsonDecode(limeResponse.body));

      final List<Lime> limes = (limeParsed['data']?['bikes'] as List)
          .map((vehicle) => Lime.fromJson(vehicle)).toList();

      scooterProvider.updateLimes(limes);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
    
  }


}