import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelClinic.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/notification/filter_odoo.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class Clinic_new extends StatefulWidget {
  String std_id;

  Clinic_new({required this.std_id});

  @override
  State<Clinic_new> createState() => _Clinic_newState();
}

class _Clinic_newState extends State<Clinic_new> {
  List<Widget> student = [];
  List<Result> list_Ass_Search = [];
  bool flg = false;

  onSearchTextChanged() async {
    list_Ass_Search.clear();
    // if(AppCubit.stutes_notif_odoo.isNotEmpty){
    if (AppCubit.fromDate_odoo.toString().isEmpty &&
        AppCubit.fromTo_odoo.toString().isEmpty) {
      setState(() {});
      return;
    } else if (AppCubit.fromDate_odoo.toString().isEmpty &&
        AppCubit.fromTo_odoo.toString().isNotEmpty) {
      AppCubit.list_clinic.forEach((element) {
        flg = true;
        DateTime dt1 = DateFormat('dd MMM yyyy').parse(element.date.toString());
        if ((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||
            dt1.isBefore(AppCubit.fromTo_odoo))) {
          list_Ass_Search.add(element);
        }
      });
    } else if (AppCubit.fromDate_odoo.toString().isNotEmpty &&
        AppCubit.fromTo_odoo.toString().isNotEmpty) {
      AppCubit.list_clinic.forEach((element) {
        flg = true;
        DateTime dt1 = DateFormat('dd MMM yyyy').parse(element.date.toString());
        if (((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
                dt1.isAtSameMomentAs(AppCubit.fromTo_odoo)) ||
            ((dt1.isBefore(AppCubit.fromTo_odoo) &&
                dt1.isAfter(AppCubit.fromDate_odoo))))) {
          list_Ass_Search.add(element);
        }
      });
    } else if (AppCubit.stutes_notif_odoo.isNotEmpty &&
        AppCubit.fromDate_odoo.toString().isNotEmpty &&
        AppCubit.fromTo_odoo.toString().isEmpty) {
      AppCubit.list_clinic.forEach((element) {
        flg = true;
        DateTime dt1 = DateFormat('dd MMM yyyy').parse(element.date.toString());
        if ((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
            dt1.isAfter(AppCubit.fromDate_odoo))) {
          list_Ass_Search.add(element);
        }
      });
    }
    if (list_Ass_Search.isEmpty) {
      flg = true;
    } else {
      flg = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    onSearchTextChanged();
    super.initState();
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
      create: (context) => AppCubit()..getClinic(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              Reset.clear_searhe();
              // AppCubit.stutes_notif_odoo='';
              // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
              // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
              AppCubit.show_st = true;
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
              //   toolbarHeight: 20.w,
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
              //               // AppCubit.show_st=true;
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
              //             // child: Text("ufuufufufufufu"),
              //             child: Text('Clinic',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
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
              //       // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
              //       child: Row(
              //         children: [
              //           // Container(
              //           //
              //           //   width: MediaQuery.of(context).size.width/8,
              //           //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),color:  Colors.transparent ,
              //           //       image:DecorationImage(image: NetworkImage("${AppCubit.image}"))),
              //           // ),
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
                  student, AppLocalizations.of(context).translate('Clinic')),
              body: Container(
                color: Color(0xfff5f7fb),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
                      alignment: Alignment.centerRight,
                      child: FilterOdoo(page: () {
                        AppCubit.show_st = false;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Filter_odoo(),
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
                      //       AppCubit.show_st=false;
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => Filter_odoo(),
                      //           ));
                      //
                      //     }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),),
                      //   ],
                      // )
                      ,
                    ),
                    AppCubit.list_clinic.length != 0
                        ? Expanded(
                            child: list_Ass_Search.length != 0
                                ? ListView.separated(
                                    itemBuilder: (context, index) =>
                                        clinic(list_Ass_Search[index]),
                                    itemCount: list_Ass_Search.length,
                                    separatorBuilder: (context, index) {
                                      return Container(
                                          child: SizedBox(
                                        height: 3,
                                      ));
                                    },
                                  )
                                : ListView.separated(
                                    itemBuilder: (context, index) =>
                                        clinic(AppCubit.list_clinic[index]),
                                    itemCount: AppCubit.list_clinic.length,
                                    separatorBuilder: (context, index) {
                                      return Container(
                                          child: SizedBox(
                                        height: 3,
                                      ));
                                    },
                                  ),
                          )
                        : Expanded(
                            child: CustomEmpty(
                                "images/no_clinic_visits.png",  AppLocalizations.of(context).translate('no_Clinic')),
                            // emptyClinic()no_Clinic
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

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
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
              builder: (context) =>
                  Clinic_new(std_id: listDetail1.id.toString()),
            ),
          );
        },
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: MediaQuery.of(context).size.width / 12,
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

  Widget clinic(Result result) {

    DateTime dt1 = DateFormat('dd MMM yyyy').parse(result.date.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String date = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):result.date.toString();
    //result.date.toString()
    return InkWell(
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  margin: EdgeInsets.only(left:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20, top: 10,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                  shape: const RoundedRectangleBorder(
                    // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  elevation: 0.0,
                  child: Container(
                    margin: EdgeInsets.only(top: 2),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                      child: SvgPicture.network(
                        'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Clinic.svg',
                        color: Color(0xff3c92d0),
                        width: 5.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(date,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Color(0xff222222)))))
              ],
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: 20,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?20: 0),
                    padding: EdgeInsets.all(8),
                    child: Text(
                        AppLocalizations.of(context).translate('Note'),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Nunito',
                            fontSize: 16,
                            color: Color(0xff222222)))),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(result.note.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Color(0xff4a4a4a))))),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Container(
                alignment: Alignment.centerLeft,
                color: Color(0xfff9a200).withOpacity(.2),
                margin: EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'images/icons8_clinic11.svg',
                      color: Color(0xff3c92d0),
                      width: 25,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Text(result.prescription.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                                color: Color(0xff4a4a4a)))),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

}
