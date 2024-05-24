
import 'package:flutter/material.dart';
import 'package:lemun/models/tools.dart';
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
          // tool button part of the drawer
          // _buildToolButton(name: 'Line', icon: Icons.timeline_sharp, tool: Tools.line, provider: drawingProvider),
          // _buildToolButton(name: 'Stroke', icon: Icons.brush, tool: Tools.stroke, provider: drawingProvider),
          // _buildToolButton(name: 'Oval', icon: Icons.circle, tool: Tools.oval, provider: drawingProvider),

          // const Divider(),
          // color button part of the drawer
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

  /// Builds the tool button that changes what tool is used
  /// paramaters:
  ///  - name: Name of the tool
  ///  - icon: Icon to display
  ///  - tool: Tool to switch to
  ///  - provider: Drawing Provider to manage state
  Widget _buildToolButton({required String name, required IconData icon, required Tools tool, required DrawingProvider provider}) {
    bool selected = provider.toolSelected == tool;

    return Semantics(
      button: true,
      selected: selected,
      label: name,
      hint: 'Press to change to $name tool',
      child: InkWell(
        onTap: () {
          if (selected) {
            provider.toolSelected = Tools.none;
          } else {
            provider.toolSelected = tool;
          }
        },
        child: Row(
          children: [
            Stack(
              children: [
                const Icon(Icons.circle, color: Colors.black, size: 28),
                Icon(icon, color: provider.colorSelected,),
                ]
              ),
            Text(name),
            if (selected) const Icon(Icons.check, color: Colors.green),
          ],
        )
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
