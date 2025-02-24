
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/timeTable.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';


class Time_Table_Form extends StatefulWidget {
  String std_id;


  Time_Table_Form(
      {required this.std_id});

  @override
  State<Time_Table_Form> createState() => _Time_Table_FormState();
}

class _Time_Table_FormState extends State<Time_Table_Form>
    with SingleTickerProviderStateMixin {
  List colors=[Color(0xff3c92d0),Color(0xffe84314),Color(0xff7cb13b),Color(0xfff9a200)];
  // List colors = [Color(0xfff9a200), Color(0xfff9a200), Color(0xfff9a200)];
  Random random = new Random();
  List<Widget> student = [];
  static List<Tab> myTabs = <Tab>[];
  static List day_week = [];
  static List day_week_color = [];
  
  static List day_name = [];
  static List day_num = [];
  bool flg = false;
  int index_le=0;
  int index_co=0;

  @override
  void initState() {
    // TODO: implement initState
    myTabs.clear();
    day_week.clear();
    day_name.clear();
    myTabs = AppCubit.day;
    day_week = AppCubit.day_week;
    day_name = AppCubit.day_name;

    day_num = AppCubit.day_num;
    day_week_color.clear();
    day_week_color = AppCubit.day_week_color;
    index_le=0;

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    student.clear();
    for (int i = 0; i < AppCubit.list_st.length; i++) {
      //
      setState(() {
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) =>Time_Table_Form(std_id: AppCubit.std),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));


      });
    }
    setState(() {
      day_name = AppCubit.day_name;
      day_num = AppCubit.day_num;
    });
    return BlocProvider(
      create: (context) => AppCubit()
        ..getTimeTable(widget.std_id),
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
              return Scaffold(
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
                appBar:


                AppBar(
                  elevation: 0,
                  toolbarHeight: 100,
                  backgroundColor: Color(0xff3c92d0),
                  leadingWidth: double.infinity / 4,
                  leading: Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 20, bottom: 10, right: 0),
                    // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                    child: Container(
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(angle:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?9.5:0 ,
                            child: IconButton(
                              onPressed: () {
                                Reset.clear_searhe();

                                if (AppCubit.back_home) {
                                  AppCubit.back_home = false;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Hiome_Kids()),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => New_Detail()),
                                  );
                                }
                              },
                              icon: SvgPicture.asset(
                                  "images/chevron_left_solid.svg",
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // child: Text("ufuufufufufufu"),
                              child: Text(AppLocalizations.of(context).translate('timeTable'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 20, bottom: 10, right: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            maxRadius: 6.w,
                            backgroundImage: NetworkImage(
                              '${AppCubit.image}',
                            ),
                          ),
                          PopupMenuButton(
                            offset: Offset(0, AppBar().preferredSize.height),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Icon(Icons.keyboard_arrow_down,
                                size: 8.w, color: Colors.white),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  child: Container(
                                    width: 35.w,
                                    child: Column(
                                      children: student,
                                    ),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xff3c92d0),
                              Color(0xff3c92d0),
                            ],
                          )),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(15)),
                              // color: Colors.white10,
                              width: double.infinity,
                              height: 70,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // day_week_color.clear();
                                      index_le=0;
                                      index_co=0;
                                      for (int i = 0;
                                      i < day_week.length;
                                      i++) {
                                        setState(() {
                                          if (i == index) {
                                            setState(() {
                                              day_name.clear();
                                              day_num.clear();
                                              day_num.add(index);

                                              day_name.add(
                                                  day_week[index].toString());
                                              day_week_color[i] = ({
                                                'color': Color(0xfff9a200),
                                                'sta': true
                                              });
                                            });
                                          } else {
                                            day_week_color[i] = ({
                                              'color': Colors.transparent,
                                              'sta': false
                                            });
                                          }
                                        });
                                        // print("ddddd");
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,

                                      // color: Colors.yellowAccent,
                                      decoration: BoxDecoration(
                                          color: day_week_color[index]['color'],
                                          borderRadius:
                                          BorderRadius.circular(36)),
                                      width: 40,
                                      // height: 100,
                                      margin: EdgeInsets.only(
                                          left: CacheHelper.getBoolean(
                                              key: 'lang')
                                              .toString()
                                              .contains('ar')
                                              ? 0
                                              : 20,
                                          top: 16,
                                          bottom: 10,
                                          right: CacheHelper.getBoolean(
                                              key: 'lang')
                                              .toString()
                                              .contains('ar')
                                              ? 20
                                              : 0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 15),
                                          Text(AppLocalizations.of(context).translate(day_week[index].toString().toLowerCase()),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                                                    ? 10
                                                    : 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                              )),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: day_week.length,
                                shrinkWrap: true,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            7.2),
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            7.2),
                                  )),
                              child: Column(
                                children: [

                                  Expanded(
                                    child: Container(
                                      padding:
                                      EdgeInsets.only(left: 15, right: 15),
                                      child: AppCubit.list_tableTime.length >
                                          0
                                          ?
                                      day_name.length>0?
                                      ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context,
                                            index) =>
                                        AppCubit.list_tableTime.length>index?  allWeekly(
                                                index,
                                                day_name[0]):SizedBox(height: 40.h),
                                        itemCount: AppCubit
                                            .list_tableTime.length+1,
                                        shrinkWrap: true,
                                      ):emptyAss()
                                          : emptyAss(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }),
          );
        },
        listener: (context, state) {},
      ),
    );
  }



  Widget allWeekly(int index, String day) {
    Lines_time_table ass;
    String nots='null';
    if(AppCubit.list_tableTime.length>index)
      {
        ass= AppCubit.list_tableTime[index];
        index = random.nextInt(3);

        AppCubit.subject_odoo.add(ass.subjectName.toString());
        AppCubit.subject_odoo = AppCubit.subject_odoo.toSet().toList();
        if (ass.subjectId.toString()!='null')
          nots=ass.sequence.toString();

        if ((day.toLowerCase() == 'sunday' || day.toLowerCase() == 'sun') &&
            ass.sunday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.sunday.toString(), nots);
        }
        if ((day.toLowerCase() == 'saturday' || day.toLowerCase() == 'sat') &&
            ass.saturday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.saturday.toString(), nots);
        }
        if ((day.toLowerCase() == 'monday' || day.toLowerCase() == 'mon') &&
            ass.monday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.monday.toString(), nots);
        }
        if ((day.toLowerCase() == 'thursday' || day.toLowerCase() == 'thu') &&
            ass.thursday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.thursday.toString(), nots);
        }
        if ((day.toLowerCase() == 'wednesday' || day.toLowerCase() == 'wed') &&
            ass.wednesday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.wednesday.toString(), nots);
        }
        if ((day.toLowerCase() == 'friday' || day.toLowerCase() == 'fri') &&
            ass.friday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.friday.toString(), nots);
        }
        if ((day.toLowerCase() == 'tuesday' || day.toLowerCase() == 'tue') &&
            ass.tuesday.toString().isNotEmpty) {

          return getCard_notAtt(index, ass.subjectName.toString(),
              ass.tuesday.toString(), nots);
        }
      }
    else{
      SizedBox(height: 20.h,);
    }
    // int index = 0;

    // }
    return Visibility(visible: false, child: Text(''));
  }



  Widget getCard_notAtt(
      int index_color, String subjectName, String subject_note, String notes) {



    if(notes=='null'){
      print("ofofoofofof");
      return InkWell(
        onTap: () {},
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child:Container(
              decoration: BoxDecoration(color:Color(0xffe84314).withOpacity(.2),borderRadius: BorderRadius.all(Radius.circular(10))),
          
              child: Row(
                children: [

                  Column(

                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(subject_note,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                fontSize: 13,
                                color:Color(0xffe84314))),
                      ),
                      Container(margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(subjectName,

                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                fontSize: 20,
                                color:Color(0xffe84314))),
                      )
                    ],),
                  Expanded(
                    child: Container(
                      alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                      margin: EdgeInsets.only(right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?30:0,left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:30),

                      width: 68,height: 73,
                      child:SvgPicture.asset(
                          "images/icons8_vegetarian_food.svg",
                          color:Color(0xffe84314),width: 48,height: 48, )

                    ),
                  ),

                ],),
            )

        ),
      );
    }
    index_le+=1;
    if(index_co==4)
      {
        index_co=0;


      }

    index_color=index_co;
    index_co+=1;
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child:Row(
          children: [
          Container(
            decoration: BoxDecoration( color: colors[index_color].withOpacity(.2),borderRadius: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?BorderRadius.only(topRight: Radius.circular(10),bottomRight:Radius.circular(10) ):BorderRadius.only(topLeft: Radius.circular(10),bottomLeft:Radius.circular(10) )),
            width: 68,height: 73,
            child:  Card(
              margin: EdgeInsets.symmetric(horizontal: 13, vertical: 13),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            child: Container(alignment: Alignment.center,
            child: Text(notes
            ,style: TextStyle(color: colors[index_color]),)),

            ),
           ),
          Column(

            children: [
            Container(margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(subject_note,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 13,
                    color:Color(0xff98aac9))),
            ),
              Container(margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(subjectName,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color:Color(0xff222222))),
              )
            ],)


        ],)

      ),
    );
  }


  Widget emptyAss() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 40),
              child: Image(
                image: AssetImage("images/no_weekly_plans_1.png"),
                width: 293,
                height: 239,
              ),
            ),
          ),
          Expanded(
              child: Text("No Weekly Plan added",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Color(0xff3c92d0))))
        ]),
      ),
    );
  }
}
