# Lemon Maps (Flutter Beta)

## Build steps:
- Clone this repository
- Cd into the repository
- Run 'flutter pub get'
- Run the project with 'flutter run'
- **You can also run the project by linking through Xcode if testing on an Apple device or simulator**
- Once the app is ready, you can pan, zoom around the map, click on bikes, scooters, and bus stops to gain information about them, and use the legend to enable/disable vehicle types and move to your location

## Project Gallery
<img width="1387" alt="Screenshot 2024-10-03 at 9 21 05 PM" src="https://github.com/user-attachments/assets/7f5e7c1f-1428-4b9e-bf30-3fc3ebe4045e">
<img width="1380" alt="Screenshot 2024-10-03 at 9 22 20 PM" src="https://github.com/user-attachments/assets/b5d3a5a6-25d0-4e7b-8dc6-85b2ccd9473e">


## Project Structure:

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

## Basic Data Design and Data Flow

Flutter provider used to periodically check with the scooter and bike APIs to make sure the vehicles nearby are up to date, which will update the Lists used to populate the map.
Provider used to manage the state of the entire app, between being able to scroll through the map and being able to draw a path. This was done by toggling on and off a transparent version of the drawing app that we made, and changing what the drawer would contain (between colors and cities).

