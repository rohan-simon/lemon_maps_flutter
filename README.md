# lemun

A new Flutter project.

## Resources used:

https://stackoverflow.com/questions/65458903/socketexception-connection-failed-os-error-operation-not-permitted-errno-1


## Build steps:
- Clone the repository using 'git clone git@gitlab.cs.washington.edu:cse340-24spring-students/final_project-brian127-dgao2-rshanth-jmarc23.git'
- Cd into the repository
- Run 'flutter pub get'
- Run the project using 'flutter run' or whatever works
- You will have to enable location permissions
- Once the app is ready, you can pan, zoom around the map, click on bikes, scooters, and bus stops to gain information about them, and use the legend to enable/disable vehicle types and move to your location

## Project structure:

### lib/assets/

- bus_stops.csv
- lemun_compass.png: image for the compass

### lib/helpers/

- scooter_checker.dart: Helper to update the list of scooters and bikes near the user

### lib/models/

- bus_stop_db.dart: a database of the bus stops, represented as a list of bus stops, created from the csv in the assets
- bus_stop.dart: represents a single bus stop, with its name and position 
- city.dart: enum with all the citiees in the Lime API
- drawing.dart: object to hold the draw actions of the user
- lime.dart: object to hold the data of Lime scooters and bikes
- link_scooter.dart: object to hold the data of Link scooters
- tools.dart: enum to determine what tool is being used on the canvas
- vehicle_types.dart: enum to determine what type of vehicle is being used (bus, scooter, bike)
- vehicle.dart: contains abstract class Vehicle to wrap around all vehicle types, has basic information of type, longitude, latitude

#### draw_actions/

- draw_actions.dart: Superclass to all draw actions

##### actions/

- clear_action.dart: Used to indicate the canvas was cleared
- null_action.dart: Used to indicate no stroke is being registered
- stroke_action.dart: Used to indicate user is drawing on the canvas

### lib/providers/

- drawing_provider.dart: Used to handle state of the drawing
- opacity_provider.dart: Used to handle state of the appbar
- position_provider.dart: Used to handle state of the user's position
- scooter_provider.dart: Used to handle state of the nearby scooters and bikes

### lib/views/

- city_selector.dart: Builds the drawer for selecting what city you are in
- compass_view.dart: contains CompassView class which requires a vehicle and displays a compass pointing from your current position to that vehicle. Also provides additional information about the vehicle such as availability and distance. 
- draw_area.dart: The canvas the user will see (although it is invisible)
- drawing_painter.dart: Displays the strokes the user took
- home_page.dart: Contains references to all the other views and logic for switching between them
- map_view.dart: contains MapView class, main view of the app displaying flutter_map and custom legend/filter
Clicking a marker on the map brings you to compass_view for that marker
- palette.dart: Builds the drawer for selecting colors for drawing

### lib/main.dart

- Builds the bus db and creates providers for all the data models, calling home_page and starting the app