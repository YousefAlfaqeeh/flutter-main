
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/listdetail.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/login/login.dart';
import 'package:udemy_flutter/modules/map/round_location.dart';
import 'package:udemy_flutter/modules/notification/notification.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/local/lacal_notification_service.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';


class Kids extends StatefulWidget {
  @override
  State<Kids> createState() => _KidsState();
}

class _KidsState extends State<Kids> {
  late String round;
  // Kids_list? student;
  List<Students> list_st=[];
  Kids_list? student;
  late Students students;
  late int length;
  String mass='';
  String student_id='';
  String title='';
  String Picked='';
  Color color1=Colors.grey;
  final keyRefresh =GlobalKey<RefreshIndicatorState>();
  List<ListDetail> listDetail1=[] ;
  List<ListFeatures> listFeatures=[];
  List<Features> listFeatures1=[];
  bool flg=false;

  int i=0;

  void getStudent()async
  {

    var responseKids=await DioHelper.postData(url:Kids_List , data:{},token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {
      student=Kids_list.fromJson(value.data);

      setState(() {
        list_st=student!.students!;
      });

    },).catchError((onError){
      // dialog.show(context, 'ddddddddddd',  Image(image: AssetImage('images/img_error.png')));
      showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);

    });

  }

  void shwoDialog()async
  {
    for(i;i>=1;i--)
    {


      if(CacheHelper.getBoolean(key: 'pickup').toString()!='true'){

        showDialog(

            context: context,
            builder: (context) => dialog(
              title:
              Column(
                children: [

                  Expanded(
                    child:
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              massage: mass,
            ));
      }
      else{

        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context) => dialog_confirmed_pick(student_id: student_id,
              title:
              Column(
                children: [

                  Expanded(
                    child:
                    Text(
                      AppLocalizations.of(context).translate('pickup_confirm_tit'),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              massage: mass,
            ));
    }

      // showDialog(
      //   context: context,
      //   builder: (context) => dialog(
      //       massage:mass,
      //       title: const Image(image: AssetImage('images/img_error.png'))),
      // );
      if(i!=1)
      {
        Navigator.of(context,rootNavigator: true).pop();

      }
    }
  }

  void shwoDialogPick(  String student_id,String name)async
  {

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => dialog_confirmed_pick(student_id: student_id,
              title:
              Column(
                children: [

                  Expanded(
                    child:
                    Text(
                      AppLocalizations.of(context).translate('pickup_confirm_tit'),
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              massage: AppLocalizations.of(context).translate('pickup_confirm')+name+AppLocalizations.of(context).translate('pickup_confirm1'),
            ));

  }

  @override
  void initState() {
    // TODO: implement initState

Timer timer = new Timer(new Duration(seconds: 1), () {    for(int i=0;i<AppCubit.list_st.length;i++)
{
  if(CacheHelper.getBoolean(key: 'pickup').toString()=='true')
  {

    if(CacheHelper.getBoolean(key: 'pickup'+AppCubit.list_st[i].id.toString())!=null && CacheHelper.getBoolean(key: 'pickup'+AppCubit.list_st[i].id.toString()).toString().isNotEmpty)
    {
      shwoDialogPick(AppCubit.list_st[i].id.toString(),AppCubit.list_st[i].name.toString());
    }
  }
}});



    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

          shwoDialog();

        },
        builder: (context, state) {

          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            setState(() {
              i++;

              if(event.data.isNotEmpty){

                student_id=event.data['student_id'];
                Picked=event.data['Picked'].toString();

                  CacheHelper.saveData(key: 'pickup', value: event.data['picked'].toString());
                  CacheHelper.saveData(key: 'pickup'+event.data['student_id'], value: event.data['picked'].toString());

              }else
                {
                  Picked="";
                }
              AppCubit.get(context).getChildren();
              title=event.notification!.title.toString();
              mass= event.notification!.body.toString();
              // shwoDialog();

            });

          });

    FirebaseMessaging.onMessage.listen((event) {

      setState(() {
        i++;

        if(event.data.isNotEmpty){
          student_id=event.data['student_id'];
          Picked=event.data['Picked'].toString();
          CacheHelper.saveData(key: 'pickup', value: event.data['picked'].toString());
          CacheHelper.saveData(key: 'pickup'+event.data['student_id'], value: event.data['picked'].toString());

        }
        else
        {
          Picked="";
        }
        AppCubit.get(context).getChildren();
        title=event.notification!.title.toString();
        mass= event.notification!.body.toString();
        // shwoDialog();

      });
    });
          return
          WillPopScope(
            onWillPop: () async {
             SystemNavigator.pop();
             return false;
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title:
                    Container(alignment: Alignment.center, child: Text(AppLocalizations.of(context).translate('my_children'))),
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
                      onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setting(),
                          ));},
                      icon: Icon(Icons.settings))
                ],
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed:() async {
                    AppCubit()
                      ..getschool();
                    await AppCubit.get(context).getschool();
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  Auth(),));},
                  child: Icon(Icons.add)),
              body:  Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      children: List.generate(AppCubit.list_st.length, (index) => student_list(index,AppCubit.list_st[index])))),
               ),
          );
        },
      ),

    );
  }

  Widget student_list(int ind,Students listDetail1) {
    var activityType=listDetail1.studentStatus!.activityType.toString();
    bool map=false;
    if (listDetail1.showMap==true )
        map=true;
    else
      map=false;
if (listDetail1.isActive== false && activityType !='in')
  {
    round=AppLocalizations.of(context).translate('no_active_round');

    color1=Colors.grey;
  }
else
  { color1=Colors.blueAccent;
    round=AppLocalizations.of(context).translate('active_round');

  }
listFeatures1=[];
    return InkWell(

      onTap: () {
        print('-------------------------------------------------1111');

        listFeatures1.clear();

        listFeatures1.add(Features(name: AppLocalizations.of(context).translate('call'), icon: 'https://www.realmadrid.com/StaticFiles/RealMadridResponsive/images/static/og-image.png',nameAr:AppLocalizations.of(context).translate('call'),mobile_number: listDetail1.schoolMobileNumber,school_name: listDetail1.schoolName));
              if(listDetail1.showAbsence==true)
        {
          listFeatures1.add( Features(name: AppLocalizations.of(context).translate('absent'), icon: 'https://www.realmadrid.com/StaticFiles/RealMadridResponsive/images/static/og-image.png',nameAr: AppLocalizations.of(context).translate('absent')));
        }
        // if(listDetail1.changeLocation==true)
        // {
        //
        //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://www.realmadrid.com/StaticFiles/RealMadridResponsive/images/static/og-image.png',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
        //
        // }


        if(listDetail1.dropOffByParent==true)
        {
          print("dddddddd");
            listFeatures1.add( Features(name: AppLocalizations.of(context).translate('pick_up'), icon: 'https://www.realmadrid.com/StaticFiles/RealMadridResponsive/images/static/og-image.png',nameAr: AppLocalizations.of(context).translate('pick_up')));

        }
        listFeatures1.add( Features(name: AppLocalizations.of(context).translate('feedback'), icon: 'https://www.realmadrid.com/StaticFiles/RealMadridResponsive/images/static/og-image.png',nameAr: AppLocalizations.of(context).translate('feedback')));
        listDetail1.features!.forEach((element) {print('-------');print(element.name);listFeatures1.add(element); });
        print('-------------------------------------------------');
        AppCubit.get(context).setDetalil(listDetail1.name, listDetail1.studentGrade??"", listDetail1.schoolName, listDetail1.avatar, listDetail1.id.toString(),  listDetail1.schoolLat, listDetail1.schoolId.toString(), listDetail1.schoolLng, listDetail1.pickupRequestDistance.toString(), listFeatures1);
        print(AppCubit.std);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail()),
        );
      },
      child: Container(
        alignment: Alignment.bottomCenter,
        // padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            height: 10,
          ),
          Text("${listDetail1.name}"),
          SizedBox(
            height: 20,
          ),
          Expanded(
            
              child: CircleAvatar(
                backgroundColor: Colors.transparent ,
            maxRadius: MediaQuery.of(context).size.width/15,


            backgroundImage: NetworkImage('${listDetail1.avatar}', ),

          )),
          SizedBox(
            height: 10,
          ),

          Expanded(
            child: map  ?TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[100]),
                    foregroundColor: MaterialStateProperty.all(Colors.grey)),
                onPressed: () {

                  if(listDetail1.isActive == true)
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Round_Location(assistant_name:listDetail1.assistantName ,bus_id: listDetail1.busId.toString(),round_name:listDetail1.roundType ,school_name:CacheHelper.getBoolean(key: 'school_name') ,student_name: listDetail1.name,driver: listDetail1.driverName,image: listDetail1.avatar,round_id: listDetail1.roundId.toString(),school_lng: listDetail1.schoolLng,school_lat:listDetail1.schoolLat,)),
                      );
                    }

                },
                child: Container(
                  child: Row(children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(183, 182, 182, 100)),borderRadius: BorderRadius.circular(50)),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          maxRadius: 15,
                          child: Icon(color: color1, Icons.directions_bus)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(
                            round,style: TextStyle(color: color1),))
                  ]),
                )):Text(""),
          ),
        ]),
      ),
    );
  }
}
