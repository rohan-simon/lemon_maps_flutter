import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/link_scooter.dart';
import 'package:lemun/providers/scooter_provider.dart';

class ScooterChecker {

  final ScooterProvider scooterProvider;
  var _latitude = 49.4404395;
  var _longitude = 11.0760811;
  var _city = 'seattle';

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

      var limeResponse = await client.get(
        Uri.parse('https://data.lime.bike/api/partners/v1/gbfs/$_city/free_bike_status')
      );
      var limeParsed = (jsonDecode(limeResponse.body));

      // Convert jsons to dart objects
      final List<LinkScooter> links = (linkParsed['vehicles'] as List)
        .map((vehicle) => LinkScooter.fromJson(vehicle)).toList();

      final List<Lime> limes = (limeParsed['data']?['bikes'] as List)
        .map((vehicle) => Lime.fromJson(vehicle)).toList();

      // add more scooters from lime?
      // limeResponse = await client.get(
      //   Uri.parse('https://data.lime.bike/api/partners/v1/gbfs/san_francisco/free_bike_status')
      // );
      // limeParsed = (jsonDecode(limeResponse.body));
      // limes.addAll(((limeParsed['data']?['bikes'] as List)
      //   .map((vehicle) => Lime.fromJson(vehicle)).toList()));

      // Update scooter provider
      scooterProvider.updateScooters(links, limes);
      

    } catch (e) {
      // TODO(optional): Find a way to have the UI let the user know that we haven't been able to update data successfully
      print(e);
    } finally {
      client.close();
    }
  }

  // WeatherCondition _shortForecastToCondition(String shortForecast) {
  //   final lowercased = shortForecast.toLowerCase();
  //   if (lowercased.startsWith('rain')) return WeatherCondition.rainy;
  //   if (lowercased.startsWith('sun') || lowercased.startsWith('partly'))
  //     return WeatherCondition.sunny;
  //   return WeatherCondition.gloomy;
  // }
}