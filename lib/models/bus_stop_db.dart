import 'package:lemun/models/bus_stop.dart';
import 'package:csv/csv.dart';

class BusStopDB {
  final List<BusStop> _busStops;

  List<BusStop> get all{
    return List<BusStop>.from(_busStops, growable: false);
  }

  // BusStopDB.initializeFromCSV(String csvString, this._busStops) {
  //   print('Entered constructor successfully');
  //   //print(csvString);
  //   List<List<dynamic>> listOfStops = const CsvToListConverter().convert(csvString);
    
  //   List<BusStop> resList = (listOfStops).map( 
  //                       (element) {
  //                         return BusStop(name: element[2], latitude: element[3], longitude: element[4]);
  //                       }).toList();

  //   _busStops = resList;
    
  // }

  BusStopDB.initializeFromCSV(String csvString) : _busStops = _decodeBusStopList(csvString);


  static List<BusStop> _decodeBusStopList(String csvString) {

    List<BusStop> busStops = [];
    var listOfRows = csvString.split('\n');


    for (var row in listOfRows) {

      

      List elemList = row.split(',');

      if (elemList.length > 1) {

        busStops.add(BusStop(name: elemList[2], latitude: double.parse(elemList[4]), longitude: double.parse(elemList[5])));

      }

      print('$elemList, size: ${elemList.length}');

      
    }
    
    return [];


    //print(csvString);

    //List<List<dynamic>> listOfStops = const CsvToListConverter().convert(csvString);

    // print('List of Stops');
    // //print(listOfStops);
    // print(listOfStops[0]);
    
    // final List<BusStop> resList = (listOfStops as List).map( 
    //                     (element) {
    //                       return BusStop(name: element[2], latitude: element[4], longitude: element[5]);
    //                     }).toList();

    // print('Res List');
    // print(resList);

    // return resList;

  }
  

}