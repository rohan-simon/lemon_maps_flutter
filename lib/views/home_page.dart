import 'package:flutter/material.dart';
import 'package:lemun/helpers/scooter_checker.dart';
import 'package:lemun/providers/drawing_provider.dart';
import 'package:lemun/views/draw_area.dart';
import 'package:lemun/views/palette.dart';
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
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: const Stack(
              children: [
                Opacity(
                  opacity: 0.8,
                   child: CircleAvatar(
                        radius: 200,
                        backgroundImage: AssetImage('lib/assets/lemon_slice.jpg'),
                       ),
                 ),
                Opacity(
                  opacity: 0.5,
                  child: DrawArea(width: 400, height: 400)
                ),
                
                
              ],
            )
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
}