import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:location/location.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/home.dart';
import 'package:udemy_flutter/modules/map/home_location.dart';
import 'package:udemy_flutter/modules/modulesOdoo/absence.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allEvents.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWeekPlans.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWorksheets.dart';
import 'package:udemy_flutter/modules/modulesOdoo/assignments.dart';
import 'package:udemy_flutter/modules/modulesOdoo/badges.dart';
import 'package:udemy_flutter/modules/modulesOdoo/calendar.dart';
import 'package:udemy_flutter/modules/modulesOdoo/clinic.dart';
import 'package:udemy_flutter/modules/modulesOdoo/exam.dart';

import 'package:udemy_flutter/modules/notification/notification.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/services/location_services.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'dart:math';

class Detail extends StatefulWidget {


  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  _callNumber() async{
    const number = '0799807675'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>  AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              onPressed: () {
               AppCubit.get(context).getChildren();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Kids(),
                    ));
                // Navigator.pop(context);
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
            title: Container(alignment: Alignment.center, child: Text(AppLocalizations.of(context).translate('profile'))),
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
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      color: Colors.grey[200],

                      child: Column(

                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage("${AppCubit.image}")),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${AppCubit.name}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(AppLocalizations.of(context).translate('grade')+ "${AppCubit.grade}"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(AppLocalizations.of(context).translate('school')+ " ${AppCubit.school}"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        de(AppCubit.listdetail[index]),
                    itemCount: AppCubit.listdetail.length,
                    separatorBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsetsDirectional.only(start: 60),
                          child: Divider(
                            color: Colors.black,
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {

      },)

    );
  }

  Widget de(Features listDetail) {
    // print(user);
    Widget circleAvatar ;
    if(listDetail.name==AppLocalizations.of(context).translate('call'))
      {
        circleAvatar=CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          child: Icon(Icons.call,color: Colors.blue,size: 30,),
        );
      }
    // else if(listDetail.name=='Absent'){
    //   // listDetail.name=='Pick up' ||listDetail.name=='Feedback'||listDetail.name=='Chang home location'||
    //   circleAvatar=CircleAvatar(
    //     backgroundColor: Colors.transparent,
    //     radius: 30,
    //     child: Icon(Icons.face_outlined,color: Colors.red,size: 30,),
    //   );
    //
    // }
    else if(listDetail.name==AppLocalizations.of(context).translate('absent')){
      // listDetail.name=='Pick up' ||listDetail.name=='Feedback'||listDetail.name=='Chang home location'||
      circleAvatar=CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        child: Container(
          alignment: Alignment.center,
          child:
          CircleAvatar(
            maxRadius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('images/icon_ab.png'),
          ),

          // Text('will your chid be absent for:')

        ),
        // child: Icon(Icons.face_outlined,color: Colors.red,size: 30,),
      );

    }
    else if(listDetail.name==AppLocalizations.of(context).translate('pick_up')){
      // listDetail.name=='Pick up' ||listDetail.name=='Feedback'||listDetail.name=='Chang home location'||
      circleAvatar=CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        child: Icon(Icons.family_restroom_rounded,color: Colors.deepPurpleAccent,size: 30,),
      );

    }
    else if(listDetail.name==AppLocalizations.of(context).translate('feedback')){
      // listDetail.name=='Pick up' ||listDetail.name=='Feedback'||listDetail.name=='Chang home location'||
      circleAvatar=CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        child: Icon(Icons.feedback,color: Colors.orange[200],size: 30,),
      );

    }
    else if(listDetail.name==AppLocalizations.of(context).translate('chang_home_location')){
      // listDetail.name=='Pick up' ||listDetail.name=='Feedback'||listDetail.name=='Chang home location'||
      circleAvatar=CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        child: Icon(Icons.location_on_outlined,color: Colors.green[200],size: 30,),
      );

    }
    else
      {
        circleAvatar= CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          backgroundImage: NetworkImage('${listDetail.icon}'),
        );
      }
    return InkWell(
      onTap: () {
        profile_achtion(listDetail);
      },
      child: Row(
        children: [

          circleAvatar,
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerRight:Alignment.centerLeft,
                  child: Text(
                    CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'${listDetail.nameAr}':'${listDetail.name}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  )),
            ],
          )),
          SizedBox(
            width: 20,
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  void profile_achtion(Features listDetail1) async {

    if (listDetail1.name == AppLocalizations.of(context).translate('call'))
    {
      showDialog(

        context: context,
        builder: (context) => dialogCall(
          school_name: listDetail1.school_name.toString(),
          school_number: listDetail1.mobile_number.toString(),
          functionCAll: () async{
            await FlutterPhoneDirectCaller.callNumber(listDetail1.mobile_number.toString());
          },

        ),
      );
    }
    else if (listDetail1.name == AppLocalizations.of(context).translate('absent'))
    {
     showDialog(     barrierDismissible: false,context: context, builder: (context) => dialog_absent(std_id: AppCubit.std.toString()),);
    }
    else if (listDetail1.name ==AppLocalizations.of(context).translate('chang_home_location') )
    {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => dialog_sure(
          massage: 'Change home location',
          functionOK: () async {
            Navigator.pop(context);
            // if(Platform.isAndroid)
            //   {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLocation(std_id:AppCubit.std),
                ));
          // }
            // else
            //   {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => FRoute(),
            //         ));
            //   }
          },
        ),
      );
    }
    else if (listDetail1.name == AppLocalizations.of(context).translate('pick_up'))
    {
      LocationData? _myLocation = await LoctionService().currentLocation();

      print(_myLocation);

      var distance = AppCubit.distance;
      showDialog(
        context: context,
        builder: (context) => dialog_sure(
          massage: 'are you sure ?',
          functionOK: () async {



            var lat = AppCubit.school_lat;
            var lon = AppCubit.school_lng;

            if (calculateDistance( double.parse(lat??"0"), double.parse(lon??"0"),
                _myLocation?.latitude, _myLocation?.longitude) <
                double.parse(distance!)) {
              var response=await  DioHelper.postData(url:Pre_Arrive , data:{
                'school_id':AppCubit.school_id.toString(),
                'student_id':AppCubit.std.toString(),
                'locale':CacheHelper.getBoolean(key: 'locale'),



              },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {


                Navigator.pop(context);
                showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);


              },).catchError((onError){

                // print(onError);
                // // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
                // showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);
              });

            } else {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => dialog(
                    massage: AppLocalizations.of(context).translate('picup_distance')
                         +
                            distance.toString() +AppLocalizations.of(context).translate('meters'),
                    title: Image(image: AssetImage('images/img_error.png'))),
              );
            }
          },
        ),
      );
    }
    else if (listDetail1.name == AppLocalizations.of(context).translate('feedback'))
    {

      showDialog(
        context: context,
        builder: (context) => dialog_feedback(
            functionCancel: () async {},
            functionOK: () async {},
            student_id: AppCubit.std),
      );
    }
    else
    {

      if(listDetail1.url.toString().contains("Clinic"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Clinic( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Assignments"))
      {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Assignments( std_id: AppCubit.std),
              ));
        }
      else if(listDetail1.url.toString().contains("Absence"))
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std,std_name: AppCubit.name,)));


      }
      else if(listDetail1.url.toString().contains("Weekly"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllWeeklyPlans( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Calendar"))
      {
        // CalendarApp
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => CalendarApp(),
        //     ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Calendar( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Homeworks"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllWorksheets(std_id:AppCubit.std)),);

      }
      else if(listDetail1.url.toString().contains("Events"))
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllEvents(std_id:AppCubit.std)),);

      }
      else if(listDetail1.url.toString().contains("Exams"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Exams( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Badges"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Badges( std_id: AppCubit.std,std_name:  AppCubit.name,),
            ));
      }
      else{
      //   Badges(std_id: '208',std_name: 'jjjj',)
      AppCubit.get(context).setUrl1( CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?listDetail1.arabicUrl.toString():listDetail1.url.toString());

     AppCubit.get(context).setUrl( CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?listDetail1.arabicUrl.toString():listDetail1.url.toString());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebView_Login( CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'${listDetail1.arabicUrl}':'${listDetail1.url}'),
          ));}
    }
  }


  double calculateDistance(lat1, lon1, lat2, lon2){

    var p = 0.017453292519943295;
    var c = cos;

    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a))*1000;
  }

}
