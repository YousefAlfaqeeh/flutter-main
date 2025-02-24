import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/widget/date_picker_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/services/location_services.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'dart:ui' as ui;
import 'dart:math';

import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class Tracking extends StatefulWidget {
  Tracking();

  @override
  State<Tracking> createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> with WidgetsBindingObserver {
  String? stuid, school_id;
  Timer? t;
  bool map = false;
  final DBRef = FirebaseDatabase.instance.reference();
  List<Map> student = [];
  bool isChecked = false;
  bool isRoundInfo = false;
  bool isstudent = true;
  bool isStudentInRound = false;
  bool isStudentInRound1 = false;
  bool isAbs = false;
  String absent = 'both';
  dynamic lat, long;
  late Uint8List customIcon;

  String busNum = '';
  String assistant_name = '';
  String round_name = '';
  String driver = '';
  DateTime now = new DateTime.now();
  DateTime newDate = new DateTime.now();

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

  Completer<GoogleMapController> _controller = Completer();

  var latlong1 = LatLng(37.42796133580664, -122.085749655962);

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
  }

  Future<void> _animateCamera(LocationData locationData) async {
    final GoogleMapController controller = await _controller.future;
    lat = locationData.latitude;
    long = locationData.longitude;
    Uint8List b1 = (await NetworkAssetBundle(
                Uri.parse(AppCubit.list_st[0].avatar.toString()))
            .load(
                'https://trackware-schools.s3.eu-central-1.amazonaws.com/loction1.png'))
        .buffer
        .asUint8List();

    double homestL = double.parse(AppCubit.list_st[0].lat ?? "0");
    double homestLn = double.parse(AppCubit.list_st[0].long ?? "0");
    marker.add(Marker(
        // draggable: true,
        icon: BitmapDescriptor.fromBytes(b1),
        markerId: MarkerId("0"),
        position: LatLng(homestL, homestLn)));
    double l = double.parse(AppCubit.list_st[0].schoolLat ?? "0");
    double ln = double.parse(AppCubit.list_st[0].schoolLng ?? "0");
    latlong1 = LatLng(l, ln);

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(homestL, homestLn),
      zoom: 14.4746,
    );

    lat = homestL;
    long = homestLn;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }
  Future<void> _animateCameraAnd(Position locationData) async {
    final GoogleMapController controller = await _controller.future;
    lat = locationData.latitude;
    long = locationData.longitude;
    Uint8List b1 = (await NetworkAssetBundle(
        Uri.parse(AppCubit.list_st[0].avatar.toString()))
        .load(
        'https://trackware-schools.s3.eu-central-1.amazonaws.com/loction1.png'))
        .buffer
        .asUint8List();

    double homestL = double.parse(AppCubit.list_st[0].lat ?? "0");
    double homestLn = double.parse(AppCubit.list_st[0].long ?? "0");
    marker.add(Marker(
      // draggable: true,
        icon: BitmapDescriptor.fromBytes(b1),
        markerId: MarkerId("0"),
        position: LatLng(homestL, homestLn)));
    double l = double.parse(AppCubit.list_st[0].schoolLat ?? "0");
    double ln = double.parse(AppCubit.list_st[0].schoolLng ?? "0");
    latlong1 = LatLng(l, ln);

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(homestL, homestLn),
      zoom: 14.4746,
    );

    lat = homestL;
    long = homestLn;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  Future<void> _animateCameraSt(double lats,double longs) async {
    final GoogleMapController controller = await _controller.future;
    lat = lats;
    long = longs;
    Uint8List b1 = (await NetworkAssetBundle(
        Uri.parse(AppCubit.list_st[0].avatar.toString()))
        .load(
        'https://trackware-schools.s3.eu-central-1.amazonaws.com/loction1.png'))
        .buffer
        .asUint8List();

    // double homestL = double.parse(AppCubit.list_st[0].lat ?? "0");
    // double homestLn = double.parse(AppCubit.list_st[0].long ?? "0");

    marker.add(Marker(
      // draggable: true,
        icon: BitmapDescriptor.fromBytes(b1),
        markerId: MarkerId("0"),
        position: LatLng(lat, long)));
    double l = double.parse(AppCubit.list_st[0].schoolLat ?? "0");
    double ln = double.parse(AppCubit.list_st[0].schoolLng ?? "0");
    marker.add(Marker(
      // draggable: true,
        icon: BitmapDescriptor.fromBytes(b1),
        markerId: MarkerId("1"),
        position: LatLng(l, ln)));
    latlong1 = LatLng(l, ln);

    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );

    lat = lats;
    long = longs;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  void initState() {
    // location11();
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    WidgetsBinding.instance!.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state.toString().toLowerCase().contains("resumed")) {
      AppCubit.get(context).getChildren();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // Color(0xff98aac9)
        },
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
                                    "images/bus_1.svg",
                                    color: Color(0xfff9a200),
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
                                    "images/pick_up_by_parent.svg",
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
              body:  Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          map
                              ?
                          // Expanded(
                          //   child:
                          Stack(
                            children: [
                              GoogleMap(
                                mapType: MapType.hybrid,
                                initialCameraPosition: _kGooglePlex,
                                markers: marker,
                                onMapCreated:
                                    (GoogleMapController controller) {
                                  _controller.complete(controller);
                                },
                                onCameraMove: (position) {
                                  setState(() {
                                    currentLocation = position.target;
                                  });
                                },
                              ),
                              Visibility(
                                  visible: isRoundInfo,
                                  child: info_round()),
                            ],
                          )
                          // )
                              :
                          // Expanded(
                          //   child:
                          Container(
                              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/5),
                              alignment: Alignment.topCenter,
                              child: CustomLotte('assets/lang/bus.json')),
                          // ),
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

                                          Visibility(visible: isstudent, child: studentTracking()),
                                          Visibility(visible: isAbs, child: infoAbsent()),
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
          );
        },
      ),
    );
  }

  Future<void> getLoctionBus(
      var schoolLat, var schoolLng, String school_name, String round_id) async {
    dynamic lat, long;
    late Uint8List customIcon;
    dynamic school_lat = double.parse(schoolLat);
    dynamic school_lng = double.parse(schoolLng);
    String round_name = '';
    Uint8List schoool_imag = (await NetworkAssetBundle(Uri.parse(
                'https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png'))
            .load(
                'https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png'))
        .buffer
        .asUint8List();
    Uint8List b = (await NetworkAssetBundle(
                Uri.parse('https://www.fluttercampus.com/img/car.png'))
            .load('https://www.fluttercampus.com/img/car.png'))
        .buffer
        .asUint8List();
    final GoogleMapController controller = await _controller.future;
    final ref = FirebaseDatabase.instance.ref();
    if (DEV_PROD == 'dev') {
      round_name = school_name.toString() + '-stg-round-' + round_id.toString();
    } else {
      round_name = school_name.toString() + '-round-' + round_id.toString();
      print(round_name);
    }
    DateTime dateTime = DateTime.now();
    final snapshot = await ref
        .child(round_name)
        .child(DateFormat('yyyy-MM-dd').format(dateTime))
        .limitToLast(1)
        .get();
    if (snapshot.exists) {
      int start = snapshot.value.toString().indexOf('[');
      int end = snapshot.value.toString().indexOf(']');
      String location = snapshot.value.toString().substring(start, end + 1);
      lat = double.parse(location.substring(1, location.indexOf(', ')));
      long = double.parse(
          location.substring(location.indexOf(', ') + 1).replaceAll(']', ''));
      setState(() {
        // print("jjjjjjjjjj");
        marker.add(
          Marker(
              draggable: true,
              icon: BitmapDescriptor.fromBytes(schoool_imag),
              onDragEnd: (value) {},
              markerId: MarkerId("2"),
              position: LatLng(school_lat, school_lng)),
        );
        marker.add(
          Marker(
              draggable: true,
              onTap: () {
                setState(() {
                  isRoundInfo = true;
                });
              },
              icon: BitmapDescriptor.fromBytes(b),
              onDragEnd: (value) {},
              markerId: MarkerId("1"),
              position: LatLng(lat, long)),
        );
        CameraPosition _kGooglePlex = CameraPosition(
          target: LatLng(lat ?? 0.0, long ?? 0.0),
          zoom: 18,
        );

        controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      });
    } else {
      // print('No data available.');
      t?.cancel();
      showDialog(
        context: context,
        builder: (context) => dialog(
            massage: 'Connection Error',
            title: Image(image: AssetImage('images/img_error.png'))),
      );
    }
  }

  Widget student_list(int ind, Students listDetail1) {
    Color text_color = Color(0xff7cb13b);
    String round = "Active Round";
    CircleAvatar circleAvatar = CircleAvatar(
      backgroundColor: text_color,
      child: SvgPicture.asset('images/bus_1.svg',
          color: Colors.white, width: 10, height: 10),
    );

    var activityType = listDetail1.studentStatus!.activityType.toString();
    if (listDetail1.isActive == false && activityType != 'in') {
      round = AppLocalizations.of(context).translate('no_active_round');
      text_color = Colors.grey;
      circleAvatar = CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 3.w,
        child: SvgPicture.asset(
          'images/bus.svg',
          color: text_color,
          width: 10,
          height: 10,
        ),
      );
    } else {
      // print("asdasdasdasd" + activityType);
      if (activityType == 'out' ||
          activityType.toString().contains('show') ||
          activityType.toString().contains('absent') ||
          activityType.isEmpty) {
        round = AppLocalizations.of(context).translate('no_active_round');
        text_color = Colors.grey;
        circleAvatar = CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: SvgPicture.asset('images/bus.svg',
              color: text_color, width: 10, height: 10),
        );
      } else {
        text_color = Color(0xff7cb13b);
        round = AppLocalizations.of(context).translate('active_round');
        circleAvatar = CircleAvatar(
          radius: 10,
          backgroundColor: text_color,
          child: SvgPicture.asset('images/bus_1.svg',
              color: Colors.white, width: 10, height: 10),
        );
      }
    }
    student.add({
      'name': listDetail1.fname,
      "color": Colors.transparent,
      "id": listDetail1.id,
      "image": listDetail1.avatar
    });

    return Container(
      margin: EdgeInsets.only(
        left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
            ? 0
            : 25,
        right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
            ? 25
            : 0,
      ),
      child: InkWell(
        onTap: () async {
          // print("--------------kkkkllluuuuuyyyyyyy");
          // print(listDetail1.name);
          t?.cancel();
          busNum = listDetail1.busId.toString();
          assistant_name = listDetail1.assistantName.toString();
          round_name = listDetail1.roundName.toString();
          driver = listDetail1.driverName.toString();
          var lat = listDetail1.schoolLat;
          var lon = listDetail1.schoolLng;


          var school_name = listDetail1.db.toString();
          var round_id = listDetail1.roundId.toString();

          if (listDetail1.isActive == true && activityType == 'in') {

            if (activityType != 'out' ||
                !activityType.toString().contains('show') ||
                !activityType.toString().contains('absent')) {
              // isStudentInRound
              setState(() {
                isStudentInRound1 = true;

                isStudentInRound = false;
              });
              // print(listDetail1.showMap);
              if (listDetail1.showMap == true) {

                setState(() {
                  map = true;
                });
                _animateCameraSt(double.parse(listDetail1.lat ?? "0"),double.parse(listDetail1.long ?? "0"));
                t = Timer.periodic(new Duration(seconds: 5), (timer) {
                  getLoctionBus(lat, lon, school_name.toString(), round_id);
                });
              } else {
                setState(() {
                  map = false;
                });
              }
            }
          }
          else {
            setState(() {
              map = false;
            });
            isStudentInRound1 = false;
            isStudentInRound = true;
          }

          setState(() {
            // print('fffff' + listDetail1.showMap.toString());
            // if (listDetail1.showMap == true) {
            //   print('fffff' + listDetail1.showMap.toString());
            //   setState(() {
            //     map = true;
            //   });
            // }

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
          Stack(
            children: [
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
              Container(
                margin: EdgeInsets.only(
                    top: 35,
                    left: CacheHelper.getBoolean(key: 'lang')
                            .toString()
                            .contains('ar')
                        ? 0
                        : 42,
                    right: CacheHelper.getBoolean(key: 'lang')
                            .toString()
                            .contains('ar')
                        ? 42
                        : 0),
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: text_color),
                // color: Colors.red,
                // width: 7.w,
                // height: 11.w,
                child: circleAvatar,
              ),
            ],
          ),
          SizedBox(
            height: 3.w,
          ),

          Text(
            "${listDetail1.fname}",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: 'Nunito',
                fontSize: 11),
          ),

          // SizedBox(height: 1.w,),

          Text(
            round,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
                fontSize: 10,
                color: text_color),
          ),
        ]),
      ),
    );
  }

  Widget studentTracking() {
    return Column(children: [
      SizedBox(
        height: 4.w,
      ),
      Card(
          color: Color(0xffeaeaea),
          elevation: 0,
          child: Container(
            height: 6,
            width: 50,
          )),
      SizedBox(
        height: 4.w,
      ),
      Container(
        color: Colors.white,
        height: 30.w,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: AppCubit.list_st.length,
          itemBuilder: (context, index) {
            return student_list(index, AppCubit.list_st[index]);
          },
        ),
      ),
      SizedBox(
        height: 5.w,
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Colors.black,
          )),
      SizedBox(
        height: 4.w,
      ),
      InkWell(
        onTap: () async {
          
          if (isStudentInRound) {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              context: context,
              builder: (context) => DraggableScrollableSheet(
                initialChildSize: .5,
                minChildSize: .4,
                maxChildSize: .97,
                expand: false,
                builder: (context, scrollController) => Scaffold(
                  bottomNavigationBar: BottomAppBar(
                    shape: CircularNotchedRectangle(),
                    notchMargin: 20,
                    child: Container(
                      height: 20.h,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              // showDialog(
                              //
                              //     context: context, builder: (context) => send_abs());
                              // print('--------------1111-');
                              // print(newDate);

                              if (absent.toString() != 'null') {
                                if (isStudentInRound) {
                                  setState(() {
                                    isAbs = false;
                                    isstudent = true;
                                  });
                                  // print('---------------');
                                  // print(newDate);
                                  var attendanceDate = newDate.day.toString() +
                                      '/' +
                                      newDate.month.toString() +
                                      '/' +
                                      newDate.year.toString();

                                  var response = await DioHelper.postData(
                                          url: Perent_Notification,
                                          data: {
                                            'name': 'childs_attendance',
                                            'absent': 'true',
                                            'long': 0.0,
                                            'lat': 0.0,
                                            'target_rounds': absent,
                                            'student_id': stuid.toString(),
                                            'when': attendanceDate,
                                          },
                                          token: CacheHelper.getBoolean(
                                              key: 'authorization'))
                                      .then(
                                    (value) {

                                      if (value.data
                                          .toString()
                                          .toLowerCase()
                                          .contains("ok")) {
                                        showAnimatedDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return send_abs();
                                          },
                                          animationType:
                                              DialogTransitionType.scale,
                                          curve: Curves.fastOutSlowIn,
                                          duration: Duration(seconds: 1),
                                        );
                                        // showDialog(
                                        //
                                        //     context: context, builder: (context) => send_abs());
                                      } else {
                                        if(value.data.toString().contains('checked'))
                                          {
                                            showDialog(
                                              context: context,
                                              builder: (context) => dialog(
                                                  massage:AppLocalizations.of(context).translate('checked')
                                                  ,
                                                  title: Text('')),
                                            );
                                          }
                                        else
                                          {
                                            showDialog(
                                              context: context,
                                              builder: (context) => dialog(
                                                  massage:AppLocalizations.of(context).translate('absent_request_because')
                                                  ,
                                                  title: Text('')),
                                            );
                                          }

                                      }
                                    },
                                  ).catchError((onError) {
                                    // print(onError);

                                    // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
                                  });
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => dialog(
                                      massage: 'please select absent type',
                                      title: Image(
                                          image: AssetImage(
                                              'images/img_error.png'))),
                                );
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff3c92d0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('absent_request'),
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                          Row(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "images/icon_feather_search.svg",
                                            color: Colors.grey,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "images/bus_1.svg",
                                            color: Color(0xfff9a200),
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
                                              builder: (context) =>
                                                  Hiome_Kids(),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "images/icons8_home.svg",
                                            color: Colors.grey,
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
                                              builder: (context) =>
                                                  PickUp_Request(),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "images/pick_up_by_parent.svg",
                                            color: Colors.grey,
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
                                              builder: (context) =>
                                                  General_app(),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "images/icons8_four_squares.svg",
                                            color: Colors.grey,
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
                        ],
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                      controller: scrollController,
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
                          infoAbsent(),
                        ],
                      )),
                ),
              ),
            );
            setState(() {
              // isAbs = true;
              // isstudent = false;
            });
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: isStudentInRound
                ? Color(0xfff9a200)
                : Color(0xfff9a200).withOpacity(.45),
          ),
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context).translate('absent_request'),
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 4.w,
      ),
      Visibility(
          visible: isStudentInRound1,
          child: Expanded(
              flex: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 7),
                  child: Text(
                    AppLocalizations.of(context).translate('message_absence'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, color: Color(0xffe84314)),
                  )))),
      SizedBox(
        height: 15.w,
      ),

      //message_absence
    ]);
  }

  Widget info_round() {
    return Container(
      color: Colors.transparent,
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Colors.transparent,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                isRoundInfo = false;
                              });
                            },
                            icon: Icon(
                              Icons.dangerous,
                              color: Color(0xff98aac9),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context).translate('round'),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Container(
                                alignment: Alignment.center,
                                child: Text(
                                  driver.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff3c92d0),
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate('driver'),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Container(
                                alignment: Alignment.center,
                                child: Text(driver.toString())),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate('attendent'),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Container(
                                alignment: Alignment.center,
                                child: Text(assistant_name.toString())),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).translate('bus'),
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Container(
                                alignment: Alignment.center,
                                child: Text(busNum.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 1.65),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: MediaQuery.of(context).size.width / 5,
                child: CircleAvatar(
                  backgroundColor: Color(0xfff9a200),
                  radius: MediaQuery.of(context).size.width / 10,
                  child: SvgPicture.asset(
                    'images/bus_1.svg',
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoAbsent() {
    // DateTime now =new DateTime.now();
    // DateTime newDate=new DateTime.now();
    return StatefulBuilder(

builder: (context, setState) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                alignment: Alignment.topCenter,
                child: Text(
                  AppLocalizations.of(context).translate('absentD'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                  ),
                )),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          // color: Colors.red,
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: 'both',
                groupValue: absent,
                onChanged: (value) {
                  setState(() {
                    absent = value.toString();
                  });
                },
              ),
              Expanded(
                  child:
                  Text(AppLocalizations.of(context).translate('whole'))),
            ],
          ),
        ),
        Container(
          height: 30,
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: 'pick',
                groupValue: absent,
                onChanged: (value) {
                  setState(() {
                    // print(absent);
                    absent = value.toString();
                  });
                },
              ),
              Expanded(
                  child:
                  Text(AppLocalizations.of(context).translate('during'))),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: DatePickerWidget(
            looping: false,
            firstDate: DateTime(now.year, now.month, now.day),
            initialDate: DateTime(now.year, now.month, now.day),
            lastDate: DateTime(now.year + 10, now.month, now.day),
            onChange: (dateTime, selectedIndex) {
              newDate = dateTime;
            },
          ),
        ),
      ],
    ),
  );
},
    );
  }
}
