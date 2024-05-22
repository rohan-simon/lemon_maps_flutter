import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lemun/models/bus_stop_db.dart';
import 'package:lemun/models/lime.dart';
import 'package:lemun/models/vehicle_types.dart';
import 'package:lemun/providers/position_provider.dart';
import 'package:lemun/providers/scooter_provider.dart';
import 'package:lemun/views/compass_view.dart';
import 'package:lemun/views/home_page.dart';
import 'package:lemun/views/map_view.dart';
import 'package:provider/provider.dart';

Future<BusStopDB> loadBusStopDB(String dataPath) async {


  return BusStopDB.initializeFromCSV(await rootBundle.loadString(dataPath));

} 
void main() {
  const busDataPath = 'lib/assets/bus_stops.csv';
  WidgetsFlutterBinding.ensureInitialized();
  loadBusStopDB(busDataPath).then((value) => runApp(const LemunApp()));
}

class LemunApp extends StatelessWidget {
  const LemunApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    // TODO: delete before final! Temporary test vehicle for debugging compass_view.
    Lime testVehicle1 = Lime(id: '2', latitude: 49.2827, longitude: -123.1207, isDisabled: false, isReserved: false, vehicleType: VehicleType.bike);
    Lime testVehicle2 = Lime(id: '3', latitude: 47.1257, longitude: -122.2930, isDisabled: false, isReserved: false, vehicleType: VehicleType.bike); 
    Lime testVehicle3 = Lime(id: '4', latitude: 47.6101, longitude: -122.2015, isDisabled: false, isReserved: false, vehicleType: VehicleType.bike);
    Lime testVehicle4 = Lime(id: '5', latitude: 47.5650, longitude: -122.6270, isDisabled: false, isReserved: false, vehicleType: VehicleType.bike); 
    List<Lime> testList = [testVehicle1, testVehicle2, testVehicle3, testVehicle4]; 

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ScooterProvider>(create: (context) => ScooterProvider()),
        ChangeNotifierProvider<PositionProvider>(create: (context) => PositionProvider()),
      ],
      child: MaterialApp(
        home: MapView(vehicles: testList) // TODO: delete before final! Temporary call of compass_view for debugging.
      )
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Lemun',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       ScooterChecker checker = ScooterChecker();
//       checker.fetchLinkScooter();
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(

//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,

//         title: Text(widget.title),
//       ),
//       body: Center(

//         child: Column(

//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
