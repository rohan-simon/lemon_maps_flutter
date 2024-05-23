import 'package:flutter/material.dart';
import 'package:lemun/helpers/scooter_checker.dart';
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
  HomePage({super.key});
  bool showCanvas = false;

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

        // limes = scooterProvider.limes ?? [];

        return Scaffold(
          appBar: AppBar(
          title: const Text('Drawing App'),
          actions: <Widget>[
            Semantics(
              button: true,
              label: 'Clear',
              hint: 'clears the canvas',
              child: ElevatedButton(
                onPressed: () => _clear(context), 
                child: const Icon(Icons.clear)
              ),
            ),
            Semantics(
              button: true,
              label: 'Undo',
              hint: 'Undoes the last stroke',
              child: ElevatedButton(
                onPressed: () => _undo(context), 
                child: const Icon(Icons.undo)
              ),
            ),
            Semantics(
              button: true,
              label: 'Redo',
              hint: 'Redoes the last stroke',
              child: ElevatedButton(
                onPressed: () => _redo(context), 
                child: const Icon(Icons.redo)
              ),
            ),
          ]
        ),
        drawer: Drawer(
          child: Palette(context),
        ),
          body: Center(
          child: Stack(
            children: [
          
              MapView(vehicles: limes),
              opacityProvider.canvas

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showHideCanvas(context),
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
    sc.fetchLinkScooter();
  }


    _clear(BuildContext context) {
    final nonListen = Provider.of<DrawingProvider>(context, listen: false);
    nonListen.clear();
  }

  _undo(BuildContext context) {
    final nonListen = Provider.of<DrawingProvider>(context, listen: false);
    nonListen.undo();
  }

  _redo(BuildContext context) {
    final nonListen = Provider.of<DrawingProvider>(context, listen: false);
    nonListen.redo();
  }
  
  _showHideCanvas(BuildContext context) {
    final nonListen = Provider.of<OpacityProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Opacity canvas;

    if (nonListen.showCanvas) {
      canvas = const Opacity(opacity: 0.0);
    } else {
      canvas = Opacity(
        opacity: 0.5,
        child: DrawArea(width: width, height: height)
      );
    }

    nonListen.updateCanvas(canvas, !nonListen.showCanvas);
    
  }
}