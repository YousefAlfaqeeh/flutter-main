import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/models/markMod.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allMark.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';

class EaxmMark extends StatefulWidget {
  String std_id,name,image;
  Exam exam;


  EaxmMark({required this.std_id,required this.name,required this.exam,required this.image});

  @override
  State<EaxmMark> createState() => _EaxmMarkState();
}

class _EaxmMarkState extends State<EaxmMark> {
  int len = 0;

  List<Widget> student = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    student.clear();
    for (int i = 0; i < AppCubit.list_st.length; i++) {
      //
      setState(() {

        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) => All_mark(
            std_id: AppCubit.list_st[i].id.toString(),image: widget.image,
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));

      });
    }

    return BlocProvider(
      create: (context) => AppCubit()..getMarks(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Reset.clear_searhe();
              if (AppCubit.back_home) {
                AppCubit.back_home = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hiome_Kids()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => All_mark(std_id: AppCubit.std,image: AppCubit.image),
                  ),
                );
              }
              return false;
            },
            child: Scaffold(
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
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 100,
                backgroundColor: Color(0xff3c92d0),
                leadingWidth: double.infinity / 4,
                leading: Padding(
                  padding:
                  EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 0),
                  // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: CacheHelper.getBoolean(key: 'lang')
                              .toString()
                              .contains('ar')
                              ? 9.5
                              : 0,
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
                                  MaterialPageRoute(
                                    builder: (context) => All_mark(std_id: widget.std_id,image: widget.image),
                                  ),
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

                            child: Text(widget.name
                               ,
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
              body: Container(
                  height: MediaQuery.of(context).size.height,

                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 0.0,
                                child: Container(

                                  child: CircleAvatar(
                                    backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                                    child:widget.image.isEmpty?SvgPicture.asset(
                                      "images/icons8_diploma_50.svg",
                                      color: Color(0xff3c92d0),
                                      width: 20,
                                    ): SvgPicture.network(widget.image,
                                      color: Color(0xff3c92d0),
                                      width: 20,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 2.w,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // alignment: Alignment.topLeft,
                                        child: Text(CacheHelper.getBoolean(key: 'lang')
                                            .toString()
                                            .contains('ar')
                                            ? widget.exam.examNameAr.toString()
                                            : widget.exam.examNameEn.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                                fontSize: 18,
                                                color: Color(0xff3c92d0)))),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color(0xfff5f7fb)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                  EdgeInsets.only(left: 15, right: 15),
                                  child: widget.exam.subjectDet!.length > 0
                                      ? ListView.builder(
                                    itemBuilder: (context, index) =>
                                    index <
                                        widget.exam.subjectDet!.length
                                        ? allWeekly(widget.exam.subjectDet![index])
                                        : SizedBox(
                                      height: 200,
                                    ),
                                    itemCount:widget.exam.subjectDet!.length +
                                        1,
                                    shrinkWrap: true,
                                  )
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
        },
        listener: (context, state) {},
      ),
    );
  }


  Widget allWeekly(SubjectDet ass) {
    return InkWell(
      onTap: () {

      },
      child: Card(

        // elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding:CacheHelper.getBoolean(key: 'lang')
                .toString()
                .contains('ar') ?EdgeInsets.only(right: 20,):EdgeInsets.only(left: 20,),
            child: Container(
              decoration:  BoxDecoration(
                  color: Color(0xff3c92d0).withOpacity(.2),
                  borderRadius: BorderRadius.only(
                    topRight:CacheHelper.getBoolean(key: 'lang')
                        .toString()
                        .contains('ar') ?Radius.circular(0):Radius.circular(15),
                    bottomRight: CacheHelper.getBoolean(key: 'lang')
                        .toString()
                        .contains('ar') ?Radius.circular(0):Radius.circular(15),
                    topLeft: CacheHelper.getBoolean(key: 'lang')
                        .toString()
                        .contains('ar') ?Radius.circular(15):Radius.circular(0),
                    bottomLeft: CacheHelper.getBoolean(key: 'lang')
                        .toString()
                        .contains('ar') ?Radius.circular(15):Radius.circular(0)
                  )


              ),
              // color: Color(0xff3c92d0).withOpacity(.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [


                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:  EdgeInsets.only( top: 15, bottom: 20),
                            // alignment: Alignment.topLeft,
                              child: Text(ass.subjectName.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Nunito',
                                      fontSize: 18,
                                      color: Color(0xff222222)))),
                          SizedBox(
                            width: 1.w,
                          ),

                        ],
                      ),
                    ),
                  ),
                  Container(
                      // alignment: Alignment.topLeft,
                    // height: 80,
                      padding: EdgeInsets.only(left: 20,right: 20),
                      child: Row(
                        children: [
                          Text(ass.studentMark.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color(0xff3c92d0))),
                          Text(" / "+ass.maxMark.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color(0xff98aac9)))
                        ],
                      )),
                ],
              ),
            ),
          )),
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
              child: Text("No Mrak added",
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
