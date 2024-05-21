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

        List<Text> coords = [Text('no coords yet')];

        if (scooterProvider.limes != null) {
          coords = scooterProvider.links!.map((link) => Text('latitude: ${link.latitude}, longitude: ${link.longitude}')).toList();
        }

        return Scaffold(
          body: Column(
            children: coords
          )
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