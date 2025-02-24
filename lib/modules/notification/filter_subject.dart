
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWorksheets.dart';
import 'package:udemy_flutter/modules/modulesOdoo/assignments.dart';
import 'package:udemy_flutter/modules/modulesOdoo/exam.dart';
import 'package:udemy_flutter/modules/modulesOdoo/weeklyPlan.dart';



class Filter_odoo_subject extends StatefulWidget {
  String page;
  Filter_odoo_subject({required this.page});

  @override
  State<Filter_odoo_subject> createState() => _Filter_odoo_subjectState();
}


class _Filter_odoo_subjectState extends State<Filter_odoo_subject> {
  String? _character = 'Draft';
  TextEditingController user_name = TextEditingController();
  DateTime dateTime = DateTime.now();
  late DateTime fromDate;
  late DateTime fromTo;
  late DateTime fromDate1;
  late DateTime fromTo1;
  String textFrom = 'Date From';
  String textTo = 'Date To';
  // bool isChecked = false;
  // bool isChecked2 = false;
  List isChecked=[];

  @override
  void initState() {
    // TODO: implement initState
    AppCubit.subject_odoo=AppCubit.subject_odoo.toSet().toList();
    for(int i=0;i<AppCubit.subject_odoo.length;i++)
      {
        if(AppCubit.filter_subject.contains(AppCubit.subject_odoo[i]))
          {
            isChecked.add(true);
          }
        else{
        isChecked.add(false);
        }
      }
    if(AppCubit.stutes_notif_odoo.isNotEmpty)
    {

      _character=AppCubit.stutes_notif_odoo;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

          // shwoDialog();

        },
        builder: (context, state) {
          double size=10;
          if(SizerUtil.deviceType ==DeviceType.tablet)
          {size=25;

          }

          return
            WillPopScope(
                onWillPop: () async {
                  // Navigator.pop(context);
                  return false;
                },
                child:
                Scaffold(
                  //navigation bar
                  bottomNavigationBar:Container
                    (

                    height: 15.h,
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      child: Container(

                        // color: Colors.red,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              // SizedBox(height: size.h),
                              Padding(
                                padding: const EdgeInsets.only(left: 2.0,right: 2),
                                child: InkWell(
                                  onTap: () async {
                                    AppCubit.filter_subject=AppCubit.filter_subject.toSet().toList();
                                    if(widget.page=="ass") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Assignments(
                                                    std_id: AppCubit.std),
                                          ));
                                    }
                                    else if(widget.page=="work") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AllWorksheets(
                                                    std_id: AppCubit.std),
                                          ));
                                    }
                                    else if(widget.page=="week") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WeeklyPlans(plan_id: AppCubit.plan_id,plan_name: AppCubit.plan_name,
                                                    std_id: AppCubit.std),
                                          ));
                                    }
                                    else{  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Exams(
                                                  std_id: AppCubit.std),
                                        ));
                                      //Exams
                                    }
                                  },

                                  child: Container(

                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xfff9a200),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(AppLocalizations.of(context).translate('Apply_Filter'),
                                      style: TextStyle(

                                        fontFamily: 'Tajawal',
                                        color: Colors.white,
                                        fontSize: 16,

                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10),
                                child: InkWell(
                                  onTap: () async {
                                    setState(() {
                                      AppCubit.filter_subject=[];
                                      for(int i=0;i<isChecked.length;i++)
                                      {

                                        isChecked[i]=false;
                                      }


                                      if(widget.page=="ass") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Assignments(
                                                      std_id: AppCubit.std),
                                            ));
                                      }
                                      else if(widget.page=="work") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AllWorksheets(
                                                      std_id: AppCubit.std),
                                            ));
                                      }
                                      else if(widget.page=="week") {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WeeklyPlans(plan_id: AppCubit.plan_id,plan_name: AppCubit.plan_name,
                                                      std_id: AppCubit.std),
                                            ));
                                      }
                                      else{  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Exams(
                                                    std_id: AppCubit.std),
                                          ));
                                        //Exams
                                      }

                                    });
                                  },

                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),

                                    ),
                                    alignment: Alignment.center,
                                    child: Text(AppLocalizations.of(context).translate('Reset_Filter'),
                                      style: TextStyle(

                                        fontFamily: 'Nunito',
                                        color:  Color(0xff3c92d0),
                                        fontSize: 16,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ]),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    // primary: false,
                    toolbarHeight: 70,
                    backgroundColor: Colors.white,
                    leadingWidth: 30.w,
                    leading: Container(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: Image(image: AssetImage(AppCubit.trackware_school),width:  20.w,height: 15.w,)),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 20,top: 10,right: 20),
                        child: IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                      )
                    ],


                  ),
                  //end navigation bar
                  body:  Container(
                    // height: 55.h,
                    child: AppCubit.subject_odoo.length!=0?ListView.builder(
                      itemBuilder: (context, index) => index<AppCubit.subject_odoo.length?seclect_subject(index):SizedBox(height: 10.h),
                      itemCount: AppCubit.subject_odoo.length+1,
                      shrinkWrap: true,

                    ): Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(

                        padding: EdgeInsets.only(left: 30,top: 7.w,right: 30),
                        color: Colors.white,
                        height: 60,
                        child: Text(
                          AppLocalizations.of(context).translate('Filter'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      ),
                      Container(
                        // alignment: Alignment.topLeft,

                        margin:  EdgeInsets.only(left: 38.0,right: 30,top: 30),
                        child: Text(  AppLocalizations.of(context).translate('Subject_f'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                      ),


                    ],
                  ),
                  ),
                ));
        },
      ),

    );

  }

 Widget seclect_subject(int index) {
    print("-------------d");
    print(AppCubit.subject_odoo.length);
    if(index < AppCubit.subject_odoo.length) {
      if (index == 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              padding: EdgeInsets.only(left: 30, top: 7.w, right: 30),
              color: Colors.white,
              height: 60,
              child: Text(
                AppLocalizations.of(context).translate('Filter'),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            ),
            Container(
              // alignment: Alignment.topLeft,

              margin: EdgeInsets.only(left: 38.0, right: 30, top: 30),
              child: Text(AppLocalizations.of(context).translate('Subject_f'),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [

                  Checkbox(value: isChecked[index], onChanged: (value) {
                    setState(() {
                      isChecked[index] = value!;
                    });
                    if (value!) {
                      AppCubit.filter_subject.add(AppCubit.subject_odoo[index]);
                    }
                    else {
                      AppCubit.filter_subject.remove(
                          AppCubit.subject_odoo[index]);
                    }
                    // print(value);
                  },),
                  Text(AppCubit.subject_odoo[index])

                ],
              ),
            ),
          ],
        );
      }


      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Checkbox(value: isChecked[index], onChanged: (value) {
              setState(() {
                isChecked[index] = value!;
              });
              if (value!) {
                AppCubit.filter_subject.add(AppCubit.subject_odoo[index]);
              }
              else {
                AppCubit.filter_subject.remove(AppCubit.subject_odoo[index]);
              }
              // print(value);
            },),
            Text(AppCubit.subject_odoo[index])

          ],
        ),
      );
    }
    return SizedBox(height: 10.h,);

  }




}
