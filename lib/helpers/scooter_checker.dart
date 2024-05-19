import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lemun/models/link_scooter.dart';
import 'package:lemun/providers/scooter_provider.dart';

class ScooterChecker {

  final ScooterProvider scooterProvider;
  var _latitude = '49.4404395';
  var _longitude = '11.0760811';

  // ScooterChecker();
  ScooterChecker(this.scooterProvider);

  updateLocation({required latitude, required longitude})  {
    _latitude = latitude;
    _longitude = longitude;
  }

  fetchLinkScooter() async {
    var client = http.Client();
    try {
      final gridResponse = await client.get(
          Uri.parse('https://vehicles.linkyour.city/reservation-api/local-vehicles/?format=json&latitude=$_latitude&longitude=$_longitude'));
      final gridParsed = (jsonDecode(gridResponse.body));
      // final String? forecastURL = gridParsed['properties']?['forecast'];
      // final link = LinkScooter.fromJson(gridParsed?['vehicles'][0]);

      final List<LinkScooter> links = (gridParsed['vehicles'] as List)
        .map((vehicle) => LinkScooter.fromJson(vehicle)).toList();

      print(gridParsed?['vehicles'][0]);

      // print(link.longitude);
      // print(link.latitude);
      scooterProvider.updateScooters(links);
      

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