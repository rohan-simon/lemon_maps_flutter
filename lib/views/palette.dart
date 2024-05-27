
import 'package:flutter/material.dart';
import 'package:lemun/providers/drawing_provider.dart';
import 'package:provider/provider.dart';

class Palette extends StatelessWidget {
  const Palette(BuildContext context, {super.key});

  
  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, unchangingChild) => ListView(
        scrollDirection: Axis.vertical,
        children: [
          const DrawerHeader(
            child: Text('Colors'),
          ),

          // colors
          _buildColorButton('Red', Colors.red, drawingProvider),
          _buildColorButton('Orange', Colors.orange, drawingProvider),
          _buildColorButton('Yellow', Colors.yellow, drawingProvider),
          _buildColorButton('Green', Colors.green, drawingProvider),
          _buildColorButton('Blue', Colors.blue, drawingProvider),
          _buildColorButton('Purple', Colors.purple, drawingProvider),
          _buildColorButton('White', Colors.white, drawingProvider),
          _buildColorButton('Black', Colors.black, drawingProvider),

        ],
      ),
    );
  }

  /// Builds a button to change the color
  /// paramaters:
  ///  - name: The name of the color
  ///  - color: The color to switch to
  ///  - provider: Drawing Provider to manage state
  Widget _buildColorButton(String name, Color color,  DrawingProvider provider) {
    bool selected = provider.colorSelected == color;

    var backgroundColor = switch(color) {
      Colors.black => Colors.grey,
      _ => Colors.black
    };

    return Semantics(
      button: true,
      selected: selected,
      label: 'name',
      hint: 'Press to change to $name',
      child: InkWell(
        onTap: () {
          // manage state
          provider.colorSelected = color;
        },
        hoverColor: color,
        child: Row(
          children: [
            Stack(
              children: [
                Icon(Icons.circle, color: backgroundColor, size: 28),
                Icon(
                  Icons.circle,
                  color: color,
               )
              ],
            ),
            Text(name),
            if (selected) const Icon(
              Icons.check,
              color: Colors.green,
            )
          ],
        )
      ),
    );
  }

}
