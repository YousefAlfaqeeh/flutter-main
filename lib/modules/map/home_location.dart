import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/notification/notification.dart';

import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/services/location_services.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'dart:ui'as ui;

import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class HomeLocation extends StatefulWidget {
  String std_id;
  // late String name;
  // late String grade;
  // late String school;
  // late String image;
  //
  // late String? school_lat;
  // late String? school_lng;
  // late String? distance;
  //
  // late List<Features>? listdetail12;

  HomeLocation(
      {
        // required this.name,
        // required this.grade,
        // required this.school,
        // required this.image,
        // this.listdetail12,
        // this.school_lat,
        // this.school_lng,
        // this.distance,
        required this.std_id});


  @override
  State<HomeLocation> createState() => _HomeLocationState();
}

class _HomeLocationState extends State<HomeLocation> {
  List data = [];
  var uid;
  var student_name, school_name, grade_name, avatar;

  bool isChecked = false;
  bool isChecked2 = false;
  dynamic lat, long;
  late Uint8List customIcon ;


// make sure to initialize before map loading
//   BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
//   'assets/images/car-icon.png')
//       .then((d) {
//   customIcon = d;
//   });


  Future<Uint8List> getBytesFromAsset({required String path,required int width})async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))!
        .buffer.asUint8List();
  }

  Set<Marker> marker = {};
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  LatLng currentLocation = _kGooglePlex.target;

  Future<void> location11() async {
    if(Platform.isAndroid)
    {
      Position? _myLocation = await LoctionService().currentLocationAnd();
      _animateCameraAnd(_myLocation!);
    }
    else
    {
      LocationData? _myLocation = await LoctionService().currentLocation();
      _animateCamera(_myLocation!);
    }
    LocationData? _myLocation = await LoctionService().currentLocation();
    // print("--------------");
    // print(_myLocation);
    _animateCamera(_myLocation!);
  }

  Future<void> _animateCamera(LocationData locationData) async {


    // Uint8List b= (await NetworkAssetBundle(Uri.parse('https://www.fluttercampus.com/img/car.png')).load('https://www.fluttercampus.com/img/car.png')).buffer.asUint8List();
    final GoogleMapController controller = await _controller.future;
    lat = locationData.latitude;
    long = locationData.longitude;
    marker.add( Marker(
        draggable: true,
        // icon: BitmapDescriptor.fromBytes(b),
        onDragEnd: (value) {
          lat=value.longitude;
          long=value.longitude;
        },

        markerId: MarkerId("1"),
        position: LatLng(locationData.latitude!, locationData.longitude!)));
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 14.4746,
    );
    lat=locationData.longitude;
    long=locationData.longitude;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  Future<void> _animateCameraAnd(Position locationData) async {


    // Uint8List b= (await NetworkAssetBundle(Uri.parse('https://www.fluttercampus.com/img/car.png')).load('https://www.fluttercampus.com/img/car.png')).buffer.asUint8List();
    final GoogleMapController controller = await _controller.future;
    lat = locationData.latitude;
    long = locationData.longitude;
    marker.add( Marker(
        draggable: true,
        // icon: BitmapDescriptor.fromBytes(b),
        onDragEnd: (value) {
          lat=value.longitude;
          long=value.longitude;
        },

        markerId: MarkerId("1"),
        position: LatLng(locationData.latitude!, locationData.longitude!)));
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 14.4746,
    );
    lat=locationData.longitude;
    long=locationData.longitude;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }


  Future<void> post_change_location(String type)
  async {


    var response=await DioHelper.postData(url:Perent_Notification , data:{
      'name':'changed_location',
      'location_type':type,
      'long':long,
      'lat':lat,
      'mobile':'',
      'student_id':widget.std_id.toString(),


    },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {


      showDialog(context: context, builder: (context) => AlertDialog( content: Container(
        child: Text('The Pick-up and Drop-off Locations have been changed successfully'),
      ),
        actions: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(40)),
              child: MaterialButton(
                child: const Text(
                  "OK",
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {

Navigator.pop(context);
Navigator.pop(context);

                },),
              ),
            ),

        ],),);


    },).catchError((onError){
      // print(onError);
      // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);

    });

  }
  void change_location()
  {
   if(isChecked==true&&isChecked2==true)
     {
     //  both
       post_change_location('both');
     }
   else if(isChecked==true&&isChecked2==false)
     {
     //  pick-up
       post_change_location('pick-up');
     }
   else if(isChecked==false&&isChecked2==true)
   {
     //  drop-off
     post_change_location('drop-off');
   }
   else
     {
       showDialog(context: context, builder: (context) => dialog(massage: 'pleas select round type', title: Image(image: AssetImage('images/img_error.png')) ),);

     }

  }
  @override
  void initState() {
    location11();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
              width: 30,
              height: 30,
              padding: EdgeInsetsDirectional.only(end: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(size: 20, Icons.keyboard_arrow_left)),
        ),
        title: Container(
            alignment: Alignment.center, child: Text("Change Location")),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Notification_sc(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              width: 30,
              height: 30,
              child: Stack(children: [
                Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                    )),
                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 5),
                  child: Container(
                    width: 10,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                  ),
                )
              ]),
            ),
          ),
          IconButton(
              padding: EdgeInsets.all(20),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Setting(),
                  )),
              icon: Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _kGooglePlex,
              markers: marker,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (position) {

                setState(() {
                  currentLocation = position.target;
                });
              },
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
                Expanded(
                  child: SizedBox(
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
                        Expanded(
                          child: Row(
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
                        ),
                        Expanded(
                          child: Row(
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
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(70.0, 10.0, 0.0, 0.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 40),
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              50,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          //write your onPressed function here
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
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(110, 40),
                          backgroundColor: Colors.blueAccent, // Updated from 'primary' to 'backgroundColor'
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          // Your onPressed function here
                          change_location();
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                      ,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
