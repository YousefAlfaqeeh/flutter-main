import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/services/location_services.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'dart:ui' as ui;
import 'dart:math';

import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class PickUp_Request extends StatefulWidget {
  PickUp_Request();

  @override
  State<PickUp_Request> createState() => _PickUp_RequestState();
}

class _PickUp_RequestState extends State<PickUp_Request> {
  String? stuid, school_id;
  Timer? t;
  List<Map> student = [];
  bool isChecked = false;

  dynamic lat, long;
  late Uint8List customIcon;

// make sure to initialize before map loading
//   BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
//   'assets/images/car-icon.png')
//       .then((d) {
//   customIcon = d;
//   });

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Set<Marker> marker = new Set();
  Set<Circle> circles = new Set();
  Completer<GoogleMapController> _controller = Completer();
  var latlong1 = LatLng(37.42796133580664, -122.085749655962);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  LatLng currentLocation = _kGooglePlex.target;

  Future<void> location11() async {
    LocationData? _myLocation = await LoctionService().currentLocation();

    _animateCamera(_myLocation!);
  }

  Future<void> _animateCamera(LocationData locationData) async {
    // Uint8List b= (await NetworkAssetBundle(Uri.parse('https://www.fluttercampus.com/img/car.png')).load('https://www.fluttercampus.com/img/car.png')).buffer.asUint8List();
    final GoogleMapController controller = await _controller.future;
    lat = locationData.latitude;
    long = locationData.longitude;

    marker.add(Marker(
        // draggable: true,
        // icon: BitmapDescriptor.fromBytes(b),

        markerId: MarkerId("0"),
        position: LatLng(locationData.latitude!, locationData.longitude!)));
    double l = double.parse(AppCubit.list_st[0].schoolLat ?? "0");
    double ln = double.parse(AppCubit.list_st[0].schoolLng ?? "0");
    latlong1 = LatLng(l, ln);
    // Uint8List schoool_imag= (await NetworkAssetBundle(Uri.parse('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).load('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).buffer.asUint8List();

//     for(int i =0;i<AppCubit.list_st.length;i++)
//       {
//         double l= double.parse(AppCubit.list_st[i].schoolLat??"0");
//         double ln= double.parse(AppCubit.list_st[i].schoolLng??"0");
// latlong1=LatLng(l,ln);
//         // Uint8List schoool_imag= (await NetworkAssetBundle(Uri.parse('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).load('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).buffer.asUint8List();
//         Uint8List b= (await NetworkAssetBundle(Uri.parse(AppCubit.list_st[i].avatar.toString())).load('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).buffer.asUint8List();
//         marker.add( Marker(
//
//             draggable: true,
//
//             icon: BitmapDescriptor.fromBytes(b),
//             onDragEnd: (value) {
//               lat=value.longitude;
//               long=value.longitude;
//             },
//
//             markerId: MarkerId(AppCubit.list_st[i].id.toString()),
//             position: LatLng(l, ln)));
//       }

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 14.4746,
    );

    lat = locationData.longitude;
    long = locationData.longitude;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  //
  // Future<void> post_change_location(String type)
  // async {
  //
  //
  //   var response=await DioHelper.postData(url:Perent_Notification , data:{
  //     'name':'changed_location',
  //     'location_type':type,
  //     'long':long,
  //     'lat':lat,
  //     'mobile':'',
  //     'student_id':widget.std_id.toString(),
  //
  //
  //   },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {
  //
  //
  //     showDialog(context: context, builder: (context) => AlertDialog( content: Container(
  //       child: Text('The Pick-up and Drop-off Locations have been changed successfully'),
  //     ),
  //       actions: [
  //         Container(
  //           width: double.infinity,
  //           alignment: Alignment.center,
  //           child: Container(
  //             decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.green),
  //                 borderRadius: BorderRadius.circular(40)),
  //             child: MaterialButton(
  //               child: const Text(
  //                 "OK",
  //                 style: TextStyle(color: Colors.green),
  //               ),
  //               onPressed: () {
  //
  //                 Navigator.pop(context);
  //                 Navigator.pop(context);
  //
  //               },),
  //           ),
  //         ),
  //
  //       ],),);
  //
  //
  //   },).catchError((onError){
  //     // print(onError);
  //     // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
  //
  //   });
  //
  // }
  // void change_location()
  // {
  //   if(isChecked==true&&isChecked2==true)
  //   {
  //     //  both
  //     post_change_location('both');
  //   }
  //   else if(isChecked==true&&isChecked2==false)
  //   {
  //     //  pick-up
  //     post_change_location('pick-up');
  //   }
  //   else if(isChecked==false&&isChecked2==true)
  //   {
  //     //  drop-off
  //     post_change_location('drop-off');
  //   }
  //   else
  //   {
  //     showDialog(context: context, builder: (context) => dialog(massage: 'pleas select round type', title: Image(image: AssetImage('images/img_error.png')) ),);
  //
  //   }
  //
  // }
  @override
  void initState() {
    location11();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              t?.cancel();
              Navigator.pop(context);
              return false;
            },
            child: Scaffold(
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 20,
                child: Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                t?.cancel();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Setting(),
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "images/icon_feather_search.svg",
                                    color: Color(0xff98aac9),
                                    height: 22,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                t?.cancel();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Tracking(),
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "images/bus.svg",
                                    color: Color(0xff98aac9),
                                    height: 22,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                t?.cancel();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Hiome_Kids(),
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "images/icons8_home.svg",
                                    color: Color(0xff98aac9),
                                    height: 22,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                t?.cancel();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PickUp_Request(),
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "images/picup_full.svg",
                                    color: Color(0xff7cb13b),
                                    height: 22,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: MaterialButton(
                              minWidth: 40,
                              onPressed: () {
                                t?.cancel();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => General_app(),
                                    ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "images/icons8_four_squares.svg",
                                    color: Color(0xff98aac9),
                                    height: 22,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
//                   body: SingleChildScrollView(
//                     child: Container(
//                       height: MediaQuery.of(context).size.height,
//                       child: Column(
//                         children: [
//
//                           Expanded(
//                             child: GoogleMap(
//                               mapType: MapType.hybrid,
//                               initialCameraPosition: _kGooglePlex,
//                               markers: marker,
//                               circles: circles,
//                               onLongPress: (argument) {
//
//                               },
//                               onMapCreated: (GoogleMapController controller) {
//                                 _controller.complete(controller);
//                               },
//                               onCameraMove: (position) {
//
//                                 setState(() {
//                                   currentLocation = position.target;
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 25,),
//                           Container(
//
//                             color: Colors.white,
//                              height: 100,
//                             child: ListView.builder(
//
//
//                               scrollDirection: Axis.horizontal,
//                               itemCount: AppCubit.list_st.length ,
//                               itemBuilder: (context, index) {
//                                 return student_list(index, AppCubit.list_st[index]);
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 10,),
//                           Container(
// padding: EdgeInsets.symmetric(horizontal: 30),
//                               child: Divider(
//                                 color: Colors.black,
//                               )),
//                           SizedBox(height: 10,),
//                           InkWell(
//                             onTap: () async {
//
//
// if(isChecked)
// {
//   pickupRequest();
//
//
// }
//                             },
//
//                             child: Container(
//                               margin: const EdgeInsets.symmetric(horizontal: 30),
//                               padding: EdgeInsets.all(15),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: isChecked?Color(0xff7cb13b):Color(0xff7cb13b).withOpacity(.45),
//                               ),
//                               alignment: Alignment.center,
//                               child: Text(
//                                 AppLocalizations.of(context)
//                                     .translate('pick_up'),
//                                 style: GoogleFonts.montserrat(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.normal,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20,),
//                           Visibility(
//                               visible: !isChecked,
//                               child:Text("You should be in the right zone to request",style: TextStyle(fontSize: 11,color:Color(0xffe84314) ),) ),
//                           SizedBox(height: 20,),
//                         ],
//                       ),
//                     ),
//                   ),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            GoogleMap(
                              mapType: MapType.hybrid,
                              initialCameraPosition: _kGooglePlex,
                              markers: marker,
                              circles: circles,
                              onLongPress: (argument) {},
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              onCameraMove: (position) {
                                setState(() {
                                  currentLocation = position.target;
                                });
                              },
                            ),
                            DraggableScrollableSheet(
                              initialChildSize: .45,
                              minChildSize: .2,
                              maxChildSize: .97,
                              expand: false,
                              builder: (context, scrollController) =>
                                  SingleChildScrollView(
                                      controller: scrollController,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Card(
                                                color: Color(0xffeaeaea),
                                                elevation: 0,
                                                child: Container(
                                                  height: 6,
                                                  width: 50,
                                                )),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 100,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    AppCubit.list_st.length,
                                                itemBuilder: (context, index) {
                                                  return student_list(index,
                                                      AppCubit.list_st[index]);
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30),
                                                child: Divider(
                                                  color: Colors.black,
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                if (isChecked) {
                                                  pickupRequest();
                                                }
                                              },
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30),
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: isChecked
                                                      ? Color(0xff7cb13b)
                                                      : Color(0xff7cb13b)
                                                          .withOpacity(.45),
                                                ),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('pick_up'),
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Visibility(
                                                visible: !isChecked,
                                                child: Text(  AppLocalizations.of(context).translate('pickup_you_sh'),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xffe84314)),
                                                )),
                                            SizedBox(
                                              height: 60.h,
                                            ),

                                            // infoAbsent(),
                                          ],
                                        ),
                                      )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Uint8List> getBytesFromA(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> pickupRequest() async {
    var response = await DioHelper.postData(
            url: Pre_Arrive,
            data: {
              'school_id': school_id,
              'student_id': stuid,
              'locale': CacheHelper.getBoolean(key: 'locale'),
            },
            token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
      (value) {
        showDialog(context: context, builder: (context) => send_pickup());
        // Navigator.pop(context);
        // showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);
      },
    ).catchError((onError) {
      // print(onError);
      // // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
      // showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;

    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    // print(12742 * asin(sqrt(a)) * 1000);

    return 12742 * asin(sqrt(a)) * 1000;
  }

  Future<void> chack_Distance(
      var schoolLat, var schoolLng, var distance) async {
    circles.clear();
    marker.clear();

    location11();

    LocationData? _myLocation = await LoctionService().currentLocation();
    double? currentLocation_lat = _myLocation?.latitude;
    double? currentLocation_longitude = _myLocation?.longitude;
    Uint8List b = (await NetworkAssetBundle(
                Uri.parse(AppCubit.list_st[0].avatar.toString()))
            .load(
                'https://trackware-schools.s3.eu-central-1.amazonaws.com/home.png'))
        .buffer
        .asUint8List();
    Uint8List b1 = (await NetworkAssetBundle(
                Uri.parse(AppCubit.list_st[0].avatar.toString()))
            .load(
                'https://trackware-schools.s3.eu-central-1.amazonaws.com/loction1.png'))
        .buffer
        .asUint8List();

    setState(() {
      marker.add(Marker(
          markerId: MarkerId("0"),
          icon: BitmapDescriptor.fromBytes(b1),
          position: LatLng(currentLocation_lat!, currentLocation_longitude!)));
      marker.add(Marker(
          icon: BitmapDescriptor.fromBytes(b),
          markerId: MarkerId("2"),
          position: LatLng(
              double.parse(schoolLat ?? "0"), double.parse(schoolLng ?? "0"))));
    });
    if (calculateDistance(
            double.parse(schoolLat ?? "0"),
            double.parse(schoolLng ?? "0"),
            _myLocation?.latitude,
            _myLocation?.longitude) <
        double.parse(distance!)) {
      setState(() {
        circles.add(Circle(
          circleId: CircleId("1"),
          center: LatLng(
              double.parse(schoolLat ?? "0"), double.parse(schoolLng ?? "0")),
          radius: double.parse(distance!),
          strokeWidth: 2,
          strokeColor: Color(0Xff7cb13b),
          fillColor: Color(0Xff7cb13b).withOpacity(.2),
        ));
        isChecked = true;
      });
    } else {
      setState(() {
        circles.add(Circle(
          circleId: CircleId("1"),
          center: LatLng(
              double.parse(schoolLat ?? "0"), double.parse(schoolLng ?? "0")),
          radius: double.parse(distance!),
          strokeWidth: 2,
          strokeColor: Color(0Xffe84314),
          fillColor: Color(0Xffe84314).withOpacity(.2),
        ));
        isChecked = false;
      });
    }
  }

  Widget student_list(int ind, Students listDetail1) {
    student.add({
      'name': listDetail1.fname,
      "color": Colors.transparent,
      "id": listDetail1.id,
      "image": listDetail1.avatar
    });

    return Padding(
      padding: EdgeInsets.only(
          left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
              ? 0
              : 0,
          right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
              ? 25
              : 0),
      child: Container(
        margin: EdgeInsets.only(left: 25),
        child: InkWell(
          onTap: () async {
            var lat = listDetail1.schoolLat;
            var lon = listDetail1.schoolLng;
            var distance = listDetail1.pickupRequestDistance.toString();

            chack_Distance(lat, lon, distance);
            t = Timer.periodic(new Duration(seconds: 5), (timer) {
              chack_Distance(lat, lon, distance);
            });

            setState(() {
              stuid = listDetail1.id.toString();
              school_id = listDetail1.schoolId.toString();
              student[ind]['color'] = Color(0xff3c92d0);
              for (int i = 0; i < student.length; i++) {
                if (i != ind) {
                  student[i]['color'] = Colors.transparent;
                }
              }
            });
          },
          child: Column(children: [
            CircleAvatar(
              backgroundColor: student[ind]['color'],
              radius: 30,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 28,
                backgroundImage: NetworkImage(
                  '${listDetail1.avatar}',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${listDetail1.fname}",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Nunito',
                  fontSize: 9),
            ),
          ]),
        ),
      ),
    );
  }
}
