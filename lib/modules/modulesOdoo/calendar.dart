import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelCalendar.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class Calendar extends StatefulWidget {
  String std_id;

  Calendar({required this.std_id});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Widget> student = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      create: (context) => AppCubit()..getCalendar(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(student, AppLocalizations.of(context).translate('calendar')),
            bottomNavigationBar: CustomBottomBar(
                "images/icons8_four_squares.svg",
                "images/icons8_home.svg",
                "images/picup_empty.svg",
                "images/icon_feather_search.svg",
                "images/bus.svg",
                Color(0xff98aac9),
                Color(0xff98aac9),
                Color(0xff98aac9),
                Color(0xff98aac9),
                Color(0xff98aac9)),
            backgroundColor: Color(0xfff5f7fb),
            // appBar: AppBar(
            //   toolbarHeight: 20.w,
            //   backgroundColor:Colors.white,
            //   leadingWidth: double.infinity/4,
            //   leading: Padding(
            //     padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 0),
            //     // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            //     child: Container(
            //
            //       child: Row(
            //         // mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           IconButton(
            //             onPressed: () {
            //               Reset.clear_searhe();
            //               // AppCubit.stutes_notif_odoo='';
            //               // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
            //               // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
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
            //             // child: Text("ufuufufufufufu"),
            //             child: Text('Calendar',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
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
            //             maxRadius: 6.w,
            //             backgroundImage: NetworkImage('${AppCubit.image}', ),
            //           ),
            //           PopupMenuButton(offset: Offset(0,AppBar().preferredSize.height),
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            //             child:Icon(Icons.keyboard_arrow_down,size: 8.w,color: Color(0xff98aac9)) ,itemBuilder: (context) => [
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

//           body: Container(
//             // height: MediaQuery.of(context).size.height/1.5,
//             child: SfCalendar(
//               headerHeight: 50,
//
//               view: CalendarView.month,
// headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
//               todayHighlightColor: Colors.black,
//               // todayTextStyle: ,
//
//
//               dataSource:AppCubit.allMeetings,
//               monthViewSettings: MonthViewSettings(
//                 showAgenda: true,
//                   showTrailingAndLeadingDates:false,
//
//                   appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
//
//               ),
//
//             ),
//           ),
            body: Container(
              child: Column(
                children: [
                  // Container(
                  //   width: double.infinity,
                  //   color: Colors.blue[700],
                  //
                  //   child:
                  //   Column(
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.only(top: 50,left: 20,bottom: 20),
                  //
                  //         child: Row(children: [
                  //           IconButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             icon: Container(
                  //                 width: 13.58,
                  //                 height: 22.37,
                  //                 padding: EdgeInsetsDirectional.only(end: 3),
                  //                 child: SvgPicture.asset("images/chevron_left_solid.svg")),
                  //           ),
                  //           Container(padding: EdgeInsets.all(3),child: Icon(Icons.calendar_month,color: Colors.white,size: 40,),),
                  //           Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 20),
                  //               alignment: Alignment.centerLeft, child: Text("Calendar",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
                  //         ],),
                  //       ),
                  //
                  //
                  //
                  //     ],
                  //   ),
                  // ),
                  // ),
                  AppCubit.list_calendar.length != 0
                      ? Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                badges(AppCubit.list_calendar[index]),
                            itemCount: AppCubit.list_calendar.length,
                            separatorBuilder: (context, index) {
                              return Container();
                            },
                          ),
                        )
                      : CustomEmpty("images/calendae.png", AppLocalizations.of(context).translate('no_Calendar')),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          AppCubit.school_image = listDetail1.schoolImage.toString();
          AppCubit.stutes_notif_odoo = '';

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
              builder: (context) => Calendar(
                std_id: listDetail1.id.toString(),
              ),
            ),
          );
        },
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: 5.w,
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

  Widget badges(ResultCalendar result) {
    //result.startDate.toString()
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(result.startDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String startDate = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):result.startDate.toString();
    return InkWell(
        onTap: () {},
        child:
        // Card(
        //   child: Column(
        //     children: [
        //       Row(
        //         children: [
        //           Card(
        //             margin: EdgeInsets.only(left: 20,top: 10),
        //             shape: const RoundedRectangleBorder(
        //                 side: BorderSide(width: .8,color: Color(0xffd4ddee)),
        //                 borderRadius: BorderRadius.all(Radius.circular(50.0))),
        //             elevation: 0.0,
        //             child: Container(
        //               margin: EdgeInsets.only(top: 2),
        //
        //               child: CircleAvatar(
        //                 backgroundColor: Color(0xff3c92d0).withOpacity(.2),
        //                 child:  SvgPicture.network(
        //                   'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Clinic.svg',color:Color(0xff3c92d0) ,width: 5.w,),
        //
        //
        //
        //               ),
        //             ),
        //           ),
        //
        //           SizedBox(
        //             width: 20,
        //           ),
        //
        //           Expanded(
        //               child:Container(margin: EdgeInsets.only(top: 5), child: Text(result.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))))
        //
        //         ],
        //       ),
        //       Row(
        //         children: [
        //
        //
        //
        //           Container( margin: EdgeInsets.only(left: 20),
        //               padding: EdgeInsets.all(8), child: Text("Note",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),
        //
        //           Expanded(
        //               child:Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text( result.startDate.toString(),style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito',fontSize: 16,color: Colors.black.withOpacity(.8))))),
        //
        //
        //         ],
        //       ),
        //       SizedBox(
        //         width: 20,
        //       ),
        //       Container(
        //           alignment: Alignment.centerLeft,
        //           color: Color(0xfff9a200).withOpacity(.2),
        //           margin: EdgeInsets.only(left: 20,right: 20),
        //           padding: EdgeInsets.all(8),
        //           child: Row(
        //             children: [
        //               SvgPicture.asset('images/icons8_clinic11.svg',color:Color(0xff3c92d0) ,width: 25,),
        //               SizedBox(width: 10,),
        //               Expanded(child: Text(result.startDate.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),
        //             ],
        //           )
        //       ),
        //       SizedBox(
        //         height: 15,
        //       ),
        //     ],
        //   ),
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Card(
                      margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0, top: 6),
                      shape: const RoundedRectangleBorder(
                        // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                          borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(
                        // margin: EdgeInsets.only(top: 2),

                        child: CircleAvatar(
                          backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                          child: SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/calendar.svg',
                            color: Color(0xff3c92d0),
                            width: 22,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 22,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?22: 0,top: 2),

                      child: Dash(
                          direction: Axis.vertical,
                          length: 50,
                          dashLength: 5,
                          dashColor: Color(0xff3c92d0)),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 10),
                        Container(
                            margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 10,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?10: 0),
                            padding: EdgeInsets.only(top: 30),
                            child: Text(startDate,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                    fontSize: 15,
                                    color: Color(0xff3c92d0)))),

                        Container(
                            margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 10,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?10: 20
                                , top: 10, bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white),
                            padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            child: Text(result.name.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    color: Colors.black))),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Container(
            //     alignment: Alignment.centerLeft,
            //     margin: EdgeInsets.only(left: 40),
            //     padding: EdgeInsets.all(4),
            //     child: Text("|",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 10,color: Color(0xff3c92d0)))),
            // Container(
            //     alignment: Alignment.centerLeft,
            //     margin: EdgeInsets.only(left: 40),
            //     padding: EdgeInsets.all(4),
            //     child: Text("|",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 10,color: Color(0xff3c92d0)))),
            // Container(
            //     alignment: Alignment.centerLeft,
            //     margin: EdgeInsets.only(left: 40),
            //     padding: EdgeInsets.all(4),
            //     child: Text("|",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize:10,color: Color(0xff3c92d0)))),

          ],
        ));
  }

}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(this.source);

  List<Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  String getStartTimeZone(int index) {
    return source[index].startTimeZone;
  }

  @override
  String getEndTimeZone(int index) {
    return source[index].endTimeZone;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

class Meeting {
  Meeting(
      {required this.from,
      required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
}
