import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/getAllWeeklyPlans.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/modulesOdoo/weeklyPlan.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';

class AllWeeklyPlans extends StatefulWidget {
  String std_id;

  AllWeeklyPlans({required this.std_id});

  @override
  State<AllWeeklyPlans> createState() => _AllWeeklyPlansState();
}

class _AllWeeklyPlansState extends State<AllWeeklyPlans> {
  TextEditingController search = TextEditingController();
  List<ResultAllWeeklyPlan> list_Ass_Search = [];
  bool flg = false;
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
          builder: (context) =>AllWeeklyPlans(
            std_id: AppCubit.list_st[i].id.toString(),
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));
      });
    }
    return BlocProvider(
      create: (context) => AppCubit()..getAllWeeklePlan(widget.std_id),
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
              appBar: CustomAppBar(student,
                  AppLocalizations.of(context).translate('weekly_Plans')),
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
              body: Container(
                color: Color(0xfff6f8fb),
                child: Column(
                  children: [
                    AppCubit.list_allWeekly.length != 0 && !flg
                        ? Expanded(
                            child: list_Ass_Search.length != 0 ||
                                    search.text.isNotEmpty
                                ? ListView.builder(
                                    itemBuilder: (context, index) =>
                                        index<list_Ass_Search.length?allWeekly(list_Ass_Search[index]):SizedBox(height: 100,),
                                    itemCount: list_Ass_Search.length+1,
                                    shrinkWrap: true,
                                  )
                                : ListView.builder(
                                    itemBuilder: (context, index) =>index<AppCubit.list_allWeekly.length?
                                        allWeekly(AppCubit.list_allWeekly[index]):SizedBox(height: 100,),
                                    itemCount: AppCubit.list_allWeekly.length+1,
                                    shrinkWrap: true,
                                  ),
                          )
                        : Expanded(
                            child: CustomEmpty(
                                "images/no_weekly_plans_1.png",
                                AppLocalizations.of(context)
                                    .translate('No_Weekly_Plans'))
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

  Widget allWeekly(ResultAllWeeklyPlan ass) {
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.startDate.toString());
    DateTime d = DateFormat('dd MMM yyyy').parse(ass.endDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String date = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1)+" - " +formatter.format(d):ass.startDate.toString() +" - " +ass.endDate.toString();
    return InkWell(
      onTap: () {
        AppCubit.plan_name = ass.planName.toString();
        AppCubit.plan_id = ass.id.toString();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WeeklyPlans(
                  plan_id: ass.id.toString(),
                  plan_name: ass.planName.toString(),
                  std_id: AppCubit.std)),
        );
      },
      child: Card(
          // elevation: 0,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  shape: const RoundedRectangleBorder(
                      // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  elevation: 0.0,
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                      child: SvgPicture.network(
                        'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Weekly+Plans.svg',
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
                      Row(
                        children: [
                          Text(date
                             ,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Nunito',
                                  fontSize: 12,
                                  color: Color(0xff98aac9))),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          // alignment: Alignment.topLeft,
                          child: Text(ass.planName.toString(),
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
              ],
            ),
          )
          ),
    );
  }


}
