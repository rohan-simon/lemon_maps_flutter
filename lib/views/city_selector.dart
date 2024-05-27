import 'package:flutter/material.dart';
import 'package:lemun/helpers/scooter_checker.dart';
import 'package:lemun/models/city.dart';
import 'package:lemun/providers/scooter_provider.dart';
import 'package:provider/provider.dart';

class CitySelector extends StatelessWidget {
  const CitySelector(BuildContext context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScooterProvider>(
      builder: (context, scooterProvider, unchangingChild) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          const DrawerHeader(
            child: Text('Choose a city'),
          ),

          // US
          _buildHeader('United States'),
          _buildCityButton('Cleveland', Cities.cleveland, scooterProvider),
          _buildCityButton('Detroit', Cities.detroit, scooterProvider),
          _buildCityButton('Grand Rapids', Cities.grand_rapids, scooterProvider),
          _buildCityButton('New York', Cities.new_york, scooterProvider),
          _buildCityButton('Norfolk', Cities.norfolk_va, scooterProvider),
          _buildCityButton('Washington D.C.', Cities.washington_dc, scooterProvider),
          _buildCityButton('Colorado Springs', Cities.colorado_springs, scooterProvider),
          _buildCityButton('Louisville', Cities.louisville, scooterProvider),
          _buildCityButton('Oakland', Cities.oakland, scooterProvider),
          _buildCityButton('San Francisco', Cities.san_francisco, scooterProvider),
          _buildCityButton('San Jose', Cities.san_jose, scooterProvider),
          _buildCityButton('Seattle', Cities.seattle, scooterProvider),
          _buildCityButton('Chicago', Cities.chicago, scooterProvider),

          const Divider(),

          // Germany
          _buildHeader('Germany'),
          _buildCityButton('Hamburg', Cities.hamburg, scooterProvider),
          _buildCityButton('Oberhausen', Cities.oberhausen, scooterProvider),
          _buildCityButton('Reutlingen', Cities.reutlingen, scooterProvider),
          _buildCityButton('Solingen', Cities.solingen, scooterProvider),
          const Divider(),

          // Switzerland
          _buildHeader('Switzerland'),
          _buildCityButton('Opfikon', Cities.opfikon, scooterProvider),
          _buildCityButton('Zug', Cities.zug, scooterProvider),
          const Divider(),

          // France
          _buildHeader('France'),
          _buildCityButton('Paris', Cities.paris, scooterProvider),
          _buildCityButton('Marseille', Cities.marseille, scooterProvider),
          const Divider(),

          // Canada
          _buildHeader('Canada'),
          _buildCityButton('Kelowna', Cities.kelowna, scooterProvider),
          _buildCityButton('Edmonton', Cities.edmonton, scooterProvider),
          const Divider(),

          // Israel
          _buildHeader('Israel'),
          _buildCityButton('Tel Aviv', Cities.tel_aviv, scooterProvider),
          const Divider(),
          
          // Norway
          _buildHeader('Norway'),
          _buildCityButton('Oslo', Cities.oslo, scooterProvider),
          const Divider(),

          // Italy
          _buildHeader('Italy'),
          _buildCityButton('Rome', Cities.rome, scooterProvider),
          _buildCityButton('Verona', Cities.verona, scooterProvider),
          const Divider(),

          // Belgium
          _buildHeader('Belgium'),
          _buildCityButton('Antwerp', Cities.antwerp, scooterProvider),
          _buildCityButton('Brussels', Cities.brussels, scooterProvider),

        ],
      ),
    );
  }

  /// Takes a country name and makes a heading out of it.
  /// paramaters:
  ///  - text: the country to build a header for
  Widget _buildHeader(String text) {
    return Semantics(
      button: false,
      label: 'country',
      hint: 'cities below belong to $text',
      child: Column(
        children: [
          Text(text),
          const Divider()
        ]
      ),
    );
  }

  /// Makes a button to select the city the user wants the Lime api to pull from
  /// parameters:
  ///  - name: city name
  ///  - city: city to select
  ///  - provider: Scooter Provider to handle state
  Widget _buildCityButton(String name, Cities city, ScooterProvider provider) {
    bool selected = provider.city == city;

    return Semantics(
      button: true,
      selected: selected,
      label: 'city',
      hint: 'Press to change city to $name',
      child: Row(
        children: [
          InkWell(
          onTap: () {
            // update state
            provider.city = city;
            ScooterChecker sc = ScooterChecker(provider);
            sc.fetchLime();
          },
          hoverColor: Colors.green,
          child: Row(
            children: [
              Text(name),
              if (selected) const Icon(
                Icons.check,
                color: Colors.green,
              )
            ],
          )
        ),]
      ),
    );
  }

}
