
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelExam.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';
import 'package:url_launcher/url_launcher.dart';

class Exams extends StatefulWidget {
  String std_id;

  Exams({required this.std_id});

  @override
  State<Exams> createState() => _ExamsState();
}

class _ExamsState extends State<Exams> {
  TextEditingController search = TextEditingController();
  List<ResultExam> list_exam_Search = [];
  bool flg = false;
  List<Widget> student = [];
  static List subject_odoo = [];

  @override
  void initState() {
    // TODO: implement initState
    onSearchTextChanged();
    super.initState();
  }

  onSearchTextChanged() async {
    list_exam_Search.clear();
    if (AppCubit.filter_subject.length <= 0) {
      setState(() {});
      return;
    }
    AppCubit.list_Exam.forEach((element) {
      if (AppCubit.filter_subject.contains(element.subject.toString())) {
        list_exam_Search.add(element);
      }
    });
    if (list_exam_Search.isEmpty) {
      flg = true;
    } else {
      flg = false;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    student.clear();
    for (int i = 0; i < AppCubit.list_st.length; i++) {
      //
      setState(() {
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) => Exams(
            std_id: AppCubit.list_st[i].id.toString(),
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));
      });
    }
    return BlocProvider(
      create: (context) => AppCubit()..getExam(widget.std_id),
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
                  MaterialPageRoute(builder: (context) => New_Detail()),
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

              appBar: CustomAppBar(
                  student, AppLocalizations.of(context).translate('Exams')),
              body: Container(
                color: Color(0xfff6f8fb),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                      alignment: Alignment.centerRight,
                      child: FilterOdoo(page: () {
                        AppCubit.subject_odoo=subject_odoo;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Filter_odoo_subject(page: 'exam'),
                            ));
                      })


                      ,
                    ),
                    AppCubit.list_Exam.length != 0 && !flg
                        ? Expanded(
                            child: list_exam_Search.length != 0 ||
                                    search.text.isNotEmpty
                                ? ListView.builder(
                                    itemBuilder: (context, index) =>index<list_exam_Search.length?
                                        ass(list_exam_Search[index]):SizedBox(height: 200,),
                                    itemCount: list_exam_Search.length+1,
                                    shrinkWrap: true,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) =>index<AppCubit.list_Exam.length?
                                        ass(AppCubit.list_Exam[index]):SizedBox(height: 200,),
                                    itemCount: AppCubit.list_Exam.length+1,
                                    shrinkWrap: true,
                                  ),
                          )
                        : Expanded(child: emptyAss()),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          subject_odoo=AppCubit.subject_odoo;
        },
      ),
    );
  }

  Widget ass(ResultExam ass) {
    AppCubit.subject_odoo.add(ass.subject.toString());
    AppCubit.subject_odoo = AppCubit.subject_odoo.toSet().toList();
    String startTime='';
    if(ass.startTime.toString().isNotEmpty && ass.startTime.toString()!='None' ){

    DateTime dt1 = DateFormat('dd MMM yyyy').parse( ass.startTime
        .toString());
    var formatter = DateFormat.yMMMd('ar_SA');
     startTime = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1): ass.startTime
        .toString();
          }
    return InkWell(
      child: ass.state.toString().contains('done')
          ? Card(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(
                        left: 15, right: 20, top: 15, bottom: 10),
                    elevation: 0,
                    child: Row(
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 0.0,
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor:
                                  Color(0xff3c92d0).withOpacity(.2),
                              child: SvgPicture.network(
                                'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Exams.svg',
                                color: Color(0xff3c92d0),
                                width: 5.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(ass.subject.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Color(0xff98aac9)))),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      // padding:EdgeInsets.only(right: 4),
                                      child:ass.examNameEnglish.toString()!='None'? Visibility(visible: ass.examNameEnglish.toString().isNotEmpty ||ass.examNameEnglish.toString()=='None' ,
                                        child: Container(
                                            width: 60,
                                            height: 20,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                                color: Color(0xfff9a200)),
                                            child: Text(
                                                ass.examNameEnglish.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Nunito',
                                                    fontSize: 14,
                                                    color: Colors.white))),
                                      ):Text(''),
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                  // alignment: Alignment.topLeft,
                                  child: Text(ass.name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          fontSize: 22,
                                          color: Colors.black))),
                              // SizedBox(height: 2,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('Deadline'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Text(
                                              startTime,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  color: Colors.black)))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Color(0xffbbc7db)),
                        color: Color(0xfff5f7fb)),
                    // color: Colors.red,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: SvgPicture.asset(
                                  "images/icons8_help.svg",
                                  color: Color(0xff707070),
                                  width: 15,
                                )),
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 8,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?8: 0),
                                child: Text(ass.questionsCount.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 15,
                                        color: Color(0xff707070)))),
                            Expanded(
                              child: Container(
                                  // margin: EdgeInsets.only(left: 2),
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('Questions'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 15,
                                          color: Color(0xff707070)))),
                            ),
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: SvgPicture.asset(
                                  "images/exam_marks11.svg",
                                  color: Color(0xff707070),
                                  width: 20,
                                )),
                            Container(
                                padding: EdgeInsets.all(8),
                                child: Text(ass.mark.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Color(0xff707070)))),
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('Marks'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                            color: Color(0xff707070))))),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: SvgPicture.asset(
                                  "images/exam_time11.svg",
                                  color: Color(0xff707070),
                                  width: 20,
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(ass.timeLimit.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Color(0xff707070)))),
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 0),
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('minutes'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                            color: Color(0xff707070))))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: MaterialButton(
                        child: Text(
                            AppLocalizations.of(context).translate('TEST_OVER'),
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Color(0xffa0a0a0))),
                        onPressed: () async {},
                      )),
                                ],
              ),
            )
          : Card(
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(
                        left: 15, right: 20, top: 15, bottom: 10),
                    elevation: 0,
                    child: Row(
                      children: [
                        Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          elevation: 0.0,
                          child: Container(
                            child: CircleAvatar(
                              backgroundColor:
                                  Color(0xff3c92d0).withOpacity(.2),
                              child: SvgPicture.network(
                                'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Exams.svg',
                                color: Color(0xff3c92d0),
                                width: 5.w,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(ass.subject.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Color(0xff98aac9)))),
                                  Expanded(
                                    child: Container(
                                      // alignment: Alignment.centerRight,
                                      child:ass.examNameEnglish.toString()!='None'? Container(
                                          width: 60,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)),
                                              color: Color(0xfff9a200)),
                                          child: Text(
                                             ass.examNameEnglish.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 14,
                                                  color: Colors.white))):Text(''),
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                  // alignment: Alignment.topLeft,
                                  child: Text(ass.name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          fontSize: 22,
                                          color: Colors.black))),
                              // SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('Deadline'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              startTime,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  color: Colors.black)))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Color(0xffbbc7db)),
                        color: Color(0xfff5f7fb)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: SvgPicture.asset(
                                  "images/icons8_help.svg",
                                  color: Color(0xff707070),
                                  width: 15,
                                )),
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: Text(ass.questionsCount.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Color(0xff707070)))),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 2,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?2: 0),
                                  padding: EdgeInsets.all(2),
                                  child: Text(
                                      AppLocalizations.of(context)
                                          .translate('Questions'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 15,
                                          color: Color(0xff707070)))),
                            ),
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: SvgPicture.asset(
                                  "images/exam_marks11.svg",
                                  color: Color(0xff707070),
                                  width: 20,
                                )),
                            Container(
                                padding: EdgeInsets.all(8),
                                child: Text(ass.mark.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Color(0xff707070)))),
                            Expanded(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    child: Text(AppLocalizations.of(context)
                                        .translate('Marks'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                            color: Color(0xff707070))))),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                                child: SvgPicture.asset(
                                  "images/exam_time11.svg",
                                  color: Color(0xff707070),
                                  width: 20,
                                )),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(ass.timeLimit.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Color(0xff707070)))),
                            Expanded(
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                        AppLocalizations.of(context)
                                            .translate('minutes'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito',
                                            fontSize: 14,
                                            color: Color(0xff707070))))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  ass.state.toString().contains('new')
                      ? Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 21),
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xff7cb13b),
                                    Color(0xff6d9c34)
                                  ]),
                              borderRadius: BorderRadius.circular(8)),
                          child: MaterialButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    AppLocalizations.of(context)
                                        .translate('START'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Colors.white)),
                              ],
                            ),
                            onPressed: () async {
                              openExamAndAss(ass.token.toString() ,  ass.answerToken.toString());
                              // var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
                              //     'survey/start/' +
                              //     ass.token.toString() +
                              //     '?answer_token=' +
                              //     ass.answerToken.toString());
                              //   await launch(url.toString(), headers: {
                              //     "X-Openerp-Session-Id":
                              //         CacheHelper.getBoolean(key: 'sessionId')
                              //   });

                            },
                          ))
                      : Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          height: 50,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color(0xfff9a200),
                                    Color(0xfff88c0b)
                                  ]),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xfff88c0b), blurRadius: 3)
                              ],
                              borderRadius: BorderRadius.circular(8)),
                          child: MaterialButton(
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    AppLocalizations.of(context)
                                        .translate('RESUME'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Colors.white)),
                              ],
                            ),
                            onPressed: () async {
                              openExamAndAss(ass.token.toString() ,  ass.answerToken.toString());
                              // var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
                              //     'survey/start/' +
                              //     ass.token.toString() +
                              //     '?answer_token=' +
                              //     ass.answerToken.toString());
                              //   await launch(url.toString(), headers: {
                              //     "X-Openerp-Session-Id":
                              //         CacheHelper.getBoolean(key: 'sessionId')
                              //   });

                            },
                          )),
                  Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                          ass.answeredQuestions.toString() +
                              "/" +
                              ass.questionsCount.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Nunito',
                              fontSize: 14,
                              color: Colors.black)))
                ],
              ),
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
            image: AssetImage("images/grades_pana.png"),
            width: 293,
            height: 239,
          )
              // CustomLotte('assets/lang/exam1.json'),

              ),
        ]),
      ),
    );
  }
}
