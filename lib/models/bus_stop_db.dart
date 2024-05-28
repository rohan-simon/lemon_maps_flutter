import 'package:lemun/models/bus_stop.dart';

class BusStopDB {
  final List<BusStop> _busStops;

  List<BusStop> get all{
    return List<BusStop>.from(_busStops, growable: false);
  }


  BusStopDB.initializeFromCSV(String csvString) : _busStops = _decodeBusStopList(csvString);


  static List<BusStop> _decodeBusStopList(String csvString) {

    List<BusStop> busStops = [];
    var listOfRows = csvString.split('\n');


    for (var row in listOfRows) {

      

      List elemList = row.split(',');

      if (elemList.length > 1) {

        busStops.add(BusStop(name: elemList[2], latitude: double.parse(elemList[4]), longitude: double.parse(elemList[5])));

      }

      //print('$elemList, size: ${elemList.length}');

      
    }
    
    return busStops;

  }
  

}