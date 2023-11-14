import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';

import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelExam.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/notification/filter_odoo.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
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
      // print('dddd');
      // print(AppCubit.filter_subject.contains(element.subject.toString()));
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

  // onSearchTextChanged(String text)async
  // {
  //   list_exam_Search.clear();
  //   if(text.isEmpty)
  //   {
  //     setState(() {
  //
  //     });
  //     return;
  //   }
  //   AppCubit.list_Exam.forEach((element) {
  //     if(element.name.toString().contains(text)||element.subject.toString().contains(text))
  //     {
  //       list_exam_Search.add(element);
  //     }
  //   });
  //   if(list_exam_Search.isEmpty)
  //   {
  //     flg=true;
  //   }
  //   else
  //   {
  //     flg=false;
  //   }
  //   setState(() {
  //
  //
  //   });
  // }
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
      create: (context) => AppCubit()..getExam(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Reset.clear_searhe();
              // AppCubit.filter_subject=[];
              // AppCubit.subject_odoo=[];
              // AppCubit.stutes_notif_odoo='';
              // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
              // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
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

              // appBar: AppBar(
              //   toolbarHeight: 75,
              //   backgroundColor:Colors.white,
              //   leadingWidth: double.infinity/4,
              //   leading: Padding(
              //     padding:EdgeInsets.only(left: 5,top: 20,bottom: 10,right: 0),
              //     // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
              //     child: Container(
              //
              //       child: Row(
              //         // mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           IconButton(
              //             onPressed: () {
              //               Reset.clear_searhe();
              //               // AppCubit.filter_subject=[];
              //               // AppCubit.subject_odoo=[];
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
              //             child: Text('Exams',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
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
              appBar: CustomAppBar(
                  student, AppLocalizations.of(context).translate('Exams')),
              body: Container(
                color: Color(0xfff6f8fb),
                child: Column(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   color: Colors.blue[700],
                    //   child:
                    //   Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 50,left: 20),
                    //
                    //         child: Row(children: [
                    //           IconButton(
                    //             onPressed: () {
                    //               Navigator.pop(context);
                    //             },
                    //             icon: Container(
                    //                 width: 13.58,
                    //                 height: 22.37,
                    //                 padding: EdgeInsetsDirectional.only(end: 2),
                    //                 child: SvgPicture.asset("images/chevron_left_solid.svg")),
                    //           ),
                    //           Container(padding: EdgeInsets.all(3),child: SvgPicture.asset("images/edit_solid.svg"),),
                    //           Container(
                    //               padding: EdgeInsets.symmetric(horizontal: 20),
                    //               alignment: Alignment.centerLeft, child: Text("Exams",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
                    //         ],),
                    //       ),
                    //
                    //       Container(
                    //           padding: EdgeInsets.only(top: 20,bottom: 20),
                    //           margin: const EdgeInsets.symmetric(
                    //               horizontal: 30),
                    //           child: Row(
                    //             children: [
                    //
                    //               Expanded(
                    //                 child: SizedBox(
                    //                   width: 284,
                    //                   child: TextFormField(
                    //                     controller: search,
                    //                     onChanged:  onSearchTextChanged,
                    //                     decoration: InputDecoration(
                    //
                    //                         filled: true,
                    //                         fillColor: Colors.white,
                    //                         prefixIcon: const Icon(Icons.search,size: 35),
                    //
                    //                         enabledBorder: OutlineInputBorder(
                    //                             borderSide: const BorderSide(
                    //                                 color: Colors.white),
                    //                             borderRadius:
                    //                             BorderRadius.circular(15)),
                    //                         border: OutlineInputBorder(
                    //                             borderSide: const BorderSide(
                    //                                 color: Colors.white),
                    //                             borderRadius:
                    //                             BorderRadius.circular(15))),
                    //
                    //
                    //                   ),
                    //                 ),
                    //               ),
                    //               SizedBox(width: 10,),
                    //               Container(
                    //                   height: 57,
                    //                   width: 57,
                    //                   decoration: BoxDecoration(
                    //
                    //                       gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.topLeft,colors: [
                    //                         Colors.white,
                    //                         Colors.white
                    //
                    //                       ]),
                    //
                    //
                    //                       borderRadius: BorderRadius.circular(10)),
                    //                   child: InkWell(onTap: () {
                    //
                    //                   },child:Container(
                    //
                    //                       padding: EdgeInsets.all(15),
                    //                       child: SvgPicture.asset("images/filter_solid.svg")) ,))
                    //             ],
                    //           )),
                    //
                    //     ],
                    //   ),
                    // ),
                    // ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                      alignment: Alignment.centerRight,
                      child: FilterOdoo(page: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Filter_odoo_subject(page: 'exam'),
                            ));
                      })

                      // IconButton(onPressed: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Filter_odoo_subject(page: 'exam'),
                      //       ));
                      //
                      // }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),)
                      ,
                    ),
                    AppCubit.list_Exam.length != 0 && !flg
                        ? Expanded(
                            child: list_exam_Search.length != 0 ||
                                    search.text.isNotEmpty
                                ? ListView.builder(
                                    itemBuilder: (context, index) =>
                                        ass(list_exam_Search[index]),
                                    itemCount: list_exam_Search.length,
                                    shrinkWrap: true,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) =>
                                        ass(AppCubit.list_Exam[index]),
                                    itemCount: AppCubit.list_Exam.length,
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
        listener: (context, state) {},
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
              // margin: EdgeInsets.all(20),
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                              // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
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
                  // Container(
                  //   padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  //   alignment: Alignment.topLeft,
                  //
                  //   child: Container(
                  //       width: 130,
                  //       decoration:
                  //       BoxDecoration(borderRadius: BorderRadius.circular(8 ),color:Color(0xff3b8fcd) ),
                  //       // color:Color(0xff3b8fcd),
                  //       margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                  //       alignment: Alignment.center,
                  //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //       child: Text( ass.examNameEnglish.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.white))),
                  // ),

                  // Container(margin: EdgeInsets.symmetric(horizontal: 18),alignment: Alignment.centerLeft,
                  //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //     child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Colors.black))),

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
                            // Container( margin: EdgeInsets.only(left: 16),
                            //     child: Icon(Icons.timer_sharp
                            //       ,size: 14,color:  Color(0xff707070),)),
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
                  // Container(
                  //   padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  //   alignment: Alignment.topLeft,
                  //
                  //   child: Container(
                  //       width: 130,
                  //       decoration:
                  //       BoxDecoration(borderRadius: BorderRadius.circular(8 ),color:Color(0xff3b8fcd) ),
                  //       // color:Color(0xff3b8fcd),
                  //       margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                  //       alignment: Alignment.center,
                  //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //       child: Text( ass.examNameEnglish.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.white))),
                  // ),
                  //
                  // Container(margin: EdgeInsets.symmetric(horizontal: 18),alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Colors.black.withOpacity(.5)))),
                  //
                  // Row(
                  //   children: [
                  //
                  //
                  //     Container( margin: EdgeInsets.only(left: 30),
                  //         child: Icon(Icons.question_mark,size: 14,color:  Color(0xff707070),)),
                  //     Container( margin: EdgeInsets.only(left: 2),
                  //         child: Text(ass.questionsCount.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff707070)))),
                  //     Expanded(
                  //       child: Container( margin: EdgeInsets.only(left: 2),
                  //           padding: EdgeInsets.all(8), child: Text("Questions",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff707070)))),
                  //     ),
                  //     Container(
                  //         padding: EdgeInsets.all(8), child: Icon(Icons.format_list_bulleted_rounded,size: 14,color:  Color(0xff707070),)),
                  //     Container(
                  //         padding: EdgeInsets.all(8), child: Text(ass.mark.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff707070)))),
                  //     Expanded(
                  //         child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( "Marks",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Color(0xff707070))))),
                  //
                  //
                  //   ],
                  // ),
                  //
                  // Row(
                  //   children: [
                  //
                  //     Container( margin: EdgeInsets.only(left: 30),
                  //         child: Icon(Icons.timer_sharp
                  //           ,size: 14,color:  Color(0xff707070),)),
                  //     Container(
                  //         padding: EdgeInsets.all(8), child: Text(ass.timeLimit.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff707070)))),
                  //     Expanded(
                  //         child:Container(padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),child: Text( "minutes",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Color(0xff707070))))),
                  //
                  //   ],
                  // ),
                  //
                  //
                  // Row(
                  //   children: [
                  //
                  //
                  //
                  //     Container( margin: EdgeInsets.only(left: 30),
                  //         padding: EdgeInsets.all(8), child: Text("Subject",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black.withOpacity(.5)))),
                  //
                  //     Expanded(
                  //         child:Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text( ass.subject.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.black.withOpacity(.5))))),
                  //
                  //
                  //   ],
                  // ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // Row(
                  //   children: [
                  //
                  //
                  //     Container(
                  //         alignment: Alignment.centerLeft,
                  //         margin: EdgeInsets.only(left: 30),
                  //         padding: EdgeInsets.all(8), child: Text("Deadline",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black.withOpacity(.5)))),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 15.0),
                  //       child: Icon(Icons.calendar_today,color: Color(0xff3c92d0).withOpacity(.5),size: 15,),
                  //     ),
                  //     Expanded(child: Container(alignment: Alignment.centerLeft, margin: EdgeInsets.only(left: 15),padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),child: Text(ass.startTime.toString(),style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0).withOpacity(.5)))))
                  //   ],
                  // ),
                  Container(
                      // margin:EdgeInsets.only(left:40) ,
                      // padding: EdgeInsets.only(left: 15.0),
                      height: 50,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      // decoration: BoxDecoration(
                      //
                      //
                      //     gradient: LinearGradient(begin: Alignment.center,end: Alignment.center,colors: [
                      //       Color(0xffa0a0a0),
                      //       Color(0xffa0a0a0)
                      //
                      //     ]),
                      //     boxShadow: [BoxShadow(color: Color(0xffa0a0a0),blurRadius: 3)],
                      //
                      //     borderRadius: BorderRadius.circular(8)),
                      // width: 232,
                      // alignment: Alignment.center,

                      // color: Colors.orange,
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
                  // Container(alignment: Alignment.center,padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text(ass.answeredQuestions.toString()+"/"+ass.questionsCount.toString(),style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0).withOpacity(.5))))
                ],
              ),
            )
          : Card(
              // margin: EdgeInsets.all(20),
              // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                              // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
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
                  // Container(
                  //   padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  //   alignment: Alignment.topLeft,
                  //
                  //   child: Container(
                  //       width: 130,
                  //       decoration:
                  //       BoxDecoration(borderRadius: BorderRadius.circular(8 ),color:Color(0xff3b8fcd) ),
                  //       // color:Color(0xff3b8fcd),
                  //       margin: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                  //       alignment: Alignment.center,
                  //       padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //       child: Text( ass.examNameEnglish.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.white))),
                  // ),

                  // Container(margin: EdgeInsets.symmetric(horizontal: 18),alignment: Alignment.centerLeft,
                  //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  //     child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Colors.black))),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Color(0xffbbc7db)),
                        color: Color(0xfff5f7fb)),
                    // color: Colors.red,
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

                  // Row(
                  //   children: [
                  //
                  //
                  //
                  //     Container( margin: EdgeInsets.only(left: 30),
                  //         padding: EdgeInsets.all(8), child: Text("Subject",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),
                  //
                  //     Expanded(
                  //         child:Container(padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text( ass.subject.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.black)))),
                  //
                  //
                  //   ],
                  // ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // Row(
                  //   children: [
                  //
                  //
                  //     Container(
                  //         alignment: Alignment.centerLeft,
                  //         margin: EdgeInsets.only(left: 30),
                  //         padding: EdgeInsets.all(8), child: Text("Deadline",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),
                  //     Padding(
                  //       padding: const EdgeInsets.only(left: 15.0),
                  //       child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 15,),
                  //     ),
                  //     Expanded(child: Container(alignment: Alignment.centerLeft, margin: EdgeInsets.only(left: 15),padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),child: Text(ass.startTime.toString(),style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))))
                  //   ],
                  // ),
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
                              // boxShadow: [BoxShadow(color: Color(0xff7cb13b),blurRadius: 3)],

                              borderRadius: BorderRadius.circular(8)),
                          // width: 232,

                          // color: Colors.orange,
                          child: MaterialButton(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.play_circle,color: Colors.white,),
                                // SizedBox(width: 10,),
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
                              var url = Uri.parse(
                                  CacheHelper.getBoolean(key: 'base_url') +
                                      'survey/fill/' +
                                      ass.token.toString() +
                                      '/' +
                                      ass.answerToken.toString());
                              if (await canLaunchUrl(url)) {
                                // print(CacheHelper.getBoolean(key: 'sessionId'));
                                // await launchUrl(url);
                                await launch(url.toString(), headers: {
                                  "X-Openerp-Session-Id":
                                      CacheHelper.getBoolean(key: 'sessionId')
                                });
                              }
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
                          // width: 232,

                          // color: Colors.orange,
                          child: MaterialButton(
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(Icons.arrow_back,color: Colors.white,),
                                // SizedBox(width: 10,),
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
                              var url = Uri.parse(
                                  CacheHelper.getBoolean(key: 'base_url') +
                                      'survey/fill/' +
                                      ass.token.toString() +
                                      '/' +
                                      ass.answerToken.toString());
                              if (await canLaunchUrl(url)) {
                                // print(CacheHelper.getBoolean(key: 'sessionId'));
                                // await launchUrl(url);
                                await launch(url.toString(), headers: {
                                  "X-Openerp-Session-Id":
                                      CacheHelper.getBoolean(key: 'sessionId')
                                });
                              }
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

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          AppCubit.school_image = listDetail1.schoolImage.toString();
          AppCubit.stutes_notif_odoo = '';

          listFeatures1.clear();
          // if(listDetail1.changeLocation=true)
          // {
          //
          //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
          //
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
              builder: (context) => Exams(
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
