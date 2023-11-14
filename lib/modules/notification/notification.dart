import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/history.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';


import 'package:udemy_flutter/shared/components/widget.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class Notification_sc extends StatefulWidget {
  @override
  State<Notification_sc> createState() => _Notification_scState();
}

class _Notification_scState extends State<Notification_sc> {
  List<Notifications> list_notif=[];
  late Notification_api notification;
  final keyRefresh =GlobalKey<RefreshIndicatorState>();
  DateTime dateTime = DateTime.now();
  late DateTime fromDate;
  late DateTime fromTo;
  String textFrom = 'Date From';
  String textTo = 'Date To';


  void get () async
  {
    String start_date='2022-01-01 01:12:12';
    String end_date= DateTime.now().toString();

    // print(( AppLocalizations.of(context).translate('notifications')) );

    if((!textFrom.contains('Date From') && !textFrom.contains('التاريخ من')) && (!textTo.contains('Date To')&&!textTo.contains('التاريخ الى')))
    {
      start_date=fromDate.toString();
      end_date=fromTo.toString();
    }
    var responseKids=await DioHelper.postData(url:Kids_history , data:{

      "start_date": start_date,
      "end_date": end_date,

    },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {
      // print(value.data);
      notification=Notification_api.fromJson(value.data);

      setState(() {
        AppCubit.list_notif=notification.notifications;
      });


    },).catchError((onError){
      // print(onError);
      // print(end_date);
      // showDialog(context: context, builder:(context) => dialog(massage: 'massage', title: Image(image: AssetImage('images/img_error.png'))), );
      // showDialog(context: context, builder: (context) => dialog(massage: onError, title: Image(image: AssetImage('images/img_error.png')) ),);

    });


  }
  @override
  void initState() {
    // TODO: implement initState

    get();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            alignment: Alignment.center, child: Text(AppLocalizations.of(context).translate('notifications'))),
        actions: [IconButton(onPressed: () {

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ));}, icon: Icon(Icons.settings))],
      ),
      body:   Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                color: Colors.grey[300],
                height: 65,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {

                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2016),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() {
                            dateTime = newDate;
                            fromDate = newDate;
                            textFrom = newDate.year.toString() +
                                '-' +
                                newDate.month.toString() +
                                '-' +
                                newDate.day.toString();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Text(textFrom.contains('Date')?AppLocalizations.of(context).translate('date_from'):textFrom),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2016),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          setState(() {
                            fromTo = newDate;
                            textTo = newDate.year.toString() +
                                '-' +
                                newDate.month.toString() +
                                '-' +
                                newDate.day.toString();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          // padding: EdgeInsets.all(20),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Text(textTo.contains('Date')?AppLocalizations.of(context).translate('date_to'):textTo),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 0,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                          ),
                          onPressed: () {
                            get();
                          },
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child:
              ListView.separated(
                itemBuilder: (context, index) => notif(AppCubit.list_notif[index]),
                itemCount: AppCubit.list_notif.length,
                separatorBuilder: (context, index) {
                  return Container(
                      padding: EdgeInsetsDirectional.only(start: 60),
                      child: Divider(
                        color: Colors.black,
                      ));
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget notif(Notifications user) => InkWell(
    onTap: () => showDialog(
        context: context,
        builder: (context) => dialog(
          title:
          Column(
            children: [

              CircleAvatar(
                backgroundColor: Colors.transparent,
                maxRadius: 10,

                backgroundImage: NetworkImage('${user.avatar}'),
              ),

              Expanded(
                child:
                Text(CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?
                '${user.notificationsTitleAr}':'${user.notificationsTitle}',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          massage: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?user.notificationsTextAr.toString():user.notificationsText.toString(),
        )),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30,
          backgroundImage: NetworkImage('${user.avatar}'),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?
                  '${user.notificationsTitleAr}':'${user.notificationsTitle}',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text(CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?
                  '${user.notificationsTextAr}':'${user.notificationsText}',
                    style: TextStyle(color: Colors.red),overflow: TextOverflow.ellipsis,
                  ))
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsetsDirectional.only(end: 20),
            child:
            // Expanded (
            //   child:
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('${DateFormat('yyyy:MM-dd').format(DateTime.parse(user.dateTime.toString()))}'),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('${'at '+DateFormat('h:mm a').format(DateTime.parse(user.dateTime.toString()))}'),
                ),
              ],
            ),
            // ),
          ),
        ),
        Divider(
          color: Colors.black,
        )
      ],
    ),
  );
}
