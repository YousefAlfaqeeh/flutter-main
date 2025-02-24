import 'dart:async';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/history.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/chat/teachers.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/modulesOdoo/absence.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allMark.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWeekPlans.dart';
import 'package:udemy_flutter/modules/modulesOdoo/assignments.dart';
import 'package:sizer/sizer.dart';
// import 'package:get/get.dart';
import 'package:udemy_flutter/modules/modulesOdoo/calendar.dart';
import 'package:udemy_flutter/modules/modulesOdoo/exam.dart';

import 'package:udemy_flutter/modules/modulesOdoo/formWorkSheet.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_badges.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_clinic.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_formEvent.dart';
import 'package:udemy_flutter/modules/modulesOdoo/timeTable.dart';
import 'package:udemy_flutter/modules/modulesOdoo/weeklyPlan.dart';
import 'package:udemy_flutter/modules/notification/filter.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/shoData/openMass.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../settings/setting.dart';

class Hiome_Kids extends StatefulWidget {
  const Hiome_Kids({Key? key}) : super(key: key);

  @override
  State<Hiome_Kids> createState() => _Hiome_KidsState();
}

class _Hiome_KidsState extends State<Hiome_Kids> with WidgetsBindingObserver {
  final controller= ScrollController();
  List<Map> list_filter=[
    {'name':"all",
      "color": Color(0xff98aac9),
      "sta":true,
      "image":""

    },
    {'name':"announcement",
      "color": Color(0xff3c92d0),
      "sta":false,
      "image":"images/icons8_megaphone.svg",
      "image_c":"images/icons8_megaphone_1.svg"


    },
    {'name':"educational",
      "color": Color(0xff6d9c34),
      "sta":false,
      "image":"images/icons8_open_book.svg",
      "image_c":"images/icons8_open_book3.svg"

    },
    {'name':"tracking",
      "color": Color(0xfff88c0b),
      "sta":false,
      "image":"images/bus.svg",
      "image_c":"images/bus_1.svg"

    },
    {'name':"Absence",
      "color": Color(0xffe84314),
      "sta":false,
      "image":"images/icons8_note.svg",
      "image_c":"images/icons8_note2.svg"

    },
  ];
  List<Map> list_filter_tracking=[
    {'name':"all",
      "color": Color(0xff98aac9),
      "sta":true,
      "image":""

    },
    {'name':"announcement",
      "color": Color(0xff3c92d0),
      "sta":false,
      "image":"images/icons8_megaphone.svg",
      "image_c":"images/icons8_megaphone_1.svg"


    },
    {'name':"tracking",
      "color": Color(0xfff88c0b),
      "sta":false,
      "image":"images/bus.svg",
      "image_c":"images/bus_1.svg"

    },
  ];
  List<Map> list_filter_sm=[
    {'name':"all",
      "color": Color(0xff98aac9),
      "sta":true,
      "image":""

    },
    {'name':"announcement",
      "color": Color(0xff3c92d0),
      "sta":false,
      "image":"images/icons8_megaphone.svg",
      "image_c":"images/icons8_megaphone_1.svg"


    },
    {'name':"educational",
      "color": Color(0xff6d9c34),
      "sta":false,
      "image":"images/icons8_open_book.svg",
      "image_c":"images/icons8_open_book3.svg"

    },

    {'name':"Absence",
      "color": Color(0xffe84314),
      "sta":false,
      "image":"images/icons8_note.svg",
      "image_c":"images/icons8_note2.svg"

    },
  ];
  String student_name='';
  String mass='';
  String student_id='';
  String title='';
  String Picked='';
  String start_date='2022-01-01 01:12:12';
  String end_date= DateTime.now().toString();
  static List<Notifications> list_notif=[];
  static Notification_api ?notification;
  int i=0;
  List<Notifications> list_Notfi_Search=[];
  bool flg=false;
  final List<Map> filter = [];
  bool isLoading=false;
  bool show=true;


  void get_notif (dynamic fromDate,dynamic fromTo) async
  {


    if(fromDate.toString().isNotEmpty&& fromTo.toString().isNotEmpty){
      start_date=fromDate.toString();
      end_date=fromTo.toString();
    }
    else if(fromDate.toString().isNotEmpty&& fromTo.toString().isEmpty)
    {
      start_date=fromDate.toString();
    }
    else if(fromDate.toString().isEmpty&& fromTo.toString().isNotEmpty)
    {
      end_date=fromTo.toString();
    }

    var responseKids=await DioHelper.postData(url:Kids_history , data:{

      "start_date": start_date,
      "end_date": end_date,
    },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {

      notification=Notification_api.fromJson(value.data);
      setState(() {

        list_notif=notification!.notifications;
        // list_notif.sort((a, b) {
        //   DateTime dt1=DateTime.parse(a.createdateTime!);
        //   // String x=DateFormat('yyyy-MM-dd').format(DateTime.parse();
        //   dt1=DateTime.parse(a.createdateTime!);
        //   int num=-1;
        //
        //   if ( dt1.isAfter(DateTime.parse(b.createdateTime!)))
        //   {
        //     num=0;
        //   }
        //
        //   return num ;
        // },);
        AppCubit.list_notif=list_notif;
        isLoading=false;
      });



    },).catchError((onError){

    });


  }
  onSearchTextChanged(String text,String student_name)async
  {

    if(student_name=='All'){
      student_name=student_name.toLowerCase();}
    list_Notfi_Search.clear();
    if((text.isEmpty || text=='all') && (student_name.isEmpty || student_name=='all')&& ( (AppCubit.date.isEmpty))&&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty))
    {
      setState(() {
        flg=false;
      });
      return;
    }
    else if(!(text.isEmpty || text=='all') && (student_name.isEmpty || student_name=='all')&& AppCubit.date.isNotEmpty &&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(element.notificationsType.toString().contains(text) &&((dt1.isAtSameMomentAs(AppCubit.fromDate) || dt1.isAtSameMomentAs(AppCubit.fromTo))||((dt1.isBefore(AppCubit.fromTo) && dt1.isAfter(AppCubit.fromDate)))) )
        {
          list_Notfi_Search.add(element);
        }
      });}
    else if(!(text.isEmpty || text=='all') && (student_name.isEmpty || student_name=='all')&& AppCubit.date.isNotEmpty &&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());

        if(AppCubit.stutes_notif=='Read') {

          if(!element.notificationsRead.toString().contains("UnRead") && element.notificationsType.toString().contains(text) &&((dt1.isAtSameMomentAs(AppCubit.fromDate) || dt1.isAtSameMomentAs(AppCubit.fromTo))||((dt1.isBefore(AppCubit.fromTo) && dt1.isAfter(AppCubit.fromDate)))) )
          {
            list_Notfi_Search.add(element);
          }
        }
        else{

          if(element.notificationsRead.toString().contains("UnRead") && element.notificationsType.toString().contains(text) &&((dt1.isAtSameMomentAs(AppCubit.fromDate) || dt1.isAtSameMomentAs(AppCubit.fromTo))||((dt1.isBefore(AppCubit.fromTo) && dt1.isAfter(AppCubit.fromDate)))) )
          {
            list_Notfi_Search.add(element);
          }
        }
      });}
    else if(!(text.isEmpty || text=='all') && (student_name.isEmpty || student_name=='all')&& AppCubit.date.isEmpty&&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){
      AppCubit.list_notif.forEach((element) {

        if(element.notificationsType.toString().contains(text) )
        {
          list_Notfi_Search.add(element);
        }
      });}
    else if(!(text.isEmpty || text=='all') && (student_name.isEmpty || student_name=='all')&& AppCubit.date.isEmpty&&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){

      AppCubit.list_notif.forEach((element) {
        if(AppCubit.stutes_notif=='Read') {
          if (element.notificationsType.toString().contains(text) &&
              element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
        else{
          if (element.notificationsType.toString().contains(text) &&
              !element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
      });}
    else if((text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all')&& AppCubit.date.isNotEmpty&&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(element.studentName.toString().contains(student_name)&&((dt1.isAtSameMomentAs(AppCubit.fromDate) || dt1.isAtSameMomentAs(AppCubit.fromTo))||((dt1.isBefore(AppCubit.fromTo) && dt1.isAfter(AppCubit.fromDate)))) )
        {
          list_Notfi_Search.add(element);
        }
      });}
    else if((text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all')&& AppCubit.date.isNotEmpty&&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(AppCubit.stutes_notif=='Read') {

          if (element.studentName.toString().contains(student_name) &&
              element.notificationsRead.toString().contains("UnRead") &&
              ((dt1.isAtSameMomentAs(AppCubit.fromDate) ||
                  dt1.isAtSameMomentAs(AppCubit.fromTo)) ||
                  ((dt1.isBefore(AppCubit.fromTo) &&
                      dt1.isAfter(AppCubit.fromDate))))) {
            list_Notfi_Search.add(element);
          }
          else
          {
            if (element.studentName.toString().contains(student_name) &&
                !element.notificationsRead.toString().contains("UnRead") &&
                ((dt1.isAtSameMomentAs(AppCubit.fromDate) ||
                    dt1.isAtSameMomentAs(AppCubit.fromTo)) ||
                    ((dt1.isBefore(AppCubit.fromTo) &&
                        dt1.isAfter(AppCubit.fromDate))))) {
              list_Notfi_Search.add(element);
            }
          }
        }
      });}
    else if((text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all')&& AppCubit.date.isEmpty &&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        if(element.studentName.toString().contains(student_name))
        {
          list_Notfi_Search.add(element);
        }
      });}
    else if((text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all')&& AppCubit.date.isEmpty &&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(AppCubit.stutes_notif=='Read') {
          if (element.studentName.toString().contains(student_name)&&
              element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
        else
        {
          if (element.studentName.toString().contains(student_name)&&
              !element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
      });}
    else if(!(text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all') && AppCubit.date.isNotEmpty &&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){
      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(element.studentName.toString().contains(student_name) && element.notificationsType.toString().contains(text) &&((dt1.isAtSameMomentAs(AppCubit.fromDate) || dt1.isAtSameMomentAs(AppCubit.fromTo))||((dt1.isBefore(AppCubit.fromTo) && dt1.isAfter(AppCubit.fromDate)))) )
        {
          list_Notfi_Search.add(element);
        }
      });}
    else if(!(text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all') && AppCubit.date.isEmpty&&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){
      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        if(element.studentName.toString().contains(student_name) && element.notificationsType.toString().contains(text) )
        {
          list_Notfi_Search.add(element);
        }
      });}
    else if(!(text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all') && AppCubit.date.isEmpty&&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        if(AppCubit.stutes_notif=='Read') {
          if (element.studentName.toString().contains(student_name) &&
              element.notificationsType.toString().contains(text)&& element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
        else
        {
          if (element.studentName.toString().contains(student_name) &&
              element.notificationsType.toString().contains(text) && !element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
      });}
    else if((student_name.isEmpty || student_name=='all') &&(text.isEmpty || text=='all') && AppCubit.date.isNotEmpty&&(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if((dt1.isAtSameMomentAs(AppCubit.fromDate) || dt1.isAtSameMomentAs(AppCubit.fromTo))||((dt1.isBefore(AppCubit.fromTo) && dt1.isAfter(AppCubit.fromDate))))
        {
          list_Notfi_Search.add(element);
        }
      });
    }
    else if((student_name.isEmpty || student_name=='all') &&(text.isEmpty || text=='all') && AppCubit.date.isNotEmpty&&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){

      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(AppCubit.stutes_notif=='Read') {
          if ((dt1.isAtSameMomentAs(AppCubit.fromDate) ||
              dt1.isAtSameMomentAs(AppCubit.fromTo)) ||
              ((dt1.isBefore(AppCubit.fromTo) &&
                  dt1.isAfter(AppCubit.fromDate)))&&
                  element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
        else{
          if ((dt1.isAtSameMomentAs(AppCubit.fromDate) ||
              dt1.isAtSameMomentAs(AppCubit.fromTo)) ||
              ((dt1.isBefore(AppCubit.fromTo) &&
                  dt1.isAfter(AppCubit.fromDate)))&&
                  !element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
      });
    }
    else if(!(text.isEmpty || text=='all') && !(student_name.isEmpty || student_name=='all') && AppCubit.date.isNotEmpty && !(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty) ){

      AppCubit.list_notif.forEach((element) {
        //DateFormat('yyyy:MM-dd').format(DateTime.parse(element.dateTime.toString()))
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(AppCubit.stutes_notif=='Read') {
          if (element.notificationsRead.toString().contains("UnRead") && element.studentName.toString().contains(student_name) &&
              element.notificationsType.toString().contains(text) &&
              ((dt1.isAtSameMomentAs(AppCubit.fromDate) ||
                  dt1.isAtSameMomentAs(AppCubit.fromTo)) ||
                  ((dt1.isBefore(AppCubit.fromTo) &&
                      dt1.isAfter(AppCubit.fromDate))))) {
            list_Notfi_Search.add(element);
          }
        }
        else
        {
          if (!element.notificationsRead.toString().contains("UnRead") && element.studentName.toString().contains(student_name) &&
              element.notificationsType.toString().contains(text) &&
              ((dt1.isAtSameMomentAs(AppCubit.fromDate) ||
                  dt1.isAtSameMomentAs(AppCubit.fromTo)) ||
                  ((dt1.isBefore(AppCubit.fromTo) &&
                      dt1.isAfter(AppCubit.fromDate))))) {
            list_Notfi_Search.add(element);
          }
        }
      });}
    else if((student_name.isEmpty || student_name=='all') &&(text.isEmpty || text=='all') && AppCubit.date.isEmpty&&!(AppCubit.stutes_notif=='all'|| AppCubit.stutes_notif.isEmpty)){


      AppCubit.list_notif.forEach((element) {
        DateTime dt1=DateTime.parse(element.dateTime.toString());
        String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.dateTime.toString()))+" 00:00:00";
        dt1=DateTime.parse(x.toString());
        if(AppCubit.stutes_notif=='Read') {

          if (element.notificationsRead.toString().contains("UnRead")) {
            list_Notfi_Search.add(element);
          }
        }
        else{

          if (!element.notificationsRead.toString().contains("UnRead")) {

            list_Notfi_Search.add(element);
          }
        }
      });
    }

    setState(() {

      flg=true;
    });
  }
  void shwoDialog()async
  {
    get_notif("","");
    setState(() {
      isLoading=true;
    });
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
      // else if(CacheHelper.getBoolean(key: 'pickup').toLowerCase().contains("weekly")){
      //   AppCubit.back_home=true;
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AllWeeklyPlans( std_id: CacheHelper.getBoolean(key: 'std_id')),
      //       ));
      //   showDialog(
      //
      //       context: context,
      //       builder: (context) => dialog(
      //         title:
      //         Column(
      //           children: [
      //
      //             Expanded(
      //               child:
      //               Text(
      //                 title,
      //                 style: TextStyle(
      //                   color: Colors.blue,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //
      //         massage: 'mass',
      //       ));
      //
      // }
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
    get_notif("","");
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
  final List<String> studentItems = [
    CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'الكل':'All',
  ];
  String? selectedValue;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading=true;
    });
    filter.clear();

    if(AppCubit.stutes_notif=='Unread'){
      filter.add({"name":"Unread"});
    }
    if(AppCubit.stutes_notif=='Read'){
      filter.add({"name":"Read"});
    }
    if(AppCubit.stutes_notif=='all'){
      filter.add({"name":"All"});
    }

    if(AppCubit.date.toString().isNotEmpty){

      filter.add({"name":AppCubit.date});
    }
    if(AppCubit.student_name.isNotEmpty) {

      // print(AppCubit.selectedValue);
      // if(AppCubit.selectedValue.isNotEmpty){
      //   selectedValue = AppCubit.selectedValue;
      // }
      try{
        selectedValue = AppCubit.selectedValue;
      }
      catch(e)
      {
        // print('AppCubit.selectedValuewwww');
      }

      student_name = AppCubit.student_name;
      onSearchTextChanged('', student_name);
    }
    else {
      onSearchTextChanged('', '');
    }
    if(AppCubit.list_st.length>0)
    { setState(() {
      isLoading=false;
      list_notif=AppCubit.list_notif;
    });
      // list_notif=AppCubit.list_notif;
    }
    else
    {

      get_notif("","");
    }

    for(int i=0 ; i< AppCubit.list_st.length;i++)
    {
      studentItems.add(AppCubit.list_st[i].fname.toString());
    }
    controller.addListener(() {
      if(controller.position.maxScrollExtent==controller.offset)
      {
// print("asddsaf"+controller.position.toString());
        fetch();
      }

    });
    try {
      if (CacheHelper.getBoolean(key: 'full_system')) {
        list_filter = list_filter;
        show = true;
      }
      else if (CacheHelper.getBoolean(key: 'tracking_system')) {
        list_filter = list_filter_tracking;
        show = false;
      }
      else {
        show = true;
        list_filter = list_filter_sm;
      }
    }
    catch (e)
    {
      list_filter = list_filter;
      show = true;
    }

    // Timer timer = new Timer(new Duration(seconds: 1), () {    for(int i=0;i<AppCubit.list_st.length;i++)
    // {
    //   if(CacheHelper.getBoolean(key: 'pickup').toString()=='true')
    //   {
    //
    //     if(CacheHelper.getBoolean(key: 'pickup'+AppCubit.list_st[i].id.toString())!=null && CacheHelper.getBoolean(key: 'pickup'+AppCubit.list_st[i].id.toString()).toString().isNotEmpty)
    //     {
    //       shwoDialogPick(AppCubit.list_st[i].id.toString(),AppCubit.list_st[i].name.toString());
    //     }
    //   }
    // }});
    setState(() {

    });
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }
  Future fetch() async{
    // print(list_notif[list_notif.length-1].createdateTime.toString());
    // get_notif(list_notif[list_notif.length-1].createdateTime.toString(),'' );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();

    WidgetsBinding.instance!.removeObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state.toString().toLowerCase().contains("resumed"))
    {
      setState(() {
        isLoading=true;
      });
      AppCubit.get(context).getChildren();
      get_notif('','');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

          // shwoDialog();

        },
        builder: (context, state) {



          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            setState(() {
print("------------t-t-tt-t-t-");
              i++;

              if(event.data.isNotEmpty){
                if(mass.isEmpty || mass!=event.notification!.body.toString()){

                  if(event.data['picked'].toString()=='True') {
                    student_id = event.data['student_id'];
                    Picked = event.data['Picked'].toString();

                    CacheHelper.saveData(
                        key: 'pickup', value: event.data['picked'].toString());
                    CacheHelper.saveData(
                        key: 'pickup' + event.data['student_id'],
                        value: event.data['picked'].toString());


                    // CacheHelper.saveData(
                    //     key: 'pickup', value: event.data['picked'].toString());
                    // CacheHelper.saveData(
                    //     key: 'std_id', value:event.data['student_id']);

                    AppCubit.get(context).getChildren();
                    title = event.notification!.title.toString();
                    mass = event.notification!.body.toString();
                    shwoDialog();
                  }
                  else
                  {
                    String notificationsType=event.data['model_name'].toString();
                    String student_id=event.data['student_id'].toString();
                    String student_name=event.data['student_name'].toString();
                    AppCubit.std=student_id;
                    if(notificationsType.toLowerCase().contains("clinic"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Clinic_new( std_id:student_id),
                        ));
                    }
                    else if(notificationsType.toLowerCase().contains("assignment"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Assignments( std_id: student_id),
                        ));
                    }
                    else if(notificationsType.toLowerCase().contains("absence"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Absence(std_id: student_id,std_name: student_name,)));
                    }
                    else if(notificationsType.toLowerCase().contains("timeT"))
                    {

                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Time_Table_Form(std_id: student_id)));
                    }
                    else if(notificationsType.toLowerCase().contains("weekly"))
                    {AppCubit.back_home=true;
                    String plan_name=event.data['plan_name'].toString();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeeklyPlans(plan_id: event.data['action'].toString(),plan_name: plan_name,std_id: student_id)),
                    );
                    }

                    else if(notificationsType.toLowerCase().contains("meeting"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Calendar( std_id: student_id),
                        ));
                    }
                    else if( notificationsType.toLowerCase().contains("homework"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormWorksheets(std_id:event.data['action'].toString())),);


                    }
                    else if(notificationsType.toLowerCase().contains("event"))
                    {

                      AppCubit.back_home=true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormEvents_new(std_id: event.data['action'].toString())),);


                    }
                    else if(notificationsType.toLowerCase().contains("exam"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Exams( std_id: student_id),
                          ));
                    }
                    else if(notificationsType.toLowerCase().contains("badge"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => New_Badges(std_id: student_id,std_name:  student_name,),
                        ));
                    }
                    else if(notificationsType.toLowerCase().contains("mark"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => All_mark( std_id: student_id,image:"" ,),
                          ));
                    }
                    else if(event.data['model_name'].toString()=='Chat') {
                      CacheHelper.saveData(key: 'new_chat'+student_id, value: true);

                    }
                  }
                }

              }else
              {
                Picked="";
              }






            });

          });

          FirebaseMessaging.onMessage.listen((event) {

            print("------------t-t-tt-t-qwewqewqt-");
            setState(() {
              i++;

              if(event.data.isNotEmpty){
                if(event.data['picked'].toString()=='True') {
                  student_id = event.data['student_id'];
                  Picked = event.data['Picked'].toString();
                  CacheHelper.saveData(
                      key: 'pickup', value: event.data['picked'].toString());
                  CacheHelper.saveData(key: 'pickup' + event.data['student_id'],
                      value: event.data['picked'].toString());
                }
                else
                  {

                    String notificationsType=event.data['model_name'].toString();
                    String student_id=event.data['student_id'].toString();
                    String student_name=event.data['student_name'].toString();
                    AppCubit.std=student_id;
                    if(notificationsType.toLowerCase().contains("clinic"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Clinic_new( std_id:student_id),
                        ));
                    }
                    else if(notificationsType.toLowerCase().contains("assignment"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Assignments( std_id: student_id),
                        ));
                    }
                    else if(notificationsType.toLowerCase().contains("absence"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Absence(std_id: student_id,std_name: student_name,)));
                    }
                    else if(notificationsType.toLowerCase().contains("timeT"))
                    {

                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Time_Table_Form(std_id: student_id)));
                    }
                    else if(notificationsType.toLowerCase().contains("event"))
                    {

                      AppCubit.back_home=true;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormEvents_new(std_id: event.data['action'].toString())),);


                    }
                    else if( notificationsType.toLowerCase().contains("homework"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FormWorksheets(std_id:event.data['action'].toString())),);


                    }
                    else if(notificationsType.toLowerCase().contains("weekly"))
                    {AppCubit.back_home=true;
                    String plan_name=event.data['plan_name'].toString();

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeeklyPlans(plan_id: event.data['action'].toString(),plan_name: plan_name,std_id: student_id)),
                    );
                    }
                    else if(notificationsType.toLowerCase().contains("exam"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Exams( std_id: student_id),
                          ));
                    }
                    else if(notificationsType.toLowerCase().contains("badge"))
                    {AppCubit.back_home=true;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => New_Badges(std_id: student_id,std_name:  student_name,),
                        ));
                    }
                    else if(notificationsType.toLowerCase().contains("mark"))
                    {
                      AppCubit.back_home=true;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => All_mark( std_id: student_id,image:"" ,),
                          ));
                    }
                    else if(event.data['model_name'].toString()=='Chat') {
                      CacheHelper.saveData(key: 'new_chat'+student_id, value: true);


                    }

                  }
              }
              else
              {
                Picked="";
              }
              if(mass.isEmpty || mass!=event.notification!.body.toString()){
                AppCubit.get(context).getChildren();
                title=event.notification!.title.toString();
                mass= event.notification!.body.toString();
                String notificationsType=event.data['model_name'].toString();
                if(!notificationsType.toLowerCase().contains("chat")) {
                  shwoDialog();
                }
              }

            });
          });
          return
            WillPopScope(
                onWillPop: () async {
                  SystemNavigator.pop();
                  return false;
                },
                child:
                UpgradeAlert(
                  upgrader: Upgrader(
                      shouldPopScope: () => true,
                      canDismissDialog: true,
                      durationUntilAlertAgain: Duration(days: 1),
                      dialogStyle:Platform.isIOS? UpgradeDialogStyle.cupertino:UpgradeDialogStyle.material

                  ),
                  child: Scaffold(
                    bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home6.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9), Color(0xff3c92d0), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),



                    backgroundColor: Color(0xfff5f7fb),
                    //end navigation bar
                    body:  SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(

                          children: <Widget>[


                            Container(color: Colors.white,
                                alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.topRight:Alignment.topLeft,
                                padding: EdgeInsets.only(left: 30,top: 0,right: 30),
                                child: Image(image: AssetImage(AppCubit.trackware_school),width:  MediaQuery.of(context).size.width/6,height: MediaQuery.of(context).size.height/6,)),
                            Container(
                              color: Colors.white,

                              height: 30.w,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: AppCubit.list_st.length ,
                                itemBuilder: (context, index) {
                                  return student_list(index, AppCubit.list_st[index]);
                                },
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:10,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?10: 0),

                                width: double.infinity,
                                // height: 200,
                                color: Color(0xfff5f7fb),
                                child:Column(children: [
                                  Padding(

                                    padding: const EdgeInsets.only(top: 10),
                                    child: Row(children: [
                                      Expanded(child: Padding(
                                        padding: EdgeInsets.only(left: 12,right: 12),
                                        child: Text(
                                          AppLocalizations.of(context).translate('news_feeds')

                                          ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight:FontWeight.w500),),
                                      )),
                                      // Text("Student: ",style: TextStyle(fontSize: 13,fontWeight: FontWeight.normal),),
                                      DropdownButton2(
                                        dropdownWidth: 30.w,


                                        alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                                        hint:  Text(
                                            AppLocalizations.of(context).translate('all')

                                            ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                                        value: selectedValue,
                                        icon: Icon(Icons.keyboard_arrow_down_outlined),
                                        isDense: true,
                                        underline: Container(color: Colors.white),
                                        items: studentItems.map((e){
                                          return DropdownMenuItem(
                                              value: e,
                                              child: Text(e));
                                        }).toList(), onChanged: (value) {
                                        setState(() {
                                          selectedValue=value.toString();
                                          AppCubit.selectedValue=selectedValue.toString();
                                          student_name=selectedValue.toString();
                                          AppCubit.student_name=student_name;
                                          // print(AppCubit.student_name);
                                          if(student_name==AppLocalizations.of(context).translate('all'))
                                          {AppCubit.student_name="All";
                                          // print(AppCubit.student_name);
                                          setState(() {
                                            student_name='';
                                          });
                                          }
                                          for(int i=0;i<list_filter.length;i++)
                                          {
                                            if(list_filter[i]['sta']){
                                              onSearchTextChanged(list_filter[i]['name'],student_name);
                                              break;
                                            }
                                          }
                                        });


                                      },),



                                      Container(margin: EdgeInsets.only(right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 15,left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?15:0 ),
                                        child: IconButton(onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Filter(),
                                              ));

                                        }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,) ,color:  Color(0xff98aac9),),
                                      )
                                    ]),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  //   child: Container(
                                  //     alignment: Alignment.center,
                                  //     // padding: EdgeInsets.only(left: MediaQuery.of(context).size.height/50,top: 10),
                                  //     height: 13.5.w,
                                  //
                                  //
                                  //     child: ListView.builder(
                                  //       scrollDirection: Axis.horizontal,
                                  //       itemCount:list_filter.length ,
                                  //       itemBuilder: (context, index) {
                                  //         return filter_list(index);
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  Container(

                                    // alignment: Alignment.center,
                                    // padding: EdgeInsets.only(left: MediaQuery.of(context).size.height/50,top: 10),
                                    height: 15.w,
// color: Colors.yellowAccent,

                                    child: NotificationListener (
                                      onNotification:    (notification) {

                                        return true;
                                      },
                                      child: ListView.builder(

                                        scrollDirection: Axis.horizontal,
                                        itemCount:list_filter.length ,
                                        itemBuilder: (context, index) {
                                          return filter_list(index);
                                        },
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                      visible: filter.length>0,
                                      child:  Container(
                                        padding: EdgeInsets.only(left:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: MediaQuery.of(context).size.height/35,top: MediaQuery.of(context).size.height/30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? MediaQuery.of(context).size.height/35:0),
                                        height: MediaQuery.of(context).size.height/16,
                                        child: ListView.builder(

                                          scrollDirection: Axis.horizontal,
                                          itemCount:filter.length ,
                                          itemBuilder: (context, index) {

                                            return data_to_filter(index);
                                          },
                                        ),
                                      ))



                                ],)


                            ),
                            Expanded(
                              child: isLoading?
                              Center(child: CircularProgressIndicator()):Container(
                                color: Color(0xfff5f7fb),
                                child: ListView.builder(
                                  controller: controller,
                                  itemCount:list_Notfi_Search.length!=0 && flg?list_Notfi_Search.length+1:
                                  list_Notfi_Search.length!=0 || flg?0:list_notif.length+1,
                                  itemBuilder: (context, index) =>list_Notfi_Search.length!=0 ||flg? index<list_Notfi_Search.length?design_notif( list_Notfi_Search[index] ):SizedBox(height: 200,):index<list_notif.length?design_notif(list_notif[index]):SizedBox(height: 200,),
                                  // itemBuilder: (ctx,inte){
                                  //   // int length=0;
                                  //   // if(list_Notfi_Search.length!=0 ||flg)
                                  //   //   {
                                  //   //     length=list_Notfi_Search.length!;
                                  //   //   }
                                  //   // else
                                  //   //   {
                                  //   //     length=list_notif.length!;
                                  //   //   }
                                  //   //
                                  //   // if(length==inte)
                                  //   //   {
                                  //   //     return Container(height: 100);
                                  //   //   }
                                  //
                                  //   return design_notif(list_Notfi_Search.length!=0 ||flg?list_Notfi_Search[inte]:list_notif[inte]);
                                  // },
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ));
        },
      ),

    );

  }
  Widget student_list(int ind,Students listDetail1)
  {



    List<Features> listFeatures1=[];
    return Padding(
      padding: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:8,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?8:0),
      child: InkWell(

        onTap: () {
          if (! show){

          }
          else {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

            listFeatures1.clear();

            AppCubit.school_image = listDetail1.schoolImage.toString();

            // if(listDetail1.changeLocation=true)
            // {
            //
            //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon_svg: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
            //
            // }
            // if(listDetail1.showAbsence==true)
            // {
            //   listFeatures1.add( Features(name: AppLocalizations.of(context).translate('absent'), icon: 'https://www.realmadrid.com/StaticFiles/RealMadridResponsive/images/static/og-image.png',nameAr: AppLocalizations.of(context).translate('absent')));
            // }
            listDetail1.features!.forEach((element) {
              listFeatures1.add(element);
            });
            AppCubit.sessionId = listDetail1.sessionId!;
            AppCubit.get(context).setDetalil(
                listDetail1.name,
                listDetail1.studentGrade ?? "",
                listDetail1.schoolName,
                listDetail1.avatar,
                listDetail1.id.toString(),
                listDetail1.schoolLat,
                listDetail1.schoolId.toString(),
                listDetail1.schoolLng,
                listDetail1.pickupRequestDistance.toString(),
                listFeatures1);

            if(listDetail1.new_chat !=null) {
              CacheHelper.saveData(key: 'new_chat' + listDetail1.id.toString(),
                  value: listDetail1.new_chat);
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => New_Detail()),
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            margin:  EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:10,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?10:0),

            child: Column(

                children: [


                  Card(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60.0))),
                    elevation: 4.0,
                    child: Container(
                      height:16.w ,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent ,

                        maxRadius:MediaQuery.of(context).size.width/12 ,



                        backgroundImage: NetworkImage('${listDetail1.avatar}', ),

                      ),
                    ),
                  ),
                  SizedBox(height: 8,),

                  Text("${listDetail1.fname}",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 9.sp),),
                ]),
          ),
        ),
      ),

    );
  }
  Widget filter_list(int ind)
  {



    CircleAvatar test;
    if(list_filter[ind]['name']=='all')
    { if(!list_filter[ind]['sta']){

      test= CircleAvatar(
        backgroundColor: Colors.white,
        child: Text( AppLocalizations.of(context).translate('all'),style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize:4.w) ,),

      );
    }
    else{
      test= CircleAvatar(
        backgroundColor: list_filter[ind]['color'],
        child: Text(AppLocalizations.of(context).translate('all'),style:TextStyle(color: Colors.white,fontSize: 4.w)),

      );}
    }
    else
    {
      if(!list_filter[ind]['sta']){

        test=CircleAvatar(
          backgroundColor: Colors.white,
          child:SvgPicture.asset(
            list_filter[ind]['image'],color:list_filter[ind]['color'] ,width: 6.w,),



        );
      }
      else{
        test=CircleAvatar(
            backgroundColor: list_filter[ind]['color'],
            child: SvgPicture.asset(
                list_filter[ind]['image_c'],color:Colors.white,width: 6.w)


        );}

    }

    return InkWell(

      onTap: () {
        setState(() {
          list_filter[ind]['sta']=true;
          for(int i=0;i<list_filter.length;i++)
          {
            if(ind!=i)
            {
              list_filter[i]['sta']=false;
            }
          }
          if(student_name=='All')
          {
            setState(() {
              student_name='';
            });
          }
          onSearchTextChanged(list_filter[ind]['name'],student_name);
        });

      },
      child:Padding(

        padding:EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:9,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?9:0),
        child:  Container(
          width: 15.w,
          height:15.w,
          // color: Colors.red,
          child: Card(

            shape: const RoundedRectangleBorder(
                side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            elevation: 0.0,
            child: Container(
// color: Colors.blue,
              // width:60 ,
              child: test,
            ),
          ),
        ),
      ),

      // Container(
      //
      //   margin:EdgeInsets.only(left: 16),
      //
      //   decoration: BoxDecoration(
      //     borderRadius: new BorderRadius.circular(50.0),
      //     color: Color(0xffbbc7db),
      //
      //
      //
      //   ),
      //   child: Column(
      //     // mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //
      //
      //         Card(
      //           // margin:EdgeInsets.only(left: 16),
      //
      //
      //           shape: const RoundedRectangleBorder(
      //             side: BorderSide(width: 1,color: Color(0xffbbc7db)),
      //               borderRadius: BorderRadius.all(Radius.circular(50.0))),
      //           elevation: 0.0,
      //           child: Container(
      //             width: 10.w,
      //             height: 10.w,
      //             child: test,
      //           ),
      //         ),
      //
      //
      //       ]),
      // ),


    );
  }
  Widget design_list(String date,String studentName,String notificationsText ,String image, Color color,String notificationsType,String student_id,String icon, String read, String id,String actionId,Notifications notifications,String studentImage,List<Attachments> data)
  {
    RichText richText;
    richText=RichText(
        text: TextSpan(
          children:inlineSpanText(notificationsText,context),));
    bool vas_drop=true;
    if (notifications.notificationsType.toString()=='tracking'){
      vas_drop=false;
    }
    if (read.contains('UnRead'))
    {
      read= AppLocalizations.of(context).translate('Mark_UnRead');
    }
    else
    {
      read= AppLocalizations.of(context).translate('Mark_Read');
    }
    return InkWell(
      onTap: () async {
        AppCubit.std=student_id;
        AppCubit.image=studentImage;
        if(notificationsType.toLowerCase().contains("clinic"))
        {AppCubit.back_home=true;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Clinic_new( std_id:student_id),
            ));
        }
        else if(notificationsType.toLowerCase().contains("assignment"))
        {AppCubit.back_home=true;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Assignments( std_id: student_id),
            ));
        }
        else if(notificationsType.toLowerCase().contains("absence"))
        {
          AppCubit.back_home=true;
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Absence(std_id: student_id,std_name: student_name,)));
        }
        else if(notificationsType.toLowerCase().contains("timeT"))
        {

          AppCubit.back_home=true;
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Time_Table_Form(std_id: student_id)));
        }
        else if(notificationsType.toLowerCase().contains("weekly"))
        {AppCubit.back_home=true;
        String plan_name=notificationsText;
        if(notifications.plan_name!.isNotEmpty){
          plan_name=notifications.plan_name!;

        }
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeeklyPlans(plan_id: actionId,plan_name: plan_name,std_id: student_id)),
        );

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => AllWeeklyPlans( std_id: student_id),
          //     ));
        }
        else if(notificationsType.toLowerCase().contains("meeting"))
        {AppCubit.back_home=true;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Calendar( std_id: student_id),
            ));
        }
        else if( notificationsType.toLowerCase().contains("homework"))
        {
          AppCubit.back_home=true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormWorksheets(std_id:actionId)),);


        }
        else if(notificationsType.toLowerCase().contains("event"))
        {

          AppCubit.back_home=true;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormEvents_new(std_id: actionId)),);


        }
        else if(notificationsType.toLowerCase().contains("exam"))
        {
          AppCubit.back_home=true;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Exams( std_id: student_id),
              ));
        }
        else if(notificationsType.toLowerCase().contains("badge"))
        {         AppCubit.back_home=true;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => New_Badges(std_id: student_id,std_name:  student_name,),
            ));
        }

        else if(notificationsType.toLowerCase().contains("mark"))
        {
          AppCubit.back_home=true;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => All_mark( std_id: student_id,image:"" ,),
              ));
        }
        else if(notificationsType.toLowerCase().contains("survey"))
        {


          var url=Uri.parse( icon.toString());

          await launchUrl(url,webViewConfiguration: WebViewConfiguration(headers: {
            "X-Openerp-Session-Id":
            CacheHelper.getBoolean(key: 'sessionId')
          } ));
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DataMasseg(studentName,notificationsText, date, notificationsType, data)),
          );
        }
      //   mark_yousef
      },
      child: SizedBox(
        width: double.infinity,
        child: Stack(children: <Widget>[
          Stack(
            alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.topRight:Alignment.topLeft,
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.only(top: 50 / 2.0,bottom: 15 ),  ///here we create space for the circle avatar to get ut of the box
                child: Container(
                  // height: 300.0,
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xffd4e9f8),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black26,
                    //     blurRadius: 8.0,
                    //     offset: Offset(0.0, 5.0),
                    //   ),
                    // ],
                  ),
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 0),
                      child: Column(
                        children: <Widget>[


                          Padding(
                            padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(date, style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12.0),),
                                const SizedBox(width: 8),
                                Visibility(
                                  visible: vas_drop,
                                  child: PopupMenuButton(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    child:const Icon(Icons.more_vert,size: 20,color: Color(0xff98aac9)) ,itemBuilder: (context) => [

                                      PopupMenuItem(child:
                                      Container(
                                        // alignment: Alignment.topLeft,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                                onTap: () async {
                                                  Map data={};
                                                  data['message_id']=id;
                                                  if(notificationsType.contains("survey")){
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                          child: CircularProgressIndicator(),
                                                        );
                                                      },
                                                    );
                                                    await DioHelper.uplodeData(
                                                        url: Hide_survey,
                                                        data: data,
                                                        token: CacheHelper.getBoolean(key: 'authorization'))
                                                        .then((value) {
                                                      AppCubit()..getChildren();
                                                      Future.delayed(Duration(seconds: 4),() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>Hiome_Kids() ),
                                                        );

                                                      },);




                                                    },).catchError((onError) {
                                                      // print(onError);
                                                    });
                                                  }
                                                  else{
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                          child: const CircularProgressIndicator(),
                                                        );
                                                      },
                                                    );
                                                    await DioHelper.uplodeData(
                                                        url: Hide_message,
                                                        data: data,
                                                        token: CacheHelper.getBoolean(key: 'authorization'))
                                                        .then((value) {
                                                      AppCubit()..getChildren();
                                                      Future.delayed(Duration(seconds: 4),() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>Hiome_Kids() ),
                                                        );

                                                      },);




                                                    },).catchError((onError) {
                                                      // print(onError);
                                                    });}
                                                },

                                                child: Text( AppLocalizations.of(context).translate('Hide_Feeds'),style: TextStyle(color:Color(0xffe84314),fontSize: 17,fontWeight: FontWeight.w600, ),)),
                                            SizedBox(height: 10,),
                                            InkWell(
                                                onTap: () async {

                                                  Map data={};
                                                  data['message_id']=id;
                                                  if(notificationsType.contains("survey")){
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                          child: const CircularProgressIndicator(),
                                                        );
                                                      },
                                                    );
                                                    await DioHelper.uplodeData(
                                                        url: Read_survey,
                                                        data: data,
                                                        token: CacheHelper.getBoolean(key: 'authorization'))
                                                        .then((value) {
                                                      AppCubit().getChildren();
                                                      Future.delayed(const Duration(seconds: 4),() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>Hiome_Kids() ),
                                                        );

                                                      },);




                                                    },).catchError((onError) {
                                                      // print(onError);
                                                    });
                                                  }else{
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return const Center(
                                                          child: const CircularProgressIndicator(),
                                                        );
                                                      },
                                                    );
                                                    await DioHelper.uplodeData(
                                                        url: Read_message,
                                                        data: data,
                                                        token: CacheHelper.getBoolean(key: 'authorization'))
                                                        .then((value) {
                                                      AppCubit().getChildren();
                                                      Future.delayed(const Duration(seconds: 4),() {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) =>const Hiome_Kids() ),
                                                        );

                                                      },);


                                                    },).catchError((onError) {
                                                      // print(onError);
                                                    });}
                                                },

                                                child: Container(
                                                  // color: Colors.red,

                                                    child: Text(read,style: const TextStyle(color:Color(0xff0000000),fontSize: 17,fontWeight: FontWeight.w600, ),))),
                                          ],
                                        ),
                                      ))
                                    ],),
                                )


                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0,top: 0,right: 24),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(  AppLocalizations.of(context).translate('for'), style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),),
                                Expanded(child: Text(studentName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0,color: Color(0xff3c92d0)),)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0,top: 8,right: 24,bottom: 24),
                            child:  Container(alignment:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.topRight:Alignment.topLeft,
                                // color: Colors.red,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible:icon.isNotEmpty,
                                      child:  Container(

                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Container(

                                            padding: EdgeInsets.all(6),
                                            height: 28,
                                            width: 28,
                                            decoration: BoxDecoration(

                                              shape: BoxShape.circle,
                                              color:!vas_drop?Color(0xfffff2cc):color.withOpacity(.2),

                                              border: Border.all(color: Color(0xffd4e9f8),width: 1),

                                            ),
                                            child: SvgPicture.network(icon,color:color,width: 18,), /// replace your image with the Icon
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Container(margin: EdgeInsets.only(top: 5),
                                        child: richText
                                        // Text(notificationsText, style: TextStyle( fontSize: 16.0,  color: Colors.black,fontWeight: FontWeight.w500),
                                        // )

                                    )),
                                  ],
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 24.0,top: 8,right: 24,),
                            child:  Container(alignment:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.topRight:Alignment.topLeft,
                              // color: Colors.red,
                              child:Visibility(visible: notifications.imageLink!.toString().isNotEmpty&&notifications.imageLink!.toString()!='null',
                                  child:
                                  Image(image: NetworkImage(notifications.imageLink!.toString()))
                              ),
                            ),
                          ),
                          Visibility(
                              visible: data?.length!=0,
                              child:    Padding(padding:  const EdgeInsets.only(left: 16,right: 16,bottom: 20),
                                //notifications
                                child:  Container(
                                  height: 20.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:data.length ,
                                    itemBuilder: (context, index) {

                                      return     Container(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                          child:Column(
                                            children: [
                                              data[index].datas.toString().contains('.png') || data[index].datas.toString().contains('.jpg')  || data[index].datas.toString().contains('.jpeg')?Image.network( data[index].datas.toString(),width: 15.w,height: 7.h,):  data[index].datas.toString().contains('.pdf')?
                                              SvgPicture.asset('images/pdf.svg',width: 13.w,): data[index].datas.toString().split('.').last=='mp4'?SvgPicture.asset('images/icons8_video_file.svg',width: 13.w,):data[index].datas.toString().split('.').last=='mp3'|| data[index].datas.toString().split('.').last=='mpeg'?Image.asset('images/speaker.png',width: 13.w ,):SvgPicture.asset('images/icons8_file.svg',width: 13.w,),
                                          Container(width: 10.w,  child: Text(data[index].name.toString(), overflow:  TextOverflow.ellipsis,))

                                            ],
                                          )
                                      )
                                      ;

                                    },
                                  ),
                                ),

                              ) ),


                        ],
                      )
                  ),
                ),
              ),

              // images/icons8_megaphone.svg

              ///Image Avatar
              Container(

                  margin: EdgeInsets.only(left: 0,right: 0),
                  width: 100,
                  height: 28,
                  // decoration: BoxDecoration(
                  //
                  //   shape: BoxShape.circle,
                  //   color:color,
                  //   border: Border.all(color: Color(0xffd4e9f8),width: 8),
                  //
                  // ),
                  child: SvgPicture.asset('images/rounded.svg',color:Color(0xffd4e9f8),width: 50,)
                // Padding(
                //   padding: EdgeInsets.all(0.0),
                //   child: Center(
                //     child: Container(
                //
                //       child: SvgPicture.asset('images/rounded.svg',color:Colors.white,width: 18,), /// replace your image with the Icon
                //     ),
                //   ),
                // ),
              ),
              Container(

                margin: EdgeInsets.only(left: 30,right: 35),
                width: 35,
                height: 50,
                decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  color:color,
                  // border: Border.all(color: Color(0xffd4e9f8),width: 8),

                ),
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Center(
                    child: Container(

                      child: SvgPicture.asset(image,color:Colors.white,width: 18,), /// replace your image with the Icon
                    ),
                  ),
                ),
              ),

            ],
          ),
        ]),
      ),
    );
  }
  Widget design_notif(Notifications notifications) {

    String date,studentName,notificationsText,image,notificationsTitle,studentId,iconTracking,notificationsRead,actionId,notificationsId,studentImage;
    Color color;
    studentName=notifications.studentName.toString();


    notificationsText=CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?notifications.notificationsTextAr.toString():notifications.notificationsText.toString();

    // print(notifications.notificationsTextAr.toString());
    notificationsTitle= CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? notifications.notificationsTitleAr.toString():notifications.notificationsTitle.toString();
    studentId=notifications.studentId.toString();
    iconTracking=notifications.iconTracking.toString();
    notificationsRead=notifications.notificationsRead.toString();
    actionId=notifications.actionId.toString();
    notificationsId=notifications.notificationsId.toString();
    image='images/icons8_open_book.svg';
    color=Color(0xff7cb13b);
    studentImage=notifications.studentImage.toString();
    // print(notifications.attachments);
    List<Attachments>? data=notifications.attachments;


    var notifications_date=  DateFormat('dd/MM/yyyy').format(DateTime.parse(notifications.dateTime.toString()));
    var current_date=DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString()));
    if (notifications_date==current_date)
    {
      date=DateFormat('h:mm a').format(DateTime.parse(notifications.dateTime.toString()));
    }
    else
    {
      date=notifications_date;
    }

    if (notifications.notificationsType=='educational')
    {
      image='images/icons8_open_book.svg';
      color=Color(0xff7cb13b);


    }
    else if (notifications.notificationsType=='Absence' )
    {

      image='images/icons8_note.svg';
      color=Color(0xffe84314);
    }
    else   if( notifications.notificationsType=='announcement')
    {
      image='images/icons8_megaphone.svg';
      color=Color(0xff3c92d0);

    }
    else {
      image='images/bus.svg';
      color=Color(0xfff88c0b);
    }

    return   design_list(date,studentName,notificationsText ,image, color, notificationsTitle, studentId,iconTracking,notificationsRead,notificationsId,actionId,notifications,studentImage,data!);
  }
  Widget data_to_filter(int ind)
  {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: SizedBox(
        height: 40,


        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
          child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(filter[ind]['name']),
                ),
                SizedBox(width: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: InkWell(onTap: () {
                    setState(() {
                      if( filter[ind]['name']=="Unread"){

                        AppCubit.unread=false;
                        AppCubit. stutes_notif='';
                      }
                      if(filter[ind]['name']=="Read"){
                        AppCubit.read=false;
                        AppCubit. stutes_notif='';
                      }
                      if(filter[ind]['name']=="All"){

                        AppCubit. stutes_notif='';
                      }
                      if(AppCubit.date.toString()==filter[ind]['name']){
                        AppCubit.date='';
                        AppCubit. stutes_notif='';

                      }
                      filter.removeAt(ind);
                      for(int i=0;i<list_filter.length;i++)
                      {
                        if(list_filter[i]['sta']){
                          onSearchTextChanged(list_filter[i]['name'],student_name);
                          break;
                        }
                      }


                    });


                  },child: Icon(Icons.dangerous,color: Colors.grey,size: 20,),),
                )


              ]),
        ),
      ),);
  }



}








