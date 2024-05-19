import 'package:flutter/material.dart';
import 'package:lemun/helpers/scooter_checker.dart';
import 'package:provider/provider.dart';
import 'package:lemun/providers/scooter_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ScooterProvider>(
      builder: (context, scooterProvider, child) {

        if (!scooterProvider.hasUpdated) {
          return Scaffold(
            body: Text('no coords yet')
          );
        }

        final lat = scooterProvider.link?.latitude ?? 0;
        final long = scooterProvider.link?.longitude ?? 0;

        return Scaffold(
          body: Text('latitude: $lat, longitude: $long')
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();

    final singleUseScooterProvider = Provider.of<ScooterProvider>(context, listen: false);
    final ScooterChecker sc = ScooterChecker(singleUseScooterProvider);
    sc.fetchLinkScooter();
  }
}