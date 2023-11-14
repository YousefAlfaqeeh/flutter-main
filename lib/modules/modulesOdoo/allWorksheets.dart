import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/getAllWorksheet.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/formWorkSheet.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class AllWorksheets extends StatefulWidget {
  String std_id;

  AllWorksheets({required this.std_id});

  @override
  State<AllWorksheets> createState() => _AllWorksheetsState();
}

class _AllWorksheetsState extends State<AllWorksheets> {
  TextEditingController search = TextEditingController();
  List<ResultAllWorksheet> list_Ass_Search = [];
  bool flg = false;
  List<Widget> student = [];
  GlobalKey<ScaffoldState> sc = GlobalKey<ScaffoldState>();
  late List<bool> isChecked;
  late List<String> subjectdrawer = [];

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
      create: (context) => AppCubit()..getAllWorksheets(widget.std_id),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
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
            //
            //               Reset.clear_searhe();
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
            //             child: Text('Homework',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
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
            //             maxRadius: 26,
            //             backgroundImage: NetworkImage('${AppCubit.image}', ),
            //           ),
            //           PopupMenuButton(offset: Offset(0,AppBar().preferredSize.height),
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            //             child:Icon(Icons.keyboard_arrow_down,size: 26,color: Color(0xff98aac9)) ,itemBuilder: (context) => [
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
            appBar: CustomAppBar(student, AppLocalizations.of(context).translate('Homework')),
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
                                Filter_odoo_subject(page: 'work'),
                          ));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => Filter_odoo_subject(page: 'ass'),
                      //     ));
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
                    //             builder: (context) => Filter_odoo_subject(page: 'work'),
                    //           ));
                    //
                    //     }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),),
                    //   ],
                    // )
                    ,
                  ),
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
                  //           Container(padding: EdgeInsets.all(3),child: SvgPicture.asset("images/pencil_alt_solid_wor.svg"),),
                  //           Container(
                  //               padding: EdgeInsets.symmetric(horizontal: 20),
                  //               alignment: Alignment.centerLeft, child: Text("Homework",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
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
                  //                     sc.currentState!.openDrawer();
                  //                     Drawer(
                  //                       child: SingleChildScrollView(
                  //                         child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  //                             children: [
                  //                            buildHeader( context),
                  //                          buildMenuItems( context),
                  //
                  //
                  //                         ]),
                  //
                  //
                  //
                  //
                  //                       ),
                  //
                  //
                  //
                  //                     );
                  //
                  //                   },child:
                  //                   Container(
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
                  AppCubit.list_allWorkSheet.length != 0 && !flg
                      ? Expanded(
                          child: list_Ass_Search.length != 0
                              ? ListView.builder(
                                  itemBuilder: (context, index) =>
                                      allWorkSheet(list_Ass_Search[index]),
                                  itemCount: list_Ass_Search.length,
                                  shrinkWrap: true,
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) => allWorkSheet(
                                      AppCubit.list_allWorkSheet[index]),
                                  itemCount: AppCubit.list_allWorkSheet.length,
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
          );
        },
        listener: (context, state) {},
      ),
    );
  }

// Widget buildHeader(BuildContext context)=>Container();
//   Widget buildMenuItems(BuildContext context)=>Padding(
//
//     padding: const EdgeInsets.only(top: 50),
//     child: Column(children: [
//           Row(children: [
//           Container(
//
//         padding: EdgeInsets.all(15),
//         child: SvgPicture.asset("images/filter_solid.svg",width: 20,height: 20,)),
//           Expanded(
//             child: Container(
//
//                 alignment: Alignment.centerLeft, child: Text("Filter",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 24,color: Colors.black),)),
//           ),
//           InkWell(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//
//                   padding: EdgeInsets.all(15),
//                   child: SvgPicture.asset("images/times_solid.svg",width: 20,height: 20,color: Colors.grey,)),
//           ),
//
//
//     ],),
//           Container(
//             padding: EdgeInsets.only(left: 20,top: 30),
//             alignment: Alignment.centerLeft, child: Text("Subject",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 24,color: Colors.black),)),
//       Container(
//           height: double.maxFinite,
//           child: ListView.builder(
//               itemCount: subjectdrawer == null ? 0 : subjectdrawer.length,
//               itemBuilder: (BuildContext context, i) {
//                 return CheckboxListTile(value:isChecked[i], onChanged: (value) {
//                   setState(() {
//                     isChecked[i]=value!;
//                   });
//                 },);
//                 //   new ListTile(
//                 //   title: Row(
//                 //     children: [
//                 //       Checkbox(value: isChecked[i], onChanged: (value) {
//                 //         setState(() {
//                 //           isChecked[i]=value!;
//                 //         });
//                 //       },),
//                 //       new Text(subjectdrawer[i]),
//                 //     ],
//                 //   ),
//                 //
//                 // );
//               }))
//
//
//
//
//
//     ]
//
//
//       ,),
//   );
  Widget allWorkSheet(ResultAllWorksheet work) {
    // print(work.finish);
    // setState(() {
    //   subjectdrawer.add(work.subject.toString());
    //   subjectdrawer=subjectdrawer.toSet().toList();
    //   isChecked=List.filled(subjectdrawer.length, false);
    // });

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
                            // Expanded(
                            //   child: Container(alignment: Alignment.centerRight,
                            //     // padding:EdgeInsets.only(right: 4),
                            //     child: Container(
                            //         width: 45,
                            //         height: 20,
                            //         alignment: Alignment.center,
                            //         decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color:work.finish !='True'?Color(0xff7cb13b): Color(0xfff9a200)),
                            //         child:Text(work.finish !='True'?"Submitted": "New",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 12,color: Colors.white)) ),),
                            // ),
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
              builder: (context) => AllWorksheets(
                std_id: listDetail1.id.toString(),
              ),
            ),
          );
        },
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: 20,
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
