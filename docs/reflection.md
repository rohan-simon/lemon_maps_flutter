# Reflection


## Applied course topics

**Properties of People: Vision**

Our color contrast between text and icons to background is high enough. Our icons are distinct for the different vehicle types and have different colors to distinguish. We put black circles behind the vehicle icons to make them stand out more on the map. We limit our use of blue. The UI is fairly simple being just a map and 4 clickable icons initially, and allows for more complex functions such as the canvas if users want to have that functionality. 

**Properties of People: Motor Control**

Similar purpose buttons are grouped together and the button sizes are large enough and spread out enough. All the legend buttons are grouped together at the bottom in a horizontal row, but there is padding between each and each button is given a generous size. 

**Stateless & stateful widgets**

We use stateful widgets throughout the app because our map and compass constantly changed based on API queries and user location and rotation. The palette and city selector are stateless because they have a set number of options that do not change. 

**Accessing sensors**

Requires GPS location and compass bearing of device for the map and compass views to calculate distance and direction towards vehicles. 

**Querying web services**

Connects to two APIs for two different companies of scooters/bikes, converts the data from JSONs into usable dart objects, and uses those objects for the rest of the app. 

**Drawing with canvas**

Functionality for users to draw on the map view using Canvas to plan out paths they want to take. They can change the color of their path and clear the path to redraw one. 


## Changes from original concept

**Describe what changed from your original concept to your final implementation? Why did you make those changes from your original design vision?**

We changed ...

**Discuss how doing this project challenged and/or deepened your understanding of these topics.**

This project [...]

**Describe two areas of future work for your app, including how you could increase the accessibility and usability of this app**

One way we could improve the app is improving the Canvas drawing path functionality. Currently a user would click the edit button to start drawing, but in this draw view would not be able to actuate with the map (pan or zoom). The path also disappears when exiting the draw view. In the future we could integrate the canvas with the map more so that you can draw on the map while being able to move the map, and have the path persist when going back to the map view. 
Another way we could improve the performance of the app, especially in vehicle dense areas is to cluster nearby vehicles together when zooming out. This would reduce the amount of markers being displayed on the map at once which is a source of lag and performance issues currently. This would make the app more usable on more devices, and in crowded metropolitan areas such as Seattle downtown. 


## Citations

Comprehensive list of resources used:
- https://stackoverflow.com/questions/51182803/shrink-container-to-smaller-child-rather-than-expanding-to-fill-parent
- https://stackoverflow.com/questions/75434794/flutter-how-to-make-container-height-wrap-around-its-content
- https://api.flutter.dev/flutter/widgets/Wrap-class.html
- https://stackoverflow.com/questions/66285602/how-to-wrap-gesturedetector-with-another-gesturedetector-and-get-events-everywhe
- https://api.flutter.dev/flutter/material/PopupMenuButton-class.html
- https://api.flutter.dev/flutter/rendering/RelativeRect/RelativeRect.fromDirectional.html
- https://api.flutter.dev/flutter/dart-ui/TextDirection.html
- https://stackoverflow.com/questions/61756271/how-to-set-flutter-showmenu-starting-point
- https://stackoverflow.com/questions/51644300/scrollable-flutter-popup-menu
- https://stackoverflow.com/questions/77357991/flutter-how-to-understand-the-relativerect-positioning-in-the-showmenu
- https://stackoverflow.com/questions/43349013/how-to-open-a-popupmenubutton
- https://api.flutter.dev/flutter/gestures/LongPressGestureRecognizer/onLongPress.html
- https://api.flutter.dev/flutter/rendering/RelativeRect-class.html
- https://stackoverflow.com/questions/56927576/how-to-change-background-color-of-popupmenuitem-in-flutter
- https://stackoverflow.com/questions/44909653/visual-studio-code-target-of-uri-doesnt-exist-packageflutter-material-dart?page=2&tab=Votes
- https://pub.dev/packages/flutter_compass/example
- https://github.com/hemanthrajv/flutter_compass/blob/master/example/lib/main.dart
- https://www.reddit.com/r/github/comments/syrxqt/i_cant_make_pubspeclock_to_be_ignored_by_changes/
- https://stackoverflow.com/questions/1274057/how-do-i-make-git-forget-about-a-file-that-was-tracked-but-is-now-in-gitignore/1274447#1274447
- https://stackoverflow.com/questions/69332079/best-practice-for-overriding-class-fields-in-dart
- https://stackoverflow.com/questions/78080244/flutter-version-3-19-2-requires-a-newer-version-of-the-kotlin-gradle-plugin-an
- https://stackoverflow.com/questions/70919127/your-project-requires-a-newer-version-of-the-kotlin-gradle-plugin-android-stud
- https://stackoverflow.com/questions/53682098/how-to-find-out-the-latest-version-of-kotlin-in-android-studio
- https://kotlinlang.org/docs/releases.html#release-details
- https://docs.gradle.org/current/userguide/upgrading_version_8.html
- https://stackoverflow.com/questions/67448034/module-was-compiled-with-an-incompatible-version-of-kotlin-the-binary-version/67470309#67470309
- https://stackoverflow.com/questions/24184579/how-to-properly-write-a-gradle-wrapper-properties-file
- https://github.com/JetBrains/kotlin/releases/tag/v1.7.10
- https://stackoverflow.com/questions/76495655/d-profileinstaller14242-installing-profile-for-com-example-instagram-clone
- https://pub.dev/documentation/provider/latest/provider/MultiProvider-class.html
- https://stackoverflow.com/questions/61052629/how-to-add-multiple-changenotifierprovider-in-same-type-in-flutter
- https://github.com/cfug/dio/issues/314
- https://github.com/flutter/flutter/issues/33427
- https://community.make.com/t/calculate-bearing-based-on-two-sets-of-geographic-coordinates/27501
- https://www.igismap.com/formula-to-find-bearing-or-heading-angle-between-two-points-latitude-longitude/
- https://stackoverflow.com/questions/11918654/bearing-using-two-sets-of-coordinates-latitude-and-longitude-in-c
- https://stackoverflow.com/questions/63684684/convert-radian-to-degree-in-flutter-expression
- https://www.reddit.com/r/geography/comments/pa9x6z/why_is_the_north_pole_at_90n_135w/
- https://stackoverflow.com/questions/52033603/assetimage-is-not-displaying-image-in-flutter-app
- https://stackoverflow.com/questions/47114639/yellow-lines-under-text-widgets-in-flutter
- https://t4.ftcdn.net/jpg/04/02/14/33/360_F_402143359_kziuHGJYJrQVFjCfPqBzpPJzZDS7ugbV.jpg
- https://medium.com/@shahidbangashsi94/flutter-map-6-1-0-grey-screen-issue-f3b244f48f64
- https://stackoverflow.com/questions/70755616/lateinitializationerror-field-mapcontroller-has-not-been-initialized
- https://stackoverflow.com/questions/71233179/how-can-i-call-my-provider-model-into-initstate-method
- https://pub.dev/documentation/map/latest/map/MapController-class.html
- https://pub.dev/packages/flutter_map/example
- https://docs.fleaflet.dev/usage/programmatic-control/controller
- https://github.com/flutter/flutter/issues/28493
- https://pub.dev/packages/text_scroll
- https://pub.dev/packages/flutter_map_marker_cluster
- https://stackoverflow.com/questions/51508257/how-to-change-the-appbar-back-button-color
- https://www.geeksforgeeks.org/flutter-elevation-in-appbar/
- https://github.com/fleaflet/flutter_map/issues/87
- https://github.com/fleaflet/flutter_map/issues/824
- https://stackoverflow.com/questions/55187324/how-to-get-bounds-of-visible-map-with-flutter-google-maps-plugin
- https://stackoverflow.com/questions/49418332/flutter-how-to-prevent-device-orientation-changes-and-force-portrait
- https://medium.com/flutter-community/controlling-screen-orientation-in-flutter-apps-on-a-per-screen-basis-d637702f9368
- https://github.com/flutter/flutter/issues/119473
- https://docs.flutter.dev/cookbook/lists/grid-lists
- https://stackoverflow.com/questions/49943272/flutter-gridview-in-column-whats-solution
- https://stackoverflow.com/questions/51930754/flutter-wrapping-text
- https://stackoverflow.com/questions/71531281/flutter-drawerheader-how-to-get-rid-of-divider
- https://stackoverflow.com/questions/71005867/flutter-how-do-i-disable-scrolling-for-a-gridview-widget-but-have-scrolling-en#:~:text=You%20can%20provide%20physics%3A%20NeverScrollableScrollPhysics,GridView%20to%20disable%20scroll%20effect.
- https://stackoverflow.com/questions/57332430/adding-width-to-drawer-in-flutter


## General CSE 340 reflection

**What do you feel was the most valuable thing you learned in CSE 340 that will help you beyond this class, and why?**

The most valuable things we learned in CSE 340 are the following: 

- Working in a group computer science project and the struggles of version control especially with a non-existent gitignore. This will be helpful beyond this class for any other projects that use git or group projects in general.
- Learned about Flutter and Dart which seem like valuable tools for creating UIs and apps in the future. 
- Accessibility is important when developing applications, especially since a large subset of the population has some type of needed accommodation of deficiency that makes it more difficult to use screens. This is valuable beyond this class and is a good guideline for developing anything.
- Data persistence and how to handle state. Secure storage is an important tool for not just this course, but being able to efficiently and effectively store some small pieces of important encrypted data. 

**If you could go back and give yourself 2-3 pieces of advice at the beginning of the class, what would you say and why? (Alternatively: what 2-3 pieces of advice would you give to future students who take CSE 340 and why)?**

Do not rely on resubmissions on projects to turn things in late because it may cause you to fall behind. You will want to take advantage of your initial feedback and use the resubmission forms to improve on that feedback. Try to understand providers and stateless/stateful widgets because they will be vital for most projects. Start projects early to get an idea of what the overall workflow will look like and mitigate the unforeseen issues (e.g. hardware or permissions issues). Go to office hours and post on Ed if you do run into issues so that your classmates can see and chime in if they're facing similar issues.
