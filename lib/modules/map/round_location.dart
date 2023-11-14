import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:udemy_flutter/modules/notification/notification.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
class Round_Location extends StatefulWidget {
  String? bus_id;
  String? school_name;
  String? student_name;
  String? round_name;
  String? assistant_name;
  String? image;
  String? driver;
  String? round_id;
   String? school_lat;
   String? school_lng;

  Round_Location(
      {this.bus_id,
      this.school_name,
      this.student_name,
      this.round_name,
      this.assistant_name, this.image,
        this.driver,this.round_id,this.school_lat,this.school_lng});

  @override
  State<Round_Location> createState() => _Round_LocationState();
}

class _Round_LocationState extends State<Round_Location> {
  Set<Marker> marker = {};
  bool vis=true;
  bool vis1=false;
  bool timer_stop=false;
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  LocationData? _userLocation;
  Completer<GoogleMapController> _controller = Completer();
  final DBRef = FirebaseDatabase.instance.reference();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 20,
  );
  LatLng currentLocation = _kGooglePlex.target;

  Future<void> location11() async {
    // LocationData? _myLocation = await LoctionService().currentLocation();
    //  t = Timer(Duration(seconds: 10), () =>  _animateCamera(),);
    Timer.periodic(new Duration(seconds: 10), (timer) {

      if(timer_stop)
        {
          timer.cancel();
        }
      else
        {
          _animateCamera();
        }
    });


  }




  Future<void> _animateCamera() async {
    dynamic lat, long;
    late Uint8List customIcon ;
    dynamic school_lat=double.parse(widget.school_lat.toString()) ;
    dynamic school_lng=double.parse(widget.school_lng.toString());
    String round_name='';
    Uint8List schoool_imag= (await NetworkAssetBundle(Uri.parse('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).load('https://trackware-schools.s3.eu-central-1.amazonaws.com/test.png')).buffer.asUint8List();
    Uint8List b= (await NetworkAssetBundle(Uri.parse('https://www.fluttercampus.com/img/car.png')).load('https://www.fluttercampus.com/img/car.png')).buffer.asUint8List();
    final GoogleMapController controller = await _controller.future;
    final ref = FirebaseDatabase.instance.ref();
   if(DEV_PROD=='dev')
     {
       round_name = widget.school_name.toString() + '-stg-round-' + widget.round_id.toString();
     }else {
     round_name =
         widget.school_name.toString() + '-round-' + widget.round_id.toString();
   }
    DateTime dateTime= DateTime.now();
    final snapshot = await ref.child(round_name).child(DateFormat('yyyy-MM-dd').format(dateTime)).limitToLast(1).get();
    if (snapshot.exists) {

      int start=snapshot.value.toString().indexOf('[');
      int end=snapshot.value.toString().indexOf(']');
      String location=snapshot.value.toString().substring(start,end+1);
      lat=double.parse(location.substring(1,location.indexOf(', ')));
      long=double.parse(location.substring(location.indexOf(', ')+1).replaceAll(']', ''));

      marker.add( Marker(
          draggable: true,
          icon: BitmapDescriptor.fromBytes(schoool_imag),
          onDragEnd: (value) {

          },

          markerId: MarkerId("2"),
          position: LatLng(school_lat,school_lng )),);
      marker.add( Marker(
          draggable: true,
          icon: BitmapDescriptor.fromBytes(b),
          onDragEnd: (value) {

          },

          markerId: MarkerId("1"),
          position: LatLng(lat, long)),);
    CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat??0.0, long??0.0),
    zoom: 18,
    );

    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

    } else {
      // print('No data available.');
      showDialog(context: context, builder: (context) => dialog(massage: 'Connection Error', title: Image(image: AssetImage('images/img_error.png')) ),);
    }



    // var get_location= await DioHelper.getData(url: Get_Last_Location+'bus_id='+widget.bus_id.toString()+"&&school_naeme="+widget.school_name.toString()).then((value) {
    //   lat=value.data['lat'];
    //   long=value.data['long'];
    //   marker.add( Marker(
    //       draggable: true,
    //       icon: BitmapDescriptor.fromBytes(b),
    //       onDragEnd: (value) {
    //         print(value);
    //       },
    //
    //       markerId: MarkerId("1"),
    //       position: LatLng(lat, long)));
    //   CameraPosition _kGooglePlex = CameraPosition(
    //     target: LatLng(lat, long),
    //     zoom: 14.4746,
    //   );
    //
    //   controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
    //
    // },).catchError((onError)
    // {
    //   print(onError);
    //   // showDialog(context: context, builder: (context) => dialog(massage: 'Connection Error', title: Image(image: AssetImage('images/img_error.png')) ),);
    // }
    //
    // );


  }

  @override
  void initState() {
    // _determinePosition();
    _animateCamera();
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

          timer_stop=true;

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
          alignment: Alignment.center, child: Text("Location")),
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

        child: Container(
          alignment: Alignment.topCenter,
          child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
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
                Visibility(
                  visible: vis,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child:  Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                         Container
                            (
                              alignment: Alignment.bottomCenter
                               ,child: Image(image: AssetImage('images/img_circle.png'))
                              ),


                        InkWell(
                          onTap: () {
                            if(Platform.isAndroid) {
                              showDialog(context: context, builder: (context) => AlertDialog(
                                actions: [

                                  Container(

                                    alignment: Alignment.bottomCenter,
                                    child:  Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        Container
                                          (color: Colors.transparent,
                                          alignment: Alignment.bottomCenter
                                          ,child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,

                                            children: [
                                             CircleAvatar(
                                                  backgroundColor: Colors.grey[100] ,
                                                  maxRadius: 60,
                                                  backgroundImage: NetworkImage(
                                                      widget.image.toString()),

                                                ),

                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 20),
                                                  color: Colors.white,
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Text(widget.student_name.toString()),
                                                      SizedBox(width: 20,),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text('Driver : '),
                                                          Container(
                                                              alignment:  Alignment.center,
                                                              child: Text(widget.driver.toString())),
                                                        ],
                                                      ),
                                                      Divider(color: Colors.black,),
                                                      SizedBox(width: 10,),
                                                      Row(
                                                        children: [
                                                          Text('Attendent : '),
                                                          Container(  alignment:  Alignment.center,child: Text(widget.assistant_name.toString())),
                                                        ],
                                                      ),
                                                      Divider(color: Colors.black,),
                                                      SizedBox(width: 10,),
                                                      Row(
                                                        children: [
                                                          Text('Round : '),
                                                          Container(  alignment:  Alignment.center,
                                                              child: Text(widget.round_name.toString())),
                                                        ],
                                                      ),
                                                      Divider(color: Colors.black,),
                                                      SizedBox(width: 10,),
                                                    ],
                                                  )),


                                            ],),
                                        ),



                                      ],
                                    ),),

                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                         horizontal: 20),

                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(15)),
                                    width: double.infinity,
                                    // color: Colors.orange,
                                    child: MaterialButton(
                                      child: const Text("Ok"),
                                      onPressed: () async{
                                        Navigator.pop(context);

                                      },
                                    ),
                                  )
                                ],



                              ));

                            }
                            else
                            {
                              setState(() {
                                vis=false;
                                vis1 = true;

                              });
                            }

                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[100] ,
                            maxRadius: 60,
                            backgroundImage: NetworkImage(
                                widget.image.toString()),

                          ),
                        )
                      ],
                    ),),
                ),
                Visibility(

                  visible: vis1,
                  child: Container(

                    alignment: Alignment.bottomCenter,
                    child:  Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container
                          (color: Colors.transparent,
                            alignment: Alignment.bottomCenter
                            ,child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  vis=true;
                                  vis1=false;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100] ,
                                maxRadius: 60,
                                backgroundImage: NetworkImage(
                                    widget.image.toString()),

                              ),
                            ),
                              Container(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  color: Colors.white,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Text(widget.student_name.toString()),
                                      SizedBox(width: 20,),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Driver : '),
                                          Container(
                                              alignment:  Alignment.center,
                                              child: Text(widget.driver.toString())),
                                        ],
                                      ),
                                      Divider(color: Colors.black,),
                                      SizedBox(width: 10,),
                                      Row(
                                        children: [
                                          Text('Attendent : '),
                                          Container(  alignment:  Alignment.center,child: Text(widget.assistant_name.toString())),
                                        ],
                                      ),
                                      Divider(color: Colors.black,),
                                      SizedBox(width: 10,),
                                      Row(
                                        children: [
                                          Text('Round : '),
                                          Container(  alignment:  Alignment.center,
                                              child: Text(widget.round_name.toString())),
                                        ],
                                      ),
                                      Divider(color: Colors.black,),
                                      SizedBox(width: 10,),
                                    ],
                                  )),


                        ],),
                        ),



                      ],
                    ),),
                )

              ]),
        ),
      ),
    ],));
  }
}
class CustomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.lineTo(0.0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}