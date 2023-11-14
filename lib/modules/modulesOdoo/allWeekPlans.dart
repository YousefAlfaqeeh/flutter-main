import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path/src/context.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/getAllWeeklyPlans.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/modulesOdoo/weeklyPlan.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

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

  // onSearchTextChanged(String text)async
  // {
  //   list_Ass_Search.clear();
  //   if(text.isEmpty)
  //   {
  //     setState(() {
  //
  //     });
  //     return;
  //   }
  //   AppCubit.list_allWeekly.forEach((element) {
  //     if(element.planName.toString().contains(text))
  //     {
  //       list_Ass_Search.add(element);
  //     }
  //   });
  //   if(list_Ass_Search.isEmpty)
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
      create: (context) => AppCubit()..getAllWeeklePlan(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
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
                  // Container(
                  //   margin: EdgeInsets.only(top: 10,bottom: 3,left: 10,right: 10),
                  //   alignment: Alignment.centerRight,
                  //   child:   IconButton(onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Filter_odoo_subject(page: 'exam'),
                  //         ));
                  //
                  //   }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),)
                  //   ,),
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
                  //           Container(padding: EdgeInsets.all(3),child: SvgPicture.asset("images/table_solid.svg"),),
                  //           Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 20),
                  //               alignment: Alignment.centerLeft, child: Text("Weekly Plans",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
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
                  AppCubit.list_allWeekly.length != 0 && !flg
                      ? Expanded(
                          child: list_Ass_Search.length != 0 ||
                                  search.text.isNotEmpty
                              ? ListView.builder(
                                  itemBuilder: (context, index) =>
                                      allWeekly(list_Ass_Search[index]),
                                  itemCount: list_Ass_Search.length,
                                  shrinkWrap: true,
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) =>
                                      allWeekly(AppCubit.list_allWeekly[index]),
                                  itemCount: AppCubit.list_allWeekly.length,
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
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget allWeekly(ResultAllWeeklyPlan ass) {
    // AppCubit.subject_odoo.add(ass.subject.toString());
    // AppCubit.subject_odoo=AppCubit.subject_odoo.toSet().toList();
    // ass.startDate.toString() +
    //                                   " - " +
    //                                   ass.endDate.toString()
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
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text("Date",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)),
                      //     SizedBox(width: 1.w,),
                      //     Expanded(
                      //         child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.startDate.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color:Colors.black)))),
                      //
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
          )
          // Column(
          //   children: [
          //     SizedBox(
          //       height: 20,
          //     ),
          //     Container(margin: EdgeInsets.symmetric(horizontal: 18),alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),child: Text( ass.planName.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black))),
          //     Row(
          //       children: [
          //
          //
          //
          //         Container( margin: EdgeInsets.only(left: 30),
          //             padding: EdgeInsets.all(8), child: Text("Start Date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 15.0),
          //           child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
          //         ),
          //
          //
          //
          //         Expanded(
          //             child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff3c92d0))))),
          //
          //
          //       ],
          //     ),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Row(
          //       children: [
          //
          //
          //
          //         Container( margin: EdgeInsets.only(left: 30),
          //             padding: EdgeInsets.all(8), child: Text("End Date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 24.0),
          //           child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
          //         ),
          //
          //
          //
          //         Expanded(
          //             child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.endDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff3c92d0))))),
          //
          //
          //       ],
          //     ),
          //     SizedBox(
          //       height: 20,
          //     ),
          //   ],
          // ),
          ),
    );
  }

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Reset.clear_searhe();
          // AppCubit.stutes_notif_odoo='';
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
              builder: (context) => AllWeeklyPlans(
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
                "${listDetail1.studentGrade}",
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
// Widget emptyAss()
// {
//   return Container(
//     alignment: Alignment.center,
//
//     child:Padding(
//       padding: EdgeInsets.symmetric(vertical: 50),
//       child: Column(children: [
//         Expanded(child: Image(image: AssetImage("images/no_weekly_plans_1.png") ,width: 293,height: 239,)),
//         SizedBox(height: 10,),
//         // Text("No Weekly Plan added",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))
//         Text("No Weekly Plans ",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
//         SizedBox(height: 10,),
//         InkWell(onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => New_Detail()),
//           );
//         },
//             child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
//       ]),
//     ) ,);
// }
}
