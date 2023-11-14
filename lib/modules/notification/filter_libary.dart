
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/libary.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_allEvent.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_clinic.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';


class Filter_odoo_Libaray extends StatefulWidget {
  const Filter_odoo_Libaray({Key? key}) : super(key: key);

  @override
  State<Filter_odoo_Libaray> createState() => _Filter_odoo_LibarayState();
}


class _Filter_odoo_LibarayState extends State<Filter_odoo_Libaray> {
  String? _character = 'approve';
  TextEditingController user_name = TextEditingController();
  DateTime dateTime = DateTime.now();
  late DateTime fromDate;
  late DateTime fromTo;
  late DateTime fromDate1;
  late DateTime fromTo1;
  String textFrom = 'Date From';
  String textTo = 'Date To';
  bool isChecked = false;
  bool isChecked2 = false;

  @override
  void initState() {
    // TODO: implement initState
    if(AppCubit.stutes_notif_odoo.isNotEmpty)
    {
      //   if(AppCubit.date.isNotEmpty) {
      //   fromDate=AppCubit.fromDate_odoo;
      //   fromTo=AppCubit.fromTo_odoo;
      //   textFrom = fromDate.year.toString() +
      //       '-' +
      //       fromDate.month.toString() +
      //       '-' +
      //       fromDate.day.toString();
      //   textTo = fromTo.year.toString() +
      //       '-' +
      //       fromTo.month.toString() +
      //       '-' +
      //       fromTo.day.toString();
      // }

      // if(AppCubit.stutes_notif_odoo.isNotEmpty){

      _character=AppCubit.stutes_notif_odoo;

      // }
    }
    super.initState();
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
          double size=15;
          if(SizerUtil.deviceType ==DeviceType.tablet)
          {size=25;

          }

          return
            WillPopScope(
                onWillPop: () async {
                  // Navigator.pop(context);
                  return false;
                },
                child:
                Scaffold(
                  //navigation bar
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    // primary: false,
                    toolbarHeight: 20.w,
                    backgroundColor: Colors.white,
                    leadingWidth: 30.w,
                    leading: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Image(image: AssetImage('images/trackware_school.png'),width:  20.w,height: 15.w,)),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 30,top: 10,right: 30),
                        child: IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                      )
                    ],


                  ),
                  //end navigation bar
                  body:   SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // alignment: Alignment.topLeft,
                                padding: EdgeInsets.only(left: 30,top: 7.w,right: 30),
                                color: Colors.white,
                                height: 60,
                                child: Text(AppLocalizations.of(context).translate('Filter'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                              ),
                              Container(
                                // alignment: Alignment.topLeft,

                                margin:  EdgeInsets.only(left: 38.0,right: 30,top: 30),
                                child: Text(AppLocalizations.of(context).translate('Date'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 10,right: 10),
                              width: double.infinity,

                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Container(
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      width: double.infinity,

                                      height:   90,
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
                                                margin: EdgeInsets.only(left: 15,right: 15,top: 20,bottom: 15),

                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: .5),
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: Colors.white),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                child: Row(
                                                  children: [
                                                    Expanded(child: Container(

                                                        padding: const EdgeInsets.only(left: 30,right: 30),
                                                        child: Text(textFrom.contains('Date')?AppLocalizations.of(context).translate('date_from'):textFrom))
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0,right: 20),
                                                      child: SvgPicture.asset("images/calendar_11.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,),
                                                    )
                                                    //calendar_11.svg
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      )),
                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 10,right: 10),
                                      height:  90,
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
                                                  fromTo = newDate;
                                                  textTo = newDate.year.toString() +
                                                      '-' +
                                                      newDate.month.toString() +
                                                      '-' +
                                                      newDate.day.toString();
                                                });
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(left: 15,right: 15,bottom: 35),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(border: Border.all(color: Colors.grey,width: .5),
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: Colors.white),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                child: Row(
                                                  children: [
                                                    Expanded(child: Container(

                                                        padding: const EdgeInsets.only(left: 30,right: 30),
                                                        child: Text(textTo.contains('Date')?AppLocalizations.of(context).translate('date_to'):textTo))
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0,right: 20),
                                                      child: SvgPicture.asset("images/calendar_11.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,),
                                                    )
                                                    //calendar_11.svg
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      )),
                                  Visibility(
                                    visible: true,
                                    child: Padding(
                                      padding:  EdgeInsets.only(left: 30.0,right: 30,top: 0.w),
                                      child: Text(AppLocalizations.of(context).translate('Status'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                    ),
                                  ),
                                  Visibility(
                                    visible: !AppCubit.isBorrowd,
                                    child: Column(
                                      children: <Widget>[

                                        Container(
                                          height: 30,
                                          child: ListTile(

                                            title:  Text(AppLocalizations.of(context).translate('appr')),
                                            leading: Radio<String>(
                                              value: 'approve',
                                              groupValue: _character,
                                              onChanged: ( value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          child: ListTile(
                                            title:  Text(AppLocalizations.of(context).translate('Under_Approval')),
                                            leading: Radio<String>(
                                              value: 'under_approval',
                                              groupValue: _character,
                                              onChanged: ( value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          child: ListTile(
                                            title:  Text(AppLocalizations.of(context).translate('rejected')),
                                            leading: Radio<String>(
                                              value: 'cancel',
                                              groupValue: _character,
                                              onChanged: ( value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: AppCubit.isBorrowd,
                                    child: Column(
                                      children: <Widget>[


                                        Container(
                                          height: 30,
                                          child: ListTile(
                                            title:  Text(AppLocalizations.of(context).translate('Return')),
                                            leading: Radio<String>(
                                              value: 'done',
                                              groupValue: _character,
                                              onChanged: ( value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          child: ListTile(
                                            title:  Text(AppLocalizations.of(context).translate('Not_Return')),
                                            leading: Radio<String>(
                                              value: 'delivered',
                                              groupValue: _character,
                                              onChanged: ( value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ],)


                          ),
                          Container(
                            child: Column(children: [
                              SizedBox(height: size.h),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0,right: 2),
                                child: InkWell(
                                  onTap: () async {

                                    setState(() {

                                      if(textTo!='Date To' &&  textFrom != 'Date From'){if(fromDate!=null && fromTo!=null){
                                        AppCubit.fromDate_odoo=fromDate;
                                        AppCubit.fromTo_odoo=fromTo;

                                        AppCubit.date_odoo= fromDate.day.toString() +
                                            '-' +
                                            fromDate.month.toString() +
                                            '-' +
                                            fromDate.year.toString() +"-"+fromTo.day.toString() +
                                            '-' +
                                            fromTo.month.toString() +
                                            '-' +
                                            fromTo.year.toString();}}
                                      AppCubit.stutes_notif_odoo=_character.toString();
                                      AppCubit.filter=true;

                                    });

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Library(
                                                    std_id: AppCubit.std,std_name: AppCubit.name),
                                          ));

                                  },

                                  child: Container(

                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xfff9a200),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(AppLocalizations.of(context).translate('Apply_Filter')
                                      ,
                                      style: TextStyle(

                                        fontFamily: 'Tajawal',
                                        color: Colors.white,
                                        fontSize: 16,

                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10),
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      textFrom = 'Date From';
                                      textTo = 'Date To';
                                      _character = '';
                                      Reset.clear_searhe();
                                      // AppCubit.filter=false;
                                      // AppCubit.stutes_notif_odoo='';
                                      // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
                                      // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
                                    });
                                  },

                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    alignment: Alignment.center,
                                    child: Text(AppLocalizations.of(context).translate('Reset_Filter'),
                                      style: TextStyle(

                                        fontFamily: 'Nunito',
                                        color:  Color(0xff3c92d0),
                                        fontSize: 16,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),]),
                          )


                        ],
                      ),
                    ),
                  ),
                ));
        },
      ),

    );

  }




}
