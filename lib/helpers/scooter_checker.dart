import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lemun/providers/scooter_provider.dart';

class ScooterChecker {

  final ScooterProvider scooterProvider;
  var _latitude = '';
  var _longitude = '';

  ScooterChecker(this.scooterProvider);

  updateLocation({required latitude, required longitude})  {
    _latitude = latitude;
    _longitude = longitude;
  }

  fetchAndUpdateNearbyScooters() async {
    var client = http.Client();
    try {
      final gridResponse = await client.get(
          Uri.parse('https://vehicles.linkyour.city/reservation-api/local-vehicles/?latitude=$_latitude&longitude=$_longitude'));
      final gridParsed = (jsonDecode(gridResponse.body));
      final String? forecastURL = gridParsed['properties']?['forecast'];
      if (forecastURL == null) {
        // do nothing
      } else {
        final weatherResponse = await client.get(Uri.parse(forecastURL));
        final weatherParsed = jsonDecode(weatherResponse.body);
        final currentPeriod = weatherParsed['properties']?['periods']?[0];
        if (currentPeriod != null) {
          final temperature = currentPeriod['temperature'];
          final shortForecast = currentPeriod['shortForecast'];
          print(
              'Got the weather at ${DateTime.now()}. $temperature F and $shortForecast');
          if (temperature != null && shortForecast != null) {
            // final condition = _shortForecastToCondition(shortForecast);
            // weatherProvider.updateWeather(temperature, condition);
          }
        }
      }
    } catch (_) {
      // TODO(optional): Find a way to have the UI let the user know that we haven't been able to update data successfully
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