import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/absenceRequest.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/notification/filter_ab.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class Absence extends StatefulWidget {
  String std_id, std_name;

  Absence({required this.std_id, required this.std_name});

  @override
  State<Absence> createState() => _AbsenceState();
}

class _AbsenceState extends State<Absence> with SingleTickerProviderStateMixin {
  List colors = [Colors.red, Colors.orange, Colors.blueAccent];
  Random random = new Random();
  List<Widget> student = [];
  Function? f;

  // ReceivePort _port = ReceivePort();
  static List<Tab> myTabs = <Tab>[
    Tab(text: 'Daily Attendance'),
    Tab(text: 'Absence Requests'),
  ];
  Color color_co_Daily = Colors.red;
  Color color_text_Daily = Colors.white;
  var st_text_Daily = FontWeight.bold;
  var st_text_Absence = FontWeight.normal;
  Color color_co_Absence = Colors.transparent;
  Color color_text_Absence = Color(0xffbbc7db);

  String type = "Daily";
  TextEditingController search = TextEditingController();
  List<DailyAttendance> list_Search_daily = [];
  List<AbsenceRequest> list_Search_req = [];
  bool flg = false;

  @override
  void initState() {
    // TODO: implement initState
    onSearchDayl();
    onSearchTextChanged();
    super.initState();
  }

  // @override
  // void dispose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }
  //
  // @pragma('vm:entry-point')
  // static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  //   final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
  //   send!.send([id, status, progress]);
  // }
  onSearchDayl() async {
    list_Search_daily.clear();
    // if(text.isEmpty)
    // {
    //   setState(() {
    //
    //   });
    //   return;
    // }
    if (AppCubit.stutes_notif_da_odoo.isNotEmpty) {
      AppCubit.dailyAttendance.forEach((element) {
        DateTime dt1 =
            DateFormat('dd MMM yyyy').parse(element.startDate.toString());

        if (element.type
                .toString()
                .contains(AppCubit.stutes_notif_da_odoo.toLowerCase()) &&
            (dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||
                dt1.isBefore(AppCubit.fromTo_odoo)) &&
            (dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
                dt1.isAfter(AppCubit.fromDate_odoo))) {
          list_Search_daily.add(element);
        }
      });
    } else {
      AppCubit.dailyAttendance.forEach((element) {
        DateTime dt1 =
            DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        // if((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo)))
        // {
        if ((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||
                dt1.isBefore(AppCubit.fromTo_odoo)) &&
            (dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
                dt1.isAfter(AppCubit.fromDate_odoo))) {
          list_Search_daily.add(element);
        }
      });
    }

    setState(() {});
  }

  onSearchTextChanged() async {
    list_Search_req.clear();
    // print("ffffffffgggg");
    // print(AppCubit.stutes_notif_odoo);

    if (AppCubit.stutes_notif_odoo.isNotEmpty) {
      AppCubit.absenceRequest.forEach((element) {
        DateTime dt1 =
            DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        // print(AppCubit.stutes_notif_odoo+"kkkkkk");
        // print(element.status.toString().toLowerCase().contains(AppCubit.stutes_notif_odoo.toLowerCase()));
        if (element.status
                .toString()
                .toLowerCase()==AppCubit.stutes_notif_odoo.toLowerCase() &&
            (dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||
                dt1.isBefore(AppCubit.fromTo_odoo)) &&
            (dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
                dt1.isAfter(AppCubit.fromDate_odoo))) {
          list_Search_req.add(element);
        }
      });
    } else {
      AppCubit.absenceRequest.forEach((element) {
        DateTime dt1 =
            DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        // print('element.status.toString()');
        if ((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||
                dt1.isBefore(AppCubit.fromTo_odoo)) &&
            (dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
                dt1.isAfter(AppCubit.fromDate_odoo))) {
          list_Search_req.add(element);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    student.clear();
    for (int i = 0; i < AppCubit.list_st.length; i++) {
      //
      setState(() {
        student.add(student_list(i, AppCubit.list_st[i]));
      });
    }
    return BlocProvider(
      create: (context) => AppCubit()..getAbsence(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return DefaultTabController(
            length: myTabs.length,
            // The Builder widget is used to have a different BuildContext to access
            // closest DefaultTabController.
            child: Builder(builder: (BuildContext context) {
              final TabController? tabController =
                  DefaultTabController.of(context);
              tabController?.addListener(() {
                if (!tabController.indexIsChanging) {
                  // Your code goes here.
                  // To get index of current tab use tabController.index
                }
              });
              return WillPopScope(
                onWillPop: () async {
                  Reset.clear_searhe();
                  return false;
                },
                child: Scaffold(
                  bottomNavigationBar:
                  BottomAppBar(
                    shape: CircularNotchedRectangle(),


                    notchMargin: 20,
                    child: Container(
                      height: 140,
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            // width: 300,

                            child: InkWell(
                                onTap: _down,
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xfff9a200)),
                                    height: 60,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 20),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        // Container(
                                        //
                                        //
                                        //     padding: EdgeInsets.all(15),
                                        //     child: Icon(Icons.check_circle,color: Colors.white,)),
                                        Text(AppLocalizations.of(context).translate('absence_request'),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Tajawal',
                                                fontSize: 15,
                                                color: Colors.white)),
                                      ],
                                    ))),
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Setting(),
                                            ));
                                      },
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("images/icon_feather_search.svg",color: Colors.grey,)
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Tracking(),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("images/bus.svg",color: Colors.grey,)

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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Hiome_Kids(),
                                            ));
                                      },
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("images/icons8_home.svg",color:  Colors.grey,)
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PickUp_Request(),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("images/picup_empty.svg",color: Colors.grey,)

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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => General_app(),
                                            ));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset("images/icons8_four_squares.svg",color: Colors.grey,)

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

                  appBar: CustomAppBar(student, AppLocalizations.of(context).translate('absence')),

                  // AppBar(
                  //   toolbarHeight: 75,
                  //   backgroundColor:Colors.white,
                  //   leadingWidth: double.infinity/4,
                  //   leading: Padding(
                  //     padding:EdgeInsets.only(left: 3,top: 20,bottom: 10,right: 0),
                  //     // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  //     child: Container(
                  //
                  //       child: Row(
                  //         // mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           IconButton(
                  //             onPressed: () {
                  //
                  //               Reset.clear_searhe();
                  //               if(AppCubit.back_home) {
                  //                 AppCubit.back_home=false;
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(builder: (context) => Hiome_Kids()),
                  //                 );
                  //               }
                  //               else {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(builder: (context) => New_Detail()),
                  //                 );
                  //               }
                  //             },
                  //             icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
                  //           ),
                  //           Container(
                  //
                  //             child: Text('Absence',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
                  //
                  //           ),
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //   actions: [
                  //     Padding(
                  //       padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 20),
                  //       child: Row(
                  //         children: [
                  //           CircleAvatar(
                  //             backgroundColor: Colors.transparent ,
                  //             maxRadius: 26,
                  //             backgroundImage: NetworkImage('${AppCubit.image}', ),
                  //           ),
                  //           PopupMenuButton(offset: Offset(0,AppBar().preferredSize.height),
                  //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  //             child:Icon(Icons.keyboard_arrow_down,size: 26,color: Color(0xff98aac9)) ,itemBuilder: (context) => [
                  //
                  //               PopupMenuItem(child:
                  //               Container(
                  //                 width:35.w,
                  //                 child: Column(
                  //                   children:student,
                  //
                  //                 ),
                  //               ))
                  //             ],)
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  //
                  // ),
                  // floatingActionButton: FloatingActionButton(
                  //   onPressed: _down,
                  //   backgroundColor: Colors.orange,
                  //   child: const Icon(Icons.add),
                  // ),
                  body: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.18,
                      color: Color(0xfff6f8fb),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),boxShadow: [BoxShadow(color: Colors.grey),BoxShadow(color: Colors.white,spreadRadius: -.4,blurRadius: 2.0)]),
                            // elevation: 2,
                            // shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(8),
                            //     side: BorderSide(color: Color(0xffbbc7db))),
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        color_co_Daily = Colors.red;
                                        color_text_Daily = Colors.white;
                                        color_co_Absence = Colors.transparent;
                                        color_text_Absence = Color(0xffbbc7db);
                                        st_text_Daily = FontWeight.bold;
                                        st_text_Absence = FontWeight.normal;
                                        type = 'Daily';
                                      });
                                    },
                                    child: Container(
                                        // margin: EdgeInsets.symmetric(vertical: 20),
                                        decoration: BoxDecoration(
                                            color: color_co_Daily,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height:35,
                                        alignment: Alignment.center,
                                        child: Text(
                                         AppLocalizations.of(context).translate('Daily_attendance'),
                                          style: TextStyle(
                                              fontWeight: st_text_Daily,
                                              fontSize: 14,
                                              fontFamily: 'Nunito',
                                              color: color_text_Daily),
                                        )),
                                  )),
                                  Expanded(
                                      child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        color_co_Absence = Colors.red;
                                        color_text_Absence = Colors.white;
                                        color_co_Daily = Colors.transparent;
                                        color_text_Daily = Color(0xffbbc7db);
                                        st_text_Absence = FontWeight.normal;
                                        st_text_Daily = FontWeight.bold;
                                        type = 'Absence';
                                      });
                                    },
                                    child: Container(
                                        // padding: EdgeInsets.only(left: 10,right: 10),
                                        decoration: BoxDecoration(
                                            color: color_co_Absence,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        // margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                                        alignment: Alignment.center,
                                        height:35,
                                        child: Text(AppLocalizations.of(context).translate('absence_request'),
                                            style: TextStyle(
                                                fontWeight: st_text_Absence,
                                                fontSize: 14,
                                                fontFamily: 'Nunito',
                                                color: color_text_Absence))),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.w),
                            alignment: Alignment.centerRight,
                            child:FilterOdoo(page: (){ Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Filter_odoo_ab(),
                                ));})
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Container(
                            //       // color: Colors.red,
                            //       child: Text('Filter', style: TextStyle(
                            //       fontWeight: FontWeight.normal,
                            //       fontSize: 13,
                            //
                            //       fontFamily: 'Nunito',
                            //       color: Color(0xff222222))),
                            //     ),
                            //     IconButton(
                            //       onPressed: () {
                            //         Navigator.push(
                            //             context,
                            //             MaterialPageRoute(
                            //               builder: (context) => Filter_odoo_ab(),
                            //             ));
                            //       },
                            //       icon: SvgPicture.asset(
                            //         "images/filter11.svg",
                            //         color: Color(0xff98aac9),
                            //         width: 20,
                            //       ),
                            //       color: Color(0xff98aac9),
                            //     ),
                            //   ],
                            // ),
                          ),
                          // Expanded(
                          //   child:  type=="Daily"?
                          //   ListView.builder(
                          //
                          //     itemBuilder: (context, index) => getContainerDaily(AppCubit.dailyAttendance[0]),
                          //     itemCount: 50,
                          //     shrinkWrap: true,
                          //     // separatorBuilder: (context, index) {
                          //     //   return Container(
                          //     //
                          //     //       child: Divider(
                          //     //         color: Colors.grey,
                          //     //       ));
                          //     // },
                          //
                          //   ):
                          //   ListView.separated(
                          //
                          //     itemBuilder: (context, index) => getContainerAbsence(AppCubit.absenceRequest[index]),
                          //     itemCount: AppCubit.absenceRequest.length,
                          //     shrinkWrap: true,
                          //     separatorBuilder: (context, index) {
                          //       return Container(
                          //
                          //           child: Divider(
                          //             color: Colors.grey,
                          //           ));
                          //     },
                          //
                          //   ),),
                          type == "Daily"
                              ? Expanded(
                                  child: AppCubit.dailyAttendance.length != 0
                                      ? ListView.builder(
                                          itemBuilder: (context, index) =>
                                              getContainerDaily(
                                                  list_Search_daily.length >
                                                              0 &&
                                                          AppCubit.flag_req
                                                      ? list_Search_daily[index]
                                                      : AppCubit
                                                              .dailyAttendance[
                                                          index]),
                                          itemCount: list_Search_daily.length >
                                                      0 &&
                                                  AppCubit.flag_req
                                              ? list_Search_daily.length
                                              : AppCubit.dailyAttendance.length,
                                          // shrinkWrap: true,
                                        )
                                      : CustomEmpty("images/noabsence.png",AppLocalizations.of(context).translate('No_Absence')),
                                )
                              : Expanded(
                                  child: AppCubit.absenceRequest.length != 0
                                      ? ListView.builder(
                                          itemBuilder: (context, index) =>
                                              getContainerAbsence(
                                                  list_Search_req.length > 0 &&
                                                          AppCubit.flag_req
                                                      ? list_Search_req[index]
                                                      : AppCubit.absenceRequest[
                                                          index]),
                                          itemCount: list_Search_req.length >
                                                      0 &&
                                                  AppCubit.flag_req
                                              ? list_Search_req.length
                                              : AppCubit.absenceRequest.length,
                                          shrinkWrap: true,
                                        )
                                      : CustomEmpty("images/noabsence.png",
                                          AppLocalizations.of(context).translate('No_Absence'))),
                          // Container(
                          //   alignment: Alignment.center,
                          //   // width: 300,
                          //
                          //   child: InkWell(
                          //       onTap: _down,
                          //       child: Container(
                          //           decoration: BoxDecoration(
                          //               borderRadius: BorderRadius.circular(5),
                          //               color: Color(0xfff9a200)),
                          //           height: 60,
                          //           margin: EdgeInsets.symmetric(
                          //               vertical: 3, horizontal: 20),
                          //           alignment: Alignment.center,
                          //           padding: EdgeInsets.symmetric(
                          //               horizontal: 10, vertical: 5),
                          //           child: Row(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.center,
                          //             children: [
                          //               // Container(
                          //               //
                          //               //
                          //               //     padding: EdgeInsets.all(15),
                          //               //     child: Icon(Icons.check_circle,color: Colors.white,)),
                          //               Text('Absence request',
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.bold,
                          //                       fontFamily: 'Tajawal',
                          //                       fontSize: 15,
                          //                       color: Colors.white)),
                          //             ],
                          //           ))),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  //get design Daily Attendance
  Widget getContainerDaily(DailyAttendance dailyAttendance) {
    // print(dailyAttendance.type.toString());
    String state = 'Late' + ' | ' + dailyAttendance.arrivalTime.toString();
    if (dailyAttendance.type.toString().contains('unexcused')) {
      state = AppLocalizations.of(context).translate('Absent_Unexcused');
    } else if (dailyAttendance.type.toString().contains('excused')) {
      state = AppLocalizations.of(context).translate('Absent_Excused');
    } else if (dailyAttendance.type.toString().contains('present')) {
      state = AppLocalizations.of(context).translate('present');
    }
    String reason = '';
    if (dailyAttendance.reason.toString() != 'null' &&
        dailyAttendance.reason.toString().isNotEmpty) {
      reason = dailyAttendance.reason.toString();
    }
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(dailyAttendance.startDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String formatted = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):dailyAttendance.startDate.toString();
    return InkWell(
      child: Card(
        elevation: 0,
        // padding: EdgeInsets.only(top: 30),
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.only(left: 12, right: 20, top: 15, bottom: 10),
              elevation: 0,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // color: Colors.yellowAccent,
                    // height: 100,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          // side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                          child: SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Absence.svg',
                            color: Color(0xff3c92d0),
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(state,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                        color: Color(0xff98aac9)))),
                            // Expanded(
                            //   child: Container(alignment: Alignment.centerRight,
                            //     // padding:EdgeInsets.only(right: 4),
                            //     child: Container(
                            //         width: w,
                            //         height: 20,
                            //         alignment: Alignment.center,
                            //         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color:color),
                            //         child:Text(status,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 12,color: Colors.white)) ),),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(formatted,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Color(0xff222222)))),
                            // SizedBox(width: 10,),
                            // Expanded(child: Container(alignment: Alignment.centerRight,child: Text(day,style:  TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color:Color(0xff98aac9))))),
                          ],
                        ),
                        // SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text("Deadline",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)),
                            // SizedBox(width: 1.w,),
                            Visibility(
                              visible: reason.isNotEmpty,
                              child: Expanded(
                                  child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(reason,
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                              color: Color(0xff2a2a2a))))),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(left: 35),
            //       padding: EdgeInsets.all(8),
            //       height: 32,
            //       width: 32,
            //       decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(40)),color: Color(0xff6d9c34)
            //       )
            //       ,child: SvgPicture.asset("images/thermometer_quarter_solid.svg"),),
            //
            //     SizedBox(
            //       width: 20,
            //     ),
            //
            //     Expanded(
            //         child:Text(absenceRequest.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Color(0xff3c92d0))))
            //    ,
            //   Expanded(
            //     child: Container(
            //            margin: EdgeInsets.only(right: 30),
            //           height: 30,
            //           width: 80,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(5)),color: color
            //           )
            //           ,child:Text(status,style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
            //       ),
            //   ),
            //
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //
            //
            //
            //     Container( margin: EdgeInsets.only(left: 30),
            //         padding: EdgeInsets.all(8), child: Text("State",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),
            //
            //     Expanded(
            //         child:Container(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),child: Text(absenceRequest.type.toString() ,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)))),
            //
            //
            //   ],
            // ),
            // Row(
            //   children: [
            //
            //
            //
            //     Container( margin: EdgeInsets.only(left: 30),
            //         padding: EdgeInsets.all(8), child: Text("Reason",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),
            //
            //     Expanded(
            //         child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text(absenceRequest.reason.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)))),
            //
            //
            //   ],
            // ),
          ],
        ),
      ),
    );
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 35),
                  padding: EdgeInsets.all(8),
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff6d9c34)),
                  child:
                      SvgPicture.asset("images/thermometer_quarter_solid.svg"),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(dailyAttendance.startDate.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontSize: 20,
                            color: Color(0xff3c92d0))))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 30),
                    padding: EdgeInsets.all(8),
                    child: Text("State",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            color: Color(0xff3c92d0)))),
                Expanded(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(state,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Colors.black)))),
              ],
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 30),
                    padding: EdgeInsets.all(8),
                    child: Text("Reason",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            color: Color(0xff3c92d0)))),
                Expanded(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(reason,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Colors.black)))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //get design Absence
  Widget getContainerAbsence(AbsenceRequest absenceRequest) {
    String status = "Approve";
    Color color = Color(0xff6d9c34);
    double w = 80;


    if (absenceRequest.status.toString() == 'To_approve') {
      status =  AppLocalizations.of(context).translate('Waiting_Approval');
      color = Color(0xfffab92f);
      w = 110;
    } else if (absenceRequest.status.toString() == 'Reject') {
      status =AppLocalizations.of(context).translate('rejected');
      color = Colors.red;
    } else {
      status = AppLocalizations.of(context).translate('approved');
    }
    String day = AppLocalizations.of(context).translate('day');
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(absenceRequest.startDate.toString());
    DateTime d1 = DateTime(dt1.year, dt1.month, dt1.day);
    DateTime d =DateFormat('dd MMM yyyy').parse(absenceRequest.endDate.toString());
    day = d.difference(d1).inDays.toString() + day;
    var formatter = DateFormat.yMMMd('ar_SA');
    String formatted = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1)+" - "+formatter.format(d):absenceRequest.startDate.toString() +
    "-" +
    absenceRequest.endDate.toString();
    // String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(absenceRequest.endDate.toString()))+" 00:00:00";
    // DateTime d=DateTime.parse(x.toString());
    // DateTime d=DateTime.now();

    // print(d.difference(d1).inDays);

    return InkWell(
      child: Card(
        elevation: 0,
        // padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 12, right: 20, top: 15, bottom: 10),
              elevation: 0,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // color: Colors.red,
                    // height: 100,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          // side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                          child: SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Absence.svg',
                            color: Color(0xff3c92d0),
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(absenceRequest.type.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito',
                                        fontSize: 12,
                                        color: Color(0xff98aac9)))),
                            Expanded(
                              child: Container(
                                alignment:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                                // padding:EdgeInsets.only(right: 4),
                                child: Container(
                                    width: w,
                                    height: 20,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3)),
                                        color: color),
                                    child: Text(status,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            fontSize: 12,
                                            color: Colors.white))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Container(
                                // alignment: Alignment.topLeft,
                                child: Text(
                                    formatted,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color:Color(0xff222222)))),
                            // SizedBox(width: 10,),
                            Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                    alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                                    child: Text(day,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                            color: Color(0xff98aac9))))),
                          ],
                        ),
                        // SizedBox(height: 12,),
                        Visibility(
                          visible:absenceRequest.reason.toString().isNotEmpty ,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Text("Deadline",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)),
                              // SizedBox(width: 1.w,),
                              Expanded(
                                  child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                          absenceRequest.reason.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                              color: Color(0xff2a2a2a))))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   children: [
            //     Container(
            //       margin: EdgeInsets.only(left: 35),
            //       padding: EdgeInsets.all(8),
            //       height: 32,
            //       width: 32,
            //       decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(40)),color: Color(0xff6d9c34)
            //       )
            //       ,child: SvgPicture.asset("images/thermometer_quarter_solid.svg"),),
            //
            //     SizedBox(
            //       width: 20,
            //     ),
            //
            //     Expanded(
            //         child:Text(absenceRequest.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Color(0xff3c92d0))))
            //    ,
            //   Expanded(
            //     child: Container(
            //            margin: EdgeInsets.only(right: 30),
            //           height: 30,
            //           width: 80,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(5)),color: color
            //           )
            //           ,child:Text(status,style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold)),
            //       ),
            //   ),
            //
            //   ],
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Row(
            //   children: [
            //
            //
            //
            //     Container( margin: EdgeInsets.only(left: 30),
            //         padding: EdgeInsets.all(8), child: Text("State",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),
            //
            //     Expanded(
            //         child:Container(padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),child: Text(absenceRequest.type.toString() ,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)))),
            //
            //
            //   ],
            // ),
            // Row(
            //   children: [
            //
            //
            //
            //     Container( margin: EdgeInsets.only(left: 30),
            //         padding: EdgeInsets.all(8), child: Text("Reason",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),
            //
            //     Expanded(
            //         child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text(absenceRequest.reason.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)))),
            //
            //
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          AppCubit.flag_req = false;
          AppCubit.stutes_notif_odoo = '';
          AppCubit.school_image = listDetail1.schoolImage.toString();

          listFeatures1.clear();
          // if (listDetail1.changeLocation = true) {
          //   listFeatures1.add(Features(
          //       name: AppLocalizations.of(context)
          //           .translate('chang_home_location'),
          //       icon:
          //           'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',
          //       nameAr: AppLocalizations.of(context)
          //           .translate('chang_home_location')));
          // }

          listDetail1.features!.forEach((element) {
            listFeatures1.add(element);
          });

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

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Absence(
                      std_id: AppCubit.std, std_name: widget.std_name)));
        },
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: 20,
            backgroundImage: NetworkImage(
              '${listDetail1.avatar}',
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${listDetail1.fname}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 9),
              ),
              Text(
                "${AppCubit.grade}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito',
                    fontSize: 9),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Widget emptyAss() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(children: [
          Expanded(
              child: Image(
            image: AssetImage("images/noabsence.png"),
            width: 293,
            height: 200,
          )),
          Text("No Absence ",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  fontSize: 22,
                  color: Colors.black)),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => New_Detail()),
                );
              },
              child: Text("Return to profile",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Color(0xff3c92d0),
                      decoration: TextDecoration.underline)))
        ]),
      ),
    );
  }

  Future<void> _down() async {
    // var status = await Permission.storage.request();
    //
    // if (status.isGranted) {
    // if(Platform.isAndroid)
    //   {
    // final dir =await getApplicationDocumentsDirectory();
    // path=dir.path;
    //
    //   }
    // else{
    //   path= (await getApplicationDocumentsDirectory()).absolute.path;
    // }
    // showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (_) =>DialogTypeRequest(stu_name: widget.std_name));
    print('------------');
    print(widget.std_name);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DialogTypeRequest(stu_name: widget.std_name)));

    // Directory? directory;
    // try {
    //   if (Platform.isIOS) {
    //     directory = await getApplicationDocumentsDirectory();
    //   } else {
    //
    //     directory = Directory('/storage/emulated/0/Download/');
    //     // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
    //     // ignore: avoid_slow_async_io
    //     if (!await directory.exists()) directory = await getExternalStorageDirectory();
    //   }
    // } catch (err, stack) {
    //   print("Cannot get download folder path");
    // }
    // print("-------");
    // print(directory!.path);
    // directory.create();
    // await dio.download(url,directory.path+"9.png" ,onReceiveProgress: (count, total) {
    //   print(((count/total)*100).toStringAsFixed(0)+"%");
    // },).then((value){
    //   print("pppppppppppswwww");
    // });
    // GallerySaver.saveImage("${directory.path}9.png");
    // String? loadMediaMessage;
    // // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   loadMediaMessage = await MediaScanner.loadMedia(
    //       path: "${directory.path}9.png");
    // } on PlatformException {
    //   loadMediaMessage = 'Failed to get platform version.';
    // }
    // }
  }
}
