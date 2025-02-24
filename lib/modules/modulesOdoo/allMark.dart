import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/markMod.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/examMark.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';

class All_mark extends StatefulWidget {
  String std_id,image;

  All_mark({required this.std_id,required this.image});

  @override
  State<All_mark> createState() => _All_markState();
}

class _All_markState extends State<All_mark> {
  int len = 0;

  List<Widget> student = [];
  String name='';

  @override
  void initState() {
    if(AppCubit.allExam.length > 0)
      {
        setState(() {
          name=AppCubit.allExam[len].semester
              .toString();
        });
      }

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
            std_id:  AppCubit.list_st[i].id.toString(),image: widget.image,
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
                    builder: (context) => New_Detail(),
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

              appBar: CustomAppBar(student,
                  AppLocalizations.of(context).translate('mark')),
              body: SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [

                                Container(
                                    width: 150,
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppCubit.code_yesr,
                                      style: TextStyle(
                                          color: Color(0xff3c92d0),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),

                              ],
                            )),
                        Container(
                          width: double.infinity,
                            height: 8.h,
                            padding: EdgeInsets.all(10),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                              index <AppCubit.allExam.length
                                  ?allTerm(index, AppCubit.allExam[index].semester.toString())
                                  : SizedBox(
                                width: 100,
                              ),
                              itemCount:  AppCubit.allExam.length +1,
                              shrinkWrap: true,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff5f7fb),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      MediaQuery.of(context).size.width / 7.2),
                                  topRight: Radius.circular(
                                      MediaQuery.of(context).size.width / 7.2),
                                )),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Expanded(
                                  child: Container(
                                    // padding:
                                    // EdgeInsets.only(left: 15, right: 15),
                                    child:  AppCubit.allExam.length>0 ?AppCubit.allExam[len].exam!.length > 0
                                        ? ListView.builder(
                                            itemBuilder: (context, index) =>
                                                index <
                                                        AppCubit.allExam[len]
                                                            .exam!.length
                                                    ? allWeekly(AppCubit
                                                        .allExam[len]
                                                        .exam![index])
                                                    : SizedBox(
                                                        height: 250,
                                                      ),
                                            itemCount: AppCubit
                                                    .allExam[len].exam!.length +
                                                1,
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
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
  Widget allWeekly(Exam ass) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EaxmMark(std_id: widget.std_id, name: AppCubit.allExam[len].semester.toString(), exam: ass,image: widget.image,)),
        );
      },
      child: Card(
          // elevation: 0,
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  elevation: 0.0,
                  child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                      child: widget.image.isEmpty?SvgPicture.asset(
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
                              ? ass.examNameAr.toString()
                              : ass.examNameEn.toString(),
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
            ),
          )),
    );
  }
  Widget allTerm(int index ,String name){
    Color color_Container = index ==len?Color(0xff3c92d0):Colors.white;
    Color color_text = index ==len?Colors.white:Colors.grey.shade600;
    // Text

    return InkWell(
onTap: () {
  setState(() {
    len=index;
  });
},
        child: Container(
          margin: EdgeInsets.only(right: 10,left: 10),
          alignment: Alignment.center,
            width: 35.w,
            decoration: BoxDecoration(color:color_Container,borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Text(name,style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
                fontSize: 12,
                color: color_text),)));
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
                image: AssetImage("images/grades_pana.png"),
                width: 293,
                height: 239,
              ),
            ),
          ),
          Expanded(
              child: Text(AppLocalizations.of(context).translate('no_mraks_added'),
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
