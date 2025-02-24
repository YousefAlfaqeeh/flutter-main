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
import 'package:udemy_flutter/shared/shareWid.dart';

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
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) =>  Calendar(
            std_id: AppCubit.list_st[i].id.toString(),
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));

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
            body: Container(
              child: Column(
                children: [
                  AppCubit.list_calendar.length != 0
                      ? Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>index< AppCubit.list_calendar.length?
                                badges(AppCubit.list_calendar[index]):SizedBox(height: 200,),
                            itemCount: AppCubit.list_calendar.length+1,
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


  Widget badges(ResultCalendar result) {
    //result.startDate.toString()
    String startDate ='';
    if (result.startDate.toString().isNotEmpty) {
      DateTime dt1 = DateFormat('dd MMM yyyy').parse(
          result.startDate.toString());
      var formatter = DateFormat.yMMMd('ar_SA');
       startDate = CacheHelper.getBoolean(key: 'lang')
          .toString()
          .contains('ar') ? formatter.format(dt1) : result.startDate.toString();
    }

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
