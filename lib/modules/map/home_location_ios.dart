// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:location/location.dart';

import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:location/location.dart';


class FRoute extends StatefulWidget {
  const FRoute({Key? key}) : super(key: key);

  @override
  State<FRoute> createState() => _FRouteState();
}

class _FRouteState extends State<FRoute> {



  List data = [];
  var uid;
  var student_name, school_name, grade_name, avatar;

  bool isChecked = false;
  bool isChecked2 = false;


  // Future<LocationData?> _currentLocation() async {
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   Location location = new Location();
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return null;
  //     }
  //   }
  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return null;
  //     }
  //   }
  //   return await location.getLocation();
  // }
  void _currentLocation1()async
  {var serviceEnabled;

      PermissionStatus permissionGranted;
      Location location = new Location();
      serviceEnabled = await location.serviceEnabled();
  // if(await Permission.location.serviceStatus.isEnabled)
  // {
  //
  //   print('hhhhhhh');
  // }
  // else
  // {Location location = new Location();
  // serviceEnabled= Permission.location.status;
  // Map<Permission,PermissionStatus> st=await [
  //   Permission.location;
  // ].request();
  // print(serviceEnabled);
  // if(serviceEnabled.isGranted) {
  //   print('hhhhh1111hh');
  // }
  // else if(serviceEnabled.isDenied)
  //   {
  //     print('object');
  //   }
  // }
  }
  @override
  void initState() {
    // TODO: implement initState
    _currentLocation1();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // appBar: AppBar(
        //   title: const Center(child: Text("Change Location")),
        //   actions: <Widget>[
        //     IconButton(
        //       icon: const Icon(Icons.notifications_none),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const NotfiRoute()),
        //         );
        //       },
        //     ),
        //     IconButton(
        //       icon: const Icon(Icons.settings),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => const SettingRoute()),
        //         );
        //       },
        //     ),
        //   ],
        // ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 350,
                child: SfMaps(layers: [MapTileLayer(urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png')],
                  //             layers: [
                  //               MapTileLayer(
                  //                 initialFocalLatLng: MapLatLng(
                  //                     currentLocation.latitude!, currentLocation.longitude!),
                  //                 initialZoomLevel: 5,
                  //                 initialMarkersCount: 1,
                  //                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //                 markerBuilder: (BuildContext context, int index) {
                  //                   return MapMarker(
                  //                     latitude: currentLocation.latitude!,
                  //                     longitude: currentLocation.longitude!,
                  //                     child: Icon(
                  //                       Icons.location_on,
                  //                       color: Colors.red[800],
                  //                     ),
                  //                     size: Size(20, 20),
                  //                   );,
                  // child: FutureBuilder<LocationData?>(

                  // future: _currentLocation(),
                  //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
                  //         if (snapchat.hasData) {
                  //           final LocationData currentLocation = snapchat.data;
                  //           return SfMaps(
                  //             layers: [
                  //               MapTileLayer(
                  //                 initialFocalLatLng: MapLatLng(
                  //                     currentLocation.latitude!, currentLocation.longitude!),
                  //                 initialZoomLevel: 5,
                  //                 initialMarkersCount: 1,
                  //                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  //                 markerBuilder: (BuildContext context, int index) {
                  //                   return MapMarker(
                  //                     latitude: currentLocation.latitude!,
                  //                     longitude: currentLocation.longitude!,
                  //                     child: Icon(
                  //                       Icons.location_on,
                  //                       color: Colors.red[800],
                  //                     ),
                  //                     size: Size(20, 20),
                  //                   );
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         }
                  //         return Center(child: CircularProgressIndicator());
                  //       },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 290,
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 95,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "The map shows your location now, to change teh location olease hold the pin on the map and drag it to the new desired location then drop it",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 240.0, 0.0),
                          child: Text(
                            "This location is for :",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                            const Text(
                              "Pick-Up Round",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked2,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked2 = value!;
                                });
                              },
                            ),
                            const Text(
                              "Drop-Off Round",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(70.0, 10.0, 0.0, 0.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(110, 40),
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const TRoute()),
                            // ); //write your onPressed function here
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(110, 40),
                            primary: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                50,
                              ),
                            ),
                          ),
                          onPressed: () {
                            //write your onPressed function here
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
