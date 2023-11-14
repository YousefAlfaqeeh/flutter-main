import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/assModel.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';

import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class Assignments extends StatefulWidget {
  String std_id;

  Assignments({required this.std_id});

  @override
  State<Assignments> createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  TextEditingController search = TextEditingController();
  List<ResultAss> list_Ass_Search = [];
  bool flg = false;
  List<Widget> student = [];

  @override
  void initState() {
    // TODO: implement initState
    onSearchTextChanged();
    super.initState();
  }

  onSearchTextChanged() async {
    list_Ass_Search.clear();
    if (AppCubit.filter_subject.length <= 0) {
      setState(() {});
      return;
    }
    AppCubit.list_Ass.forEach((element) {
      // print('dddd');
      // print(AppCubit.filter_subject.contains(element.subject.toString()));
      if (AppCubit.filter_subject.contains(element.subject.toString())) {
        list_Ass_Search.add(element);
      }
    });
    if (list_Ass_Search.isEmpty) {
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
        student.add(student_list(i, AppCubit.list_st[i]));
      });
    }
    return BlocProvider(
      create: (context) => AppCubit()..getAss(widget.std_id),
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
              //               // AppCubit.filter_subject=[];
              //               // AppCubit.subject_odoo=[];
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
              //             child: Text('Assignments',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
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
              appBar: CustomAppBar(student,
                  AppLocalizations.of(context).translate('Assignments')),
              body: Container(
                color: Color(0xfff6f8fb),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                      alignment: Alignment.centerRight,
                      child: FilterOdoo(page: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Filter_odoo_subject(page: 'ass'),
                            ));
                      })
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   children: [
                      //     Container(
                      //       // color: Colors.red,
                      //       child: Text('Filter', style: TextStyle(
                      //           fontWeight: FontWeight.normal,
                      //           fontSize: 13,
                      //
                      //           fontFamily: 'Nunito',
                      //           color: Color(0xff222222))),
                      //     ),
                      //     IconButton(onPressed: () {
                      //
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => Filter_odoo_subject(page: 'ass'),
                      //           ));
                      //
                      //     }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),),
                      //   ],
                      // )
                      ,
                    ),
                    AppCubit.list_Ass.length != 0 && !flg
                        ? Expanded(
                            child: list_Ass_Search.length != 0
                                ? ListView.builder(
                                    itemBuilder: (context, index) =>
                                        ass(list_Ass_Search[index]),
                                    itemCount: list_Ass_Search.length,
                                    shrinkWrap: true,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) =>
                                        ass(AppCubit.list_Ass[index]),
                                    itemCount: AppCubit.list_Ass.length,
                                    shrinkWrap: true,
                                  ),
                          )
                        : Expanded(
                            child: CustomEmpty(
                                "images/no_assignments.png",  AppLocalizations.of(context).translate('no_Assignments'))
                            // emptyAss()
                            ),
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

  Widget ass(ResultAss ass) {
    AppCubit.subject_odoo.add(ass.subject.toString());
    AppCubit.subject_odoo = AppCubit.subject_odoo.toSet().toList();
    Color color_text = Colors.black;
    // Decoration color_button =BoxDecoration(
    //
    //
    //     gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.topLeft,colors: [
    //       Color(0xff7cb13b),
    //       Color(0xff6d9c34)
    //
    //     ]),
    //     boxShadow: [BoxShadow(color: Color(0xff7cb13b),blurRadius: 3)],
    //
    //     borderRadius: BorderRadius.circular(40));
    String deadline ='';
    if(ass.deadline.toString().isNotEmpty){
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.deadline.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
     deadline = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.deadline.toString();}
    Color color_Textbutton = Colors.white;
    Widget button = Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        height: 40,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.topLeft,
                colors: [Color(0xff7cb13b), Color(0xff6d9c34)]),
            boxShadow: [BoxShadow(color: Color(0xff7cb13b), blurRadius: 3)],
            borderRadius: BorderRadius.circular(40)),
        width: 232,

        // color: Colors.orange,
        child: MaterialButton(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(Icons.play_circle,color: Colors.white,),
              // SizedBox(width: 10,),
              Text(AppLocalizations.of(context).translate('START'),
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Colors.white)),
            ],
          ),
          onPressed: () async {
            //'https://tst.tracking.trackware.com/survey/fill/
            //http://192.168.1.150:9098/survey/fill/935cea9f-3bc6-4f2f-bb7f-92eb63742e0e/6cd1a907-3582-4b37-b36a-9ba1e49ee996
            // var url=Uri.parse('http://192.168.1.150:9098/survey/fill/935cea9f-3bc6-4f2f-bb7f-92eb63742e0e/6cd1a907-3582-4b37-b36a-9ba1e49ee996');

            var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
                'survey/fill/' +
                ass.token.toString() +
                '/' +
                ass.answerToken.toString());
            // var url=Uri.parse( CacheHelper.getBoolean(key: 'base_url')+'my/Assignments/130');

            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => WebView_Login( 'https://tst.tracking.trackware.com/survey/fill/'+ ass.token.toString()+'/'+ass.answerToken.toString()),
            //     ));

            // if(await canLaunchUrl(url))
            // {
            // print(await canLaunchUrl(url));

            //   // await launchUrl(url);
            await launchUrl(url,
                webViewConfiguration: WebViewConfiguration(headers: {
                  "X-Openerp-Session-Id":
                      CacheHelper.getBoolean(key: 'sessionId')
                }));

            // await launch(
            //     url.toString(),enableDomStorage: true,enableJavaScript: true,forceSafariVC: false,universalLinksOnly: true,
            //     headers: {
            //   "X-Openerp-Session-Id":
            //   CacheHelper.getBoolean(key: 'sessionId')
            // }
            // );
            // }
          },
        ));
    if (ass.state.toString().contains('done')) {
      color_text = Colors.black.withOpacity(.5);

      color_Textbutton = Colors.white.withOpacity(.5);
      button = Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          // padding: EdgeInsets.only(left: 15.0),
          // height: 40,

          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.center,
                  colors: [Color(0xffa0a0a0), Color(0xffa0a0a0)]),
              boxShadow: [BoxShadow(color: Color(0xffa0a0a0), blurRadius: 3)],
              borderRadius: BorderRadius.circular(8)),
          width: double.infinity,
          // alignment: Alignment.center,

          // color: Colors.orange,
          child: MaterialButton(
            child: Text(AppLocalizations.of(context).translate('Submited'),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: color_Textbutton)),
            onPressed: () async {},
          ));
    } else if (ass.state.toString().contains('new')) {
      button = Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [Color(0xff7cb13b), Color(0xff6d9c34)]),
              boxShadow: [BoxShadow(color: Color(0xff7cb13b), blurRadius: 3)],
              borderRadius: BorderRadius.circular(8)),
          width: double.infinity,

          // color: Colors.orange,
          child: MaterialButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.play_circle,color: Colors.white,),
                // SizedBox(width: 10,),
                Text(AppLocalizations.of(context).translate('START'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: Colors.white)),
              ],
            ),
            onPressed: () async {
              //'https://tst.tracking.trackware.com/survey/fill/
              //http://192.168.1.150:9098/survey/fill/935cea9f-3bc6-4f2f-bb7f-92eb63742e0e/6cd1a907-3582-4b37-b36a-9ba1e49ee996
              // var url=Uri.parse('http://192.168.1.150:9098/survey/fill/935cea9f-3bc6-4f2f-bb7f-92eb63742e0e/6cd1a907-3582-4b37-b36a-9ba1e49ee996');

              // var url=Uri.parse( CacheHelper.getBoolean(key: 'base_url')+'survey/fill/'+ ass.token.toString()+'/'+ass.answerToken.toString());
              // var url=Uri.parse( CacheHelper.getBoolean(key: 'base_url')+'my/Assignments/130');

              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => WebView_Login( 'https://tst.tracking.trackware.com/survey/fill/'+ ass.token.toString()+'/'+ass.answerToken.toString()),
              //     ));

              // if(await canLaunchUrl(url))
              // {
              // print(await canLaunchUrl(url));

              //   // await launchUrl(url);
              var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
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
              // await launchUrl(url,webViewConfiguration: WebViewConfiguration(headers: {
              //   "X-Openerp-Session-Id":
              //   CacheHelper.getBoolean(key: 'sessionId')
              // }
              //
              // ));

              // await launch(
              //     url.toString(),enableDomStorage: true,enableJavaScript: true,forceSafariVC: false,universalLinksOnly: true,
              //     headers: {
              //   "X-Openerp-Session-Id":
              //   CacheHelper.getBoolean(key: 'sessionId')
              // }
              // );
              // }
            },
          ));
    } else {
      button = Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          // height: 40,

          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [Color(0xfff9a200), Color(0xfff88c0b)]),
              boxShadow: [BoxShadow(color: Color(0xfff88c0b), blurRadius: 3)],
              borderRadius: BorderRadius.circular(8)),
          width: double.infinity,

          // color: Colors.orange,
          child: MaterialButton(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.arrow_back,color: Colors.white,),
                // SizedBox(width: 10,),
                Text(AppLocalizations.of(context).translate('RESUME'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: Colors.white)),
              ],
            ),
            onPressed: () async {
              var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
                  'survey/fill/' +
                  ass.token.toString() +
                  '/' +
                  ass.answerToken.toString());
              // var url=Uri.parse('https://tst.tracking.trackware.com/survey/fill/'+ ass.token.toString()+'/'+ass.answerToken.toString());
              if (await canLaunchUrl(url)) {
                // print(CacheHelper.getBoolean(key: 'sessionId'));
                // await launchUrl(url);
                await launch(url.toString(), headers: {
                  "X-Openerp-Session-Id":
                      CacheHelper.getBoolean(key: 'sessionId')
                });
              }
            },
          ));
    }

    return InkWell(
        child: Card(
      margin: EdgeInsets.only(bottom: 10),
      // margin: EdgeInsets.all(20),
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
            elevation: 0,
            child: Row(
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                      side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  elevation: 0.0,
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                      child: SvgPicture.network(
                        'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',
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
                        ],
                      ),
                      Container(
                          // alignment: Alignment.topLeft,
                          child: Text(ass.name.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 22,
                                  color: color_text))),
                      SizedBox(
                        height: 12,
                      ),
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
                                  color: color_text)),
                          SizedBox(
                            width: 1.w,
                          ),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(deadline,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: color_text)))),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          button,
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(ass.answeredQuestions.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Colors.black)),
                  Text("/" + ass.questionsCount.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.black.withOpacity(.5))),
                ],
              ))
        ],
      ),
    ));
  }

  // Widget emptyAss()
  // {
  //   return Container(
  //     alignment: Alignment.center,
  //
  //     child:
  //     Padding(
  //       padding: EdgeInsets.symmetric(vertical: 50),
  //       child: Column(children: [
  //         Expanded(child: Image(image: AssetImage("images/no_assignments.png") ,width: 293,height: 239,)),
  //         SizedBox(height: 10,),
  //         // Expanded(child: Text("No Assignments added",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0).withOpacity(.5)))),
  //         Text("No Assignments ",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
  //         SizedBox(height: 10,),
  //         InkWell(onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => New_Detail()),
  //           );
  //         },
  //             child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
  //       ]),
  //     )
  //     ,);
  // }

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          AppCubit.stutes_notif_odoo = '';
          AppCubit.school_image = listDetail1.schoolImage.toString();
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
              builder: (context) => Assignments(
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
}
