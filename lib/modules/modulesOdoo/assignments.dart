
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/assModel.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';
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
  String sessionId='';
  List<Widget> student = [];
  static List subject_odoo = [];
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
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) => Assignments(
            std_id: AppCubit.list_st[i].id.toString(),
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));

      });
    }
    return BlocProvider(
      create: (context) => AppCubit()..getAss(widget.std_id),
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
                        AppCubit.subject_odoo=subject_odoo;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Filter_odoo_subject(page: 'ass'),
                            ));
                      })
                      ,
                    ),
                    AppCubit.list_Ass.length != 0 && !flg
                        ? Expanded(
                            child: list_Ass_Search.length != 0
                                ? ListView.builder(
                                    itemBuilder: (context, index) =>index<list_Ass_Search.length?
                                        ass(list_Ass_Search[index]):SizedBox(height: 200,),
                                    itemCount: list_Ass_Search.length+1,
                                    shrinkWrap: true,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) =>index<AppCubit.list_Ass.length?
                                        ass(AppCubit.list_Ass[index]):SizedBox(height: 200,),
                                    itemCount: AppCubit.list_Ass.length+1,
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
        listener: (context, state) {
          AppCubit.subject_odoo=subject_odoo;
        },
      ),
    );
  }

  Widget ass(ResultAss ass) {
    AppCubit.subject_odoo.add(ass.subject.toString());
    AppCubit.subject_odoo = AppCubit.subject_odoo.toSet().toList();
    Color color_text = Colors.black;
    String deadline ='';
    if(ass.deadline.toString().isNotEmpty){
      print(ass.deadline.toString());
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
            openExamAndAss(ass.token.toString() ,  ass.answerToken.toString());
            // var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
            //     'survey/start/' +
            //     ass.token.toString() +
            //     '?answer_token=' +
            //     ass.answerToken.toString());
            //
            // await launchUrl(url,
            //     webViewConfiguration: WebViewConfiguration(headers: {
            //       "X-Openerp-Session-Id":sessionId,
            //       "session_id":sessionId,
            //     }));
          },
        ));
    if (ass.state.toString().contains('done')) {
      color_text = Colors.black.withOpacity(.5);

      color_Textbutton = Colors.white.withOpacity(.5);
      button = Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.center,
                  colors: [Color(0xffa0a0a0), Color(0xffa0a0a0)]),
              boxShadow: [BoxShadow(color: Color(0xffa0a0a0), blurRadius: 3)],
              borderRadius: BorderRadius.circular(8)),
          width: double.infinity,
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
              openExamAndAss(ass.token.toString() ,  ass.answerToken.toString());
              // var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
              //     'survey/start/' +
              //     ass.token.toString() +
              //     '?answer_token=' +
              //     ass.answerToken.toString());
              //   await launch(url.toString(), headers: {
              //     "X-Openerp-Session-Id":
              //     sessionId,
              //     "session_id":sessionId,
              //   });
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
              openExamAndAss(ass.token.toString() ,  ass.answerToken.toString());
              // var url = Uri.parse(CacheHelper.getBoolean(key: 'base_url') +
              //     'survey/start/' +
              //     ass.token.toString() +
              //     '?answer_token=' +
              //     ass.answerToken.toString());
              //   await launch(url.toString(), headers: {
              //     "X-Openerp-Session-Id":
              //         CacheHelper.getBoolean(key: 'sessionId'),
              //     "session_id":CacheHelper.getBoolean(key: 'sessionId'),
              //   });

            },
          ));
    }

    return InkWell(
        child: Card(
      margin: EdgeInsets.only(bottom: 10),

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

}
