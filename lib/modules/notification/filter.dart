import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/history.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';


class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}


class _FilterState extends State<Filter> {
  String? _character = 'all';
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
    if(AppCubit.filter)
      {if(AppCubit.date.isNotEmpty) {
        // print("dddd");
        fromDate=AppCubit.fromDate;
        fromTo=AppCubit.fromTo;
        textFrom = AppCubit.fromDate.year.toString() +
            '-' +
            AppCubit.fromDate.month.toString() +
            '-' +
            AppCubit.fromDate.day.toString();
        textTo = AppCubit.fromTo.year.toString() +
            '-' +
            AppCubit.fromTo.month.toString() +
            '-' +
            AppCubit.fromTo.day.toString();
      }
        isChecked2=AppCubit.read;
        isChecked=AppCubit.unread;
        if(AppCubit.stutes_notif.isNotEmpty){
      _character=AppCubit.stutes_notif;}
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

          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            setState(() {


            });

          });

          FirebaseMessaging.onMessage.listen((event) {

          });
          return
            WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context);
                  return false;
                },
                child:
                Scaffold(
                  appBar: AppBar(
                    // primary: false,
                    toolbarHeight: 75,
                    backgroundColor: Colors.white,
                    leadingWidth: 100,
                    leading: Container(
                        padding: EdgeInsets.only(left:  28),
                        child: Image(image: AssetImage('images/trackware_school.png'),width:  40,height: 30,)),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 20,top: 10,right: 20),
                        child: IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                      )
                    ],


                  ),
                  //navigation bar
                 backgroundColor: Colors.white,
                  //end navigation bar
                  body:   SingleChildScrollView(
                    child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Card(
                        //   elevation: 2,
                        //   shadowColor: Color(0xffffffff),
                        //   color: Colors.white,
                        //   child: Row(
                        //     // mainAxisAlignment:MainAxisAlignment.end, CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?30:0
                        //     children: [
                        //       Expanded(
                        //         child: Container(color: Colors.white,
                        //
                        //             alignment:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? Alignment.topRight:Alignment.topLeft,
                        //             padding: EdgeInsets.only(left: 30,top: 10,right: 30),
                        //             child: Image(image: AssetImage('images/trackware_school.png'),width:  MediaQuery.of(context).size.width/6,height: MediaQuery.of(context).size.height/6,)),
                        //       ),
                        //
                        //       Padding(
                        //         padding: EdgeInsets.only(left: 30,top: 10,right: 30),
                        //         child: IconButton(onPressed: () {
                        //           Navigator.pop(context);
                        //         }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          // alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 35,top: 20,right: 35),
                          color: Colors.white,
                          height: 70,
                          child: Text(AppLocalizations.of(context).translate('Filter'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            width: double.infinity,

                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                padding: const EdgeInsets.only(left: 30.0,right: 30),
                                child: Text(AppLocalizations.of(context).translate('Date'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                              ),
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
                                                      child: Text(  textTo.contains('Date')?AppLocalizations.of(context).translate('date_to'):textTo))
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
                                Padding(
                                  padding:  EdgeInsets.only(left: 30.0,right: 30,top: 3.w),
                                  child: Text(AppLocalizations.of(context).translate('Status'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                                ),
                                Column(
                                  children: <Widget>[

                                    Container(
                                      height: 30,
                                      child: ListTile(

                                        title:  Text(AppLocalizations.of(context).translate('all')),
                                        leading: Radio<String>(
                                          value: 'all',
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
                                        title:  Text(AppLocalizations.of(context).translate('Unread')),
                                        leading: Radio<String>(
                                          value: 'Unread',
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
                                        title:  Text(AppLocalizations.of(context).translate('Read')),
                                        leading: Radio<String>(
                                          value: 'Read',
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
                                SizedBox(height: 130),
                                Padding(
                                  padding: const EdgeInsets.only(left: 2.0,right: 2),
                                  child: InkWell(
                                    onTap: () async {

                                      setState(() {

                                        if(textTo!='Date To' &&  textFrom != 'Date From'){if(fromDate!=null && fromTo!=null){
                                          AppCubit.fromDate=fromDate;
                                          AppCubit.fromTo=fromTo;

                                          AppCubit.date= fromDate.day.toString() +
                                              '-' +
                                              fromDate.month.toString() +
                                              '-' +
                                              fromDate.year.toString() +"-"+fromTo.day.toString() +
                                              '-' +
                                              fromTo.month.toString() +
                                              '-' +
                                              fromTo.year.toString();}}
                                        AppCubit.stutes_notif=_character.toString();
                                        // if(isChecked2||isChecked){
                                        //
                                        // AppCubit.filter=true;
                                        //
                                        //
                                        // AppCubit.read=isChecked;
                                        // AppCubit.unread=isChecked2;}
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Hiome_Kids(),
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
                                      child: Text(AppLocalizations.of(context).translate('Apply_Filter'),
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


                                        // fromTo=fromTo1;
                                        // AppCubit.fromTo=fromTo1;
                                        // AppCubit.fromDate=fromDate1;
                                        AppCubit.date='';
                                         textFrom = 'Date From';
                                         textTo = 'Date To';
                                        AppCubit.read=false;
                                        isChecked2=false;
                                        isChecked=false;
                                        AppCubit.unread=false;
                                        AppCubit.stutes_notif='';
                                        _character = 'all';
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
                                ),
                            ],)


                        ),



                      ],
                    ),
                  ),
                ));
        },
      ),

    );

  }




}
