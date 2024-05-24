import 'package:flutter/material.dart';
import 'package:lemun/helpers/scooter_checker.dart';
import 'package:lemun/models/bus_stop.dart';
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/vehicle.dart';
import 'package:lemun/providers/drawing_provider.dart';
import 'package:lemun/providers/opacity_provider.dart';
import 'package:lemun/views/draw_area.dart';
import 'package:lemun/views/palette.dart';
import 'package:provider/provider.dart';
import 'package:lemun/providers/scooter_provider.dart';
import 'package:lemun/views/map_view.dart';


class HomePage extends StatefulWidget {

  HomePage({super.key, required this.busStops});
  bool showCanvas = false;
  final List<BusStop> busStops;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Consumer2<ScooterProvider, OpacityProvider>(
      builder: (context, scooterProvider, opacityProvider, child) {

        List<Text> coords = [Text('no coords yet')];

        List<Vehicle> limes = [];
        if (scooterProvider.limes != null) {
          coords = scooterProvider.links!.map((link) => Text('latitude: ${link.latitude}, longitude: ${link.longitude}')).toList();
          limes = scooterProvider.limes!;
        }

        List<Vehicle> allVehicles = [];
        for (Vehicle busStop in widget.busStops) { 
          allVehicles.add(busStop);
        }

        for (Vehicle lime in limes) {
          allVehicles.add(lime);
        }

        


        // limes = scooterProvider.limes ?? [];

        return Scaffold(
          appBar: opacityProvider.appBar,
          drawer: opacityProvider.drawer,
          body: Center(
          child: Stack(
            children: [
              MapView(vehicles: allVehicles),
              opacityProvider.canvas
            ],
          ),
        ),
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();

    final singleUseScooterProvider = Provider.of<ScooterProvider>(context, listen: false);
    final ScooterChecker sc = ScooterChecker(singleUseScooterProvider);
    final singleUseOpacityProvider = Provider.of<OpacityProvider>(context, listen: false);
    singleUseOpacityProvider.appBar = AppBar(
      title: const Text('LemÚn'),
      actions: <Widget>[
        Semantics(
          button: true,
          label: 'Canvas',
          hint: 'allows drawing on the map',
          child: ElevatedButton(
            onPressed: () => _showHideCanvas(context),
            child: const Icon(Icons.edit)
          )
        )
      ]
    );
    sc.fetchLinkScooter();
  }


  _clear(BuildContext context) {
    final nonListen = Provider.of<DrawingProvider>(context, listen: false);
    nonListen.clear();
  }

  
  _showHideCanvas(BuildContext context) {
    final nonListen = Provider.of<OpacityProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Opacity canvas;
    AppBar? appBar;
    Drawer? drawer;

    if (nonListen.showCanvas) {
      canvas = const Opacity(opacity: 0.0);
      appBar = AppBar(
        title: const Text('LemÚn'),
        actions: <Widget>[
          Semantics(
            button: true,
            label: 'Canvas',
            hint: 'allows drawing on the map',
            child: SizedBox(
              width: 50,
              child: ElevatedButton(
                onPressed: () => _showHideCanvas(context),
                child: const Icon(Icons.edit)
              ),
            )
          )
        ]
      );
      drawer = null;
    } else {
      canvas = Opacity(
        opacity: 0.99,
        child: DrawArea(width: width, height: height)
      );
      appBar = AppBar(
          title: const Text('Draw your path'),
          actions: <Widget>[
            Semantics(
              button: true,
              label: 'Clear',
              hint: 'clears the canvas',
              child: SizedBox(
                width: 50,
                child: ElevatedButton(
                  onPressed: () => _clear(context), 
                  child: const Icon(Icons.clear)
                ),
              ),
            ),
            Semantics(
              button: true,
              label: 'Canvas',
              hint: 'allows drawing on the map',
              child: SizedBox(
                width: 50,
                child: ElevatedButton(
                  onPressed: () => _showHideCanvas(context),
                  child: const Icon(Icons.edit)
                ),
              )
            ),
          ]
        );
        drawer = Drawer(
          child: Palette(context),
        );
    }

    nonListen.updateCanvas(canvas, !nonListen.showCanvas, appBar, drawer);
    
  }
}