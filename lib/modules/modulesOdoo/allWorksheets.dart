import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/getAllWorksheet.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/formWorkSheet.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';

class AllWorksheets extends StatefulWidget {
  String std_id;

  AllWorksheets({required this.std_id});

  @override
  State<AllWorksheets> createState() => _AllWorksheetsState();
}

class _AllWorksheetsState extends State<AllWorksheets> {
  TextEditingController search = TextEditingController();
  List<ResultAllWorksheet> list_Ass_Search = [];
  List<ResultAllWorksheet> list_allWorkSheet = [];
  bool flg = false;
  List<Widget> student = [];
  GlobalKey<ScaffoldState> sc = GlobalKey<ScaffoldState>();
  late List<bool> isChecked;
  late List<String> subjectdrawer = [];
  static List subject_odoo = [];

  @override
  void initState() {
    // TODO: implement initState
    onSearchTextChanged();
    super.initState();

    // isChecked=List.filled(subjectdrawer.length, false);
  }

  onSearchTextChanged() async {

    list_Ass_Search.clear();
    if (AppCubit.filter_subject.length <= 0) {
      setState(() {});
      return;
    }
    AppCubit.list_allWorkSheet.forEach((element) {

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
      setState(() {
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) =>AllWorksheets(
            std_id: AppCubit.list_st[i].id.toString(),
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));
      });
    }
    return BlocProvider(
      create: (context) => AppCubit()..getAllWorksheets(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: ()async {
              Reset.clear_searhe();
              if(AppCubit.back_home) {
                AppCubit.back_home=false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Hiome_Kids()),
                );
              }
              else {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => New_Detail()),
                );
              }
              return false;
            },
            child: Scaffold(
              key: sc,
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
              appBar: CustomAppBar(student, AppLocalizations.of(context).translate('Homework')),
              body: Container(
                color: Color(0xfff6f8fb),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                      alignment: Alignment.centerRight,
                      child: FilterOdoo(page: () async {
                        AppCubit.subject_odoo=subject_odoo;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Filter_odoo_subject(page: 'work'),
                            ));

                      })

                      ,
                    ),

                    AppCubit.list_allWorkSheet.length != 0 && !flg
                        ? Expanded(
                            child: list_Ass_Search.length != 0
                                ? ListView.builder(
                                    itemBuilder: (context, index) =>index<list_Ass_Search.length?
                                        allWorkSheet(list_Ass_Search[index]):SizedBox(height: 100,),
                                    itemCount: list_Ass_Search.length+1,
                                    shrinkWrap: true,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) =>index<list_allWorkSheet.length? allWorkSheet(
                                        list_allWorkSheet[index]):SizedBox(height: 100,),
                                    itemCount: list_allWorkSheet.length+1,
                                    shrinkWrap: true,
                                  ),
                          )
                        : Expanded(
                            child: CustomEmpty(
                                "images/no_worksheets.png", AppLocalizations.of(context).translate('No_Worksheets'))
                            // emptyWorkSheet()

                            ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          subject_odoo=AppCubit.subject_odoo;
          list_allWorkSheet=AppCubit.list_allWorkSheet;
        },
      ),
    );
  }

  Widget allWorkSheet(ResultAllWorksheet work) {

    AppCubit.subject_odoo.add(work.subject.toString());

    AppCubit.subject_odoo = AppCubit.subject_odoo.toSet().toList();

    // work.date.toString()
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(work.date.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String date = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):work.date.toString();

    String deadline='';
    if(work.deadline.toString().isNotEmpty){
      var formatter_time = DateFormat.Hms('ar_SA');
    DateTime d = DateFormat('dd MMM yyyy hh:mm:ss').parse(work.deadline.toString());
    deadline= CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(d)+' '+formatter_time.format(d):work.deadline.toString();


    }

    if (work.finish != 'True') {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FormWorksheets(std_id: work.worksheetId.toString())),
          );
        },
        child: Card(
          margin: EdgeInsets.only(bottom: 15),
          //
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Card(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                elevation: 0,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      // color: Colors.red,
                      height: 100,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            side:
                                BorderSide(width: .8, color: Color(0xffd4ddee)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0))),
                        elevation: 0.0,
                        child: Container(
                          child: CircleAvatar(
                            backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                            child: SvgPicture.network(
                              'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Worksheets.svg',
                              color: Color(0xff3c92d0),
                              width: 5.w,
                            ),
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
                                  child: Text(work.name.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                          color: Colors.black))),
                              Expanded(
                                child: Container(
                                  alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                                  // padding:EdgeInsets.only(right: 4),
                                  child: Container(
                                      width: 80,
                                      height: 20,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: work.finish == 'True'
                                              ? Color(0xff7cb13b)
                                              : Color(0xfff9a200)),
                                      child: Text(
                                          work.finish == 'True'
                                              ? AppLocalizations.of(context).translate('Submitted')
                                              : AppLocalizations.of(context).translate('New'),
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
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(work.subject.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Nunito',
                                          fontSize: 18,
                                          color: Color(0xff3c92d0)))),

                            ],
                          ),
                          //work.subject.toString()
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(AppLocalizations.of(context).translate('Published_Date'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Nunito',
                                      fontSize: 16,
                                      color: Colors.black)),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  // alignment: Alignment.topLeft,
                                  child: Text(date,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: Colors.black))),
                            ],
                          ),
                          // SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(AppLocalizations.of(context).translate('Deadline'),
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
                                          horizontal: 10, vertical: 10),
                                      child: Text(deadline,
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

              // SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
      );
    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FormWorksheets(std_id: work.worksheetId.toString())),
        );
      },
      child: Card(
        // color: Colors.white.withOpacity(.9),
        // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        margin: EdgeInsets.only(bottom: 15),
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
              elevation: 0,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    // color: Colors.red,
                    height: 100,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                          child: SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Worksheets.svg',
                            color: Color(0xff3c92d0),
                            width: 5.w,
                          ),
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
                                child: Text(work.name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito',
                                        fontSize: 18,
                                        color: Colors.black.withOpacity(.5)))),

                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Text(work.subject.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Nunito',
                                        fontSize: 18,
                                        color: Color(0xff3c92d0)))),
                           
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(AppLocalizations.of(context).translate('Published_Date'),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.5))),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                // alignment: Alignment.topLeft,
                                child: Text(date,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(.5)))),
                          ],
                        ),
                        // SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context).translate('Deadline'),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(.5))),
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
                                            color: Colors.black
                                                .withOpacity(.5))))),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
