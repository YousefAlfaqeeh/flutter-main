
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/chat/teachers.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/map/home_location.dart';
import 'package:udemy_flutter/modules/modulesOdoo/Ecanteen.dart';
import 'package:udemy_flutter/modules/modulesOdoo/absence.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allMark.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWeekPlans.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWorksheets.dart';
import 'package:udemy_flutter/modules/modulesOdoo/assignments.dart';
import 'package:udemy_flutter/modules/modulesOdoo/calendar.dart';
import 'package:udemy_flutter/modules/modulesOdoo/exam.dart';
import 'package:udemy_flutter/modules/modulesOdoo/libary.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_allEvent.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_badges.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_clinic.dart';
import 'package:udemy_flutter/modules/modulesOdoo/timeTable.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/services/location_services.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'dart:math';
// import 'package:nfc_manager/nfc_manager.dart';

class New_Detail extends StatefulWidget {


  @override
  State<New_Detail> createState() => _New_DetailState();
}

class _New_DetailState extends State<New_Detail> {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  _callNumber() async{
    const number = '0799807675'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
bool flag=false;
  @override
  void initState() {
    // TODO: implement initState
    // print(CacheHelper.getBoolean(key: 'new_chat'+AppCubit.std));
    if(CacheHelper.getBoolean(key: 'new_chat'+AppCubit.std).toString()!='null')
      {
        flag=CacheHelper.getBoolean(key: 'new_chat'+AppCubit.std);
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
        create: (context) =>  AppCubit(),
        child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
          return
            WillPopScope(
              onWillPop: () async{
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Hiome_Kids(),
                    ));
                return false;
              },
              child: Scaffold(

                backgroundColor: Color(0xfff5f7fb),
                bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9),  Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),
// appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle.light),

                // bottomNavigationBar:
                // BottomAppBar(
                //   shape: CircularNotchedRectangle(),
                //
                //
                //   notchMargin: 20,
                //   child: Container(
                //     height: 60,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //       children: [
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //
                //             Padding(
                //               padding: const EdgeInsets.only(top: 15.0),
                //               child: MaterialButton(
                //                 minWidth: 40,
                //                 onPressed: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => Setting(),
                //                       ));
                //                 },
                //                 child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     SvgPicture.asset("images/icon_feather_search.svg",color: Colors.grey,)
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //
                //             Padding(
                //               padding: const EdgeInsets.only(top: 15.0),
                //               child: MaterialButton(
                //                 minWidth: 40,
                //                 onPressed: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => Tracking(),
                //                       ));
                //                 },
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     SvgPicture.asset("images/bus.svg",color: Colors.grey,)
                //
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //
                //             Padding(
                //               padding: const EdgeInsets.only(top: 15.0),
                //               child: MaterialButton(
                //                 minWidth: 40,
                //                 onPressed: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => Hiome_Kids(),
                //                       ));
                //                 },
                //                 child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     SvgPicture.asset("images/icons8_home.svg",color:  Colors.grey,)
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //
                //             Padding(
                //               padding: const EdgeInsets.only(top: 15.0),
                //               child: MaterialButton(
                //                 minWidth: 40,
                //                 onPressed: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => PickUp_Request(),
                //                       ));
                //                 },
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     SvgPicture.asset("images/pick_up_by_parent.svg",color: Colors.grey,)
                //
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         Row(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //
                //             Padding(
                //               padding: const EdgeInsets.only(top: 15.0),
                //               child: MaterialButton(
                //                 minWidth: 40,
                //                 onPressed: () {
                //                   Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) => General_app(),
                //                       ));
                //                 },
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.center,
                //                   children: [
                //                     SvgPicture.asset("images/icons8_four_squares.svg",color: Colors.grey,)
                //
                //                   ],
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //       ],
                //
                //     ),
                //
                //
                //   ),
                //
                //
                // ),


                body:Container(
                  // width: double.infinity,

                  // height: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff3c92d0),
                          Color(0xff3c92d0),
                        ],
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            // height: MediaQuery.of(context).size.height/3.5,
                            // color: Colors.grey[200],
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 30,top: 35,right: 30),
                                      // width: double.infinity,
                                      // color: Colors.red,
                                      // alignment: Alignment.topLeft,
                                      child: CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage("${AppCubit.school_image}")),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Container(
                                      padding: EdgeInsets.only(left: 30,top: 35,right: 30),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatPage(std_id: AppCubit.std),
                                              ));
                                        },
                                        child: Row(
                                          children: [

                                            Icon(flag?Icons.mark_chat_unread_outlined:Icons.chat_bubble_outline,color:Colors.white,size: 8.w, ),
                                          // Icons.mark_chat_unread_outlined

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 30,right: 15,top:  30),
                                      child: Container(
                                        // color: Colors.red,
                                        height: 80,
                                        width: 80,
                                        child: CircleAvatar(
                                          // radius: 30,
                                            backgroundImage: NetworkImage("${AppCubit.image}")),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height/25),
                                            child: Text("${AppCubit.name}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,  fontFamily: 'Nunito', color: Colors.white),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 0),
                                            child: Text( "${AppCubit.grade}"+" "+AppLocalizations.of(context).translate('grade'),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700,  fontFamily: 'Poppins', color:  Color(0xfff88c0b)),),
                                          ),

                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.only(left: 15,right: 15,top:  30),
                                    //   child: Container(
                                    //     // color: Colors.red,
                                    //     height: 50,
                                    //     width: 50,
                                    //
                                    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white24),
                                    //     child:IconButton(onPressed: () {
                                    //
                                    //       _tagRead();
                                    //       showDialog(
                                    //           context: context,
                                    //           builder: (context) => AlertDialog(shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    //             content: Container(   height: 35.h ,
                                    //                 child: SingleChildScrollView(
                                    //                   child: Column(
                                    //                       crossAxisAlignment: CrossAxisAlignment.center,
                                    //                       children: [
                                    //
                                    //                         Container(
                                    //
                                    //
                                    //                           height: 30.h ,
                                    //                           // width: 120,
                                    //                           child:Lottie.asset('assets/lang/animation_lkz4jtzc.json'),
                                    //                           // Lottie.asset('assets/lang/high.json'),
                                    //                         ),
                                    //                       ]),
                                    //                 )
                                    //             ),
                                    //
                                    //           )
                                    //       );
                                    //
                                    //
                                    //     }, icon: Icon(Icons.nfc,color: Colors.white,)),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xfff5f7fb),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(MediaQuery.of(context).size.width/7.2),
                                topRight: Radius.circular(MediaQuery.of(context).size.width/7.2),
                              )),
                          child:  Container(
                            padding: EdgeInsets.only(left: 15,right: 15),
                            child: GridView.count(
                              shrinkWrap: true,
                              // childAspectRatio: 1,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                              // childAspectRatio: .85,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisCount: 3,
                              // padding:
                              // EdgeInsets.only(top: MediaQuery.of(context).size.height/21.1, left: MediaQuery.of(context).size.width/24, right: MediaQuery.of(context).size.width/24, bottom: MediaQuery.of(context).size.height/61.5),
                              children: List.generate(AppCubit.listdetail.length, (index) {
                                return profil_student(AppCubit.listdetail[index]);
                              }),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                )
                // FutureBuilder(
                //   future: NfcManager.instance.isAvailable(),builder: (context, snapshot) =>   snapshot.data != true? Container(
                //   // width: double.infinity,
                //
                //   // height: double.infinity,
                //   decoration: const BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topRight,
                //         end: Alignment.bottomLeft,
                //         colors: [
                //           Color(0xff3c92d0),
                //           Color(0xff3c92d0),
                //         ],
                //       )),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         Container(
                //             width: double.infinity,
                //             // height: MediaQuery.of(context).size.height/3.5,
                //             // color: Colors.grey[200],
                //             child: Column(
                //               // mainAxisAlignment: MainAxisAlignment.end,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.only(left: 30,top: 35,right: 30),
                //                   // width: double.infinity,
                //                   // color: Colors.red,
                //                   // alignment: Alignment.topLeft,
                //                   child: CircleAvatar(
                //                       radius: 25,
                //                       backgroundImage: NetworkImage("${AppCubit.school_image}")),
                //                 ),
                //                 Row(
                //                   children: [
                //                     Padding(
                //                       padding: EdgeInsets.only(left: 30,right: 15,top:  30),
                //                       child: Container(
                //                         // color: Colors.red,
                //                         height: 80,
                //                         width: 80,
                //                         child: CircleAvatar(
                //                           // radius: 30,
                //                             backgroundImage: NetworkImage("${AppCubit.image}")),
                //                       ),
                //                     ),
                //                     Expanded(
                //                       child: Column(
                //                         mainAxisAlignment: MainAxisAlignment.start,
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //                           Padding(
                //                             padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height/25),
                //                             child: Text("${AppCubit.name}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,  fontFamily: 'Nunito', color: Colors.white),),
                //                           ),
                //                           Padding(
                //                             padding: EdgeInsets.only(top: 0),
                //                             child: Text( "${AppCubit.grade}"+" "+AppLocalizations.of(context).translate('grade'),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700,  fontFamily: 'Poppins', color:  Color(0xfff88c0b)),),
                //                           ),
                //
                //                         ],
                //                       ),
                //                     ),
                //                     // Padding(
                //                     //   padding: EdgeInsets.only(left: 15,right: 15,top:  30),
                //                     //   child: Container(
                //                     //     // color: Colors.red,
                //                     //     height: 50,
                //                     //     width: 50,
                //                     //
                //                     //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white24),
                //                     //     child:IconButton(onPressed: () {
                //                     //
                //                     //       _tagRead();
                //                     //       showDialog(
                //                     //           context: context,
                //                     //           builder: (context) => AlertDialog(shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //                     //             content: Container(   height: 35.h ,
                //                     //                 child: SingleChildScrollView(
                //                     //                   child: Column(
                //                     //                       crossAxisAlignment: CrossAxisAlignment.center,
                //                     //                       children: [
                //                     //
                //                     //                         Container(
                //                     //
                //                     //
                //                     //                           height: 30.h ,
                //                     //                           // width: 120,
                //                     //                           child:Lottie.asset('assets/lang/animation_lkz4jtzc.json'),
                //                     //                           // Lottie.asset('assets/lang/high.json'),
                //                     //                         ),
                //                     //                       ]),
                //                     //                 )
                //                     //             ),
                //                     //
                //                     //           )
                //                     //       );
                //                     //
                //                     //
                //                     //     }, icon: Icon(Icons.nfc,color: Colors.white,)),
                //                     //   ),
                //                     // ),
                //                   ],
                //                 ),
                //               ],
                //             )
                //         ),
                //         SizedBox(
                //           height: 20,
                //         ),
                //         Container(
                //
                //           decoration: BoxDecoration(
                //               color: Color(0xfff5f7fb),
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(MediaQuery.of(context).size.width/7.2),
                //                 topRight: Radius.circular(MediaQuery.of(context).size.width/7.2),
                //               )),
                //           child:  Container(
                //             padding: EdgeInsets.only(left: 15,right: 15),
                //
                //             child: GridView.count(
                //               shrinkWrap: true,
                //
                //               // childAspectRatio: 1,
                //               mainAxisSpacing: 2,
                //               crossAxisSpacing: 2,
                //               // childAspectRatio: .85,
                //               physics: NeverScrollableScrollPhysics(),
                //               crossAxisCount: 3,
                //
                //               // padding:
                //               // EdgeInsets.only(top: MediaQuery.of(context).size.height/21.1, left: MediaQuery.of(context).size.width/24, right: MediaQuery.of(context).size.width/24, bottom: MediaQuery.of(context).size.height/61.5),
                //               children: List.generate(AppCubit.listdetail.length, (index) {
                //                 return profil_student(AppCubit.listdetail[index]);
                //               }),
                //             ),
                //           ),
                //
                //         ),
                //       ],
                //     ),
                //   ),
                // ):
                // Container(
                //   // width: double.infinity,
                //   // height: double.infinity,
                //   decoration: const BoxDecoration(
                //       gradient: LinearGradient(
                //         begin: Alignment.topRight,
                //         end: Alignment.bottomLeft,
                //         colors: [
                //           Color(0xff3c92d0),
                //           Color(0xff3c92d0),
                //         ],
                //       )),
                //   child: SingleChildScrollView(
                //     child: Column(
                //       children: [
                //         Container(
                //             width: double.infinity,
                //             // height: MediaQuery.of(context).size.height/3.5,
                //             // color: Colors.grey[200],
                //             child: Column(
                //               // mainAxisAlignment: MainAxisAlignment.end,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.only(left: 30,top: 35,right: 30),
                //                   // width: double.infinity,
                //                   // color: Colors.red,
                //                   // alignment: Alignment.topLeft,
                //                   child: CircleAvatar(
                //                       radius: 25,
                //                       backgroundImage: NetworkImage("${AppCubit.school_image}")),
                //                 ),
                //                 Row(
                //                   children: [
                //                     Padding(
                //                       padding: EdgeInsets.only(left: 30,right: 15,top:  30),
                //                       child: Container(
                //                         // color: Colors.red,
                //                         height: 80,
                //                         width: 80,
                //                         child: CircleAvatar(
                //                           // radius: 30,
                //                             backgroundImage: NetworkImage("${AppCubit.image}")),
                //                       ),
                //                     ),
                //                     Expanded(
                //                       child: Column(
                //                         mainAxisAlignment: MainAxisAlignment.start,
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //                           Padding(
                //                             padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height/25),
                //                             child: Text("${AppCubit.name}",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,  fontFamily: 'Nunito', color: Colors.white),),
                //                           ),
                //                           Padding(
                //                             padding: EdgeInsets.only(top: 0),
                //                             child: Text( "${AppCubit.grade}"+" "+AppLocalizations.of(context).translate('grade'),style: TextStyle(fontSize: 11,fontWeight: FontWeight.w700,  fontFamily: 'Poppins', color:  Color(0xfff88c0b)),),
                //                           ),
                //
                //                         ],
                //                       ),
                //                     ),
                //                     Visibility(visible: false,
                //                       child: Padding(
                //                         padding: EdgeInsets.only(left: 15,right: 15,top:  30),
                //                         child: Container(
                //                           // color: Colors.red,
                //                           height: 50,
                //                           width: 50,
                //
                //                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white24),
                //                           child:IconButton(onPressed: () {
                //
                //                             _tagRead();
                //                             showDialog(
                //                                 context: context,
                //                                 builder: (context) => AlertDialog(shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                //                                   content: Container(   height: 35.h ,
                //                                       child: SingleChildScrollView(
                //                                         child: Column(
                //                                             crossAxisAlignment: CrossAxisAlignment.center,
                //                                             children: [
                //
                //                                               Container(
                //
                //
                //                                                 height: 30.h ,
                //                                                 // width: 120,
                //                                                 child:Lottie.asset('assets/lang/animation_lkz4jtzc.json'),
                //                                                 // Lottie.asset('assets/lang/high.json'),
                //                                               ),
                //                                             ]),
                //                                       )
                //                                   ),
                //
                //                                 )
                //                             );
                //
                //
                //                           }, icon: Icon(Icons.nfc,color: Colors.white,)),
                //                         ),
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ],
                //             )
                //         ),
                //         SizedBox(
                //           height: 20,
                //         ),
                //         Container(
                //
                //           decoration: BoxDecoration(
                //               color: Color(0xfff5f7fb),
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(MediaQuery.of(context).size.width/7.2),
                //                 topRight: Radius.circular(MediaQuery.of(context).size.width/7.2),
                //               )),
                //           child:  Container(
                //             padding: EdgeInsets.only(left: 15,right: 15),
                //
                //             child: GridView.count(
                //               shrinkWrap: true,
                //
                //               // childAspectRatio: 1,
                //               mainAxisSpacing: 2,
                //               crossAxisSpacing: 2,
                //               // childAspectRatio: .85,
                //               physics: NeverScrollableScrollPhysics(),
                //               crossAxisCount: 3,
                //
                //               // padding:
                //               // EdgeInsets.only(top: MediaQuery.of(context).size.height/21.1, left: MediaQuery.of(context).size.width/24, right: MediaQuery.of(context).size.width/24, bottom: MediaQuery.of(context).size.height/61.5),
                //               children: List.generate(AppCubit.listdetail.length, (index) {
                //                 return profil_student(AppCubit.listdetail[index]);
                //               }),
                //             ),
                //           ),
                //
                //         ),
                //       ],
                //     ),
                //   ),
                // ),)



              ),
            );
        },
          listener: (context, state) {

          },)

    );
  }

  Widget profil_student(Features listDetail)
  {
// double test=MediaQuery.of(context).size.height/21.1;

    return Container(
// color: Colors.red,
    // alignment:Alignment.center,
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: BorderSide(color:  Color(0xffbbc7db),width: 1)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
          listDetail.new_add=false;

          profile_achtion(listDetail);
        },
        child: Padding(
          padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width/25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 10,
                padding:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?EdgeInsets.only(left: MediaQuery.of(context).size.width/30):EdgeInsets.only(right: MediaQuery.of(context).size.width/30) ,
                alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? Alignment.topLeft:Alignment.topRight,
                width: double.infinity,
                // color: Colors.red,
                child: Container(

                  decoration: BoxDecoration(shape: BoxShape.circle,color:listDetail.new_add!? Colors.green:Colors.white),
                  height: 10,
                  width: 10,

                ),
              ),
              // Image(image:  NetworkImage('${listDetail.icon}'),width: 50,height: 50,),
              //Timetable
              listDetail.icon_svg.toString()=="mark_yousef"?
                  SvgPicture.asset(
                    "images/icons8_diploma_50.svg"
                      ,color:  Color(0xff3c92d0),width:20 ,
          height: MediaQuery.of(context).size.width/12,):


              SvgPicture.network('${listDetail.icon_svg}',color:  Color(0xff3c92d0),width:20 ,
              height: MediaQuery.of(context).size.width/12,),
              SizedBox(height: 20,),

              Expanded(
                child: Text(
                    CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'${listDetail.nameAr}':'${listDetail.name}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontFamily: 'Nunito',
                      fontSize: 10),
                ),
              ),


            ],
          ),
        ),
      ),
    ),
  );

  }

  void profile_achtion(Features listDetail1) async {

    if (listDetail1.name == AppLocalizations.of(context).translate('call'))
    {
      showDialog(

        context: context,
        builder: (context) => dialogCall(
          school_name: listDetail1.school_name.toString(),
          school_number: listDetail1.mobile_number.toString(),
          functionCAll: () async{
            await FlutterPhoneDirectCaller.callNumber(listDetail1.mobile_number.toString());
          },

        ),
      );
    }
    else if (listDetail1.name == AppLocalizations.of(context).translate('absent'))
    {
      showDialog(     barrierDismissible: false,context: context, builder: (context) => dialog_absent(std_id: AppCubit.std.toString()),);
    }
    else if (listDetail1.name ==AppLocalizations.of(context).translate('chang_home_location') )
    {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => dialog_sure(
          massage: 'Change home location',
          functionOK: () async {
            Navigator.pop(context);
            // if(Platform.isAndroid)
            //   {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLocation(std_id:AppCubit.std),
                ));
            // }
            // else
            //   {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => FRoute(),
            //         ));
            //   }
          },
        ),
      );
    }
    else if (listDetail1.name == AppLocalizations.of(context).translate('pick_up'))
    {
      // LocationData? _myLocation = await LoctionService().currentLocation();
      double? currentLocation_lat;
      double? currentLocation_longitude;
      if(Platform.isAndroid)
      {
        Position? _myLocation = await LoctionService().currentLocationAnd();
        currentLocation_lat = _myLocation?.latitude;
        currentLocation_longitude = _myLocation?.longitude;
      }
      else
      {
        LocationData? _myLocation = await LoctionService().currentLocation();
        currentLocation_lat = _myLocation?.latitude;
        currentLocation_longitude = _myLocation?.longitude;
      }
      // print(_myLocation);

      var distance = AppCubit.distance;
      showDialog(
        context: context,
        builder: (context) => dialog_sure(
          massage: 'are you sure ?',
          functionOK: () async {



            var lat = AppCubit.school_lat;
            var lon = AppCubit.school_lng;

            if (calculateDistance( double.parse(lat??"0"), double.parse(lon??"0"),
                currentLocation_lat,currentLocation_longitude) <
                double.parse(distance!)) {
              var response=await  DioHelper.postData(url:Pre_Arrive , data:{
                'school_id':AppCubit.school_id.toString(),
                'student_id':AppCubit.std.toString(),
                'locale':CacheHelper.getBoolean(key: 'locale'),



              },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {


                Navigator.pop(context);
                showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);


              },).catchError((onError){

                // print(onError);
                // // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
                // showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);
              });

            } else {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => dialog(
                    massage: AppLocalizations.of(context).translate('picup_distance')
                        +
                        distance.toString() +AppLocalizations.of(context).translate('meters'),
                    title: Image(image: AssetImage('images/img_error.png'))),
              );
            }
          },
        ),
      );
    }
    else if (listDetail1.name == AppLocalizations.of(context).translate('feedback'))
    {

      showDialog(
        context: context,
        builder: (context) => dialog_feedback(
            functionCancel: () async {},
            functionOK: () async {},
            student_id: AppCubit.std),
      );
    }
    else
    {

      if(listDetail1.url.toString().contains("Clinic"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Clinic_new( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Assignments"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Assignments( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Absence"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std,std_name: AppCubit.name,)));


      }
      else if(listDetail1.url.toString().contains("Library"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Library(std_id: AppCubit.std,std_name: AppCubit.name,)));


      }
      else if(listDetail1.url.toString().contains("ECant"))
      {
        // AppCubit()..getAllProduct(AppCubit.std);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => Ecanteen(std_id: AppCubit.std)));


      }
      else if(listDetail1.url.toString().contains("Timetable"))
      {
        // AppCubit()..getAllProduct(AppCubit.std);
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Time_Table_Form(std_id: AppCubit.std)));


      }
      else if(listDetail1.url.toString().contains("Weekly"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AllWeeklyPlans( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Calendar"))
      {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => CalendarApp(),
        //     ));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Calendar( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Homeworks"))
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllWorksheets(std_id:AppCubit.std)),);

      }
      else if(listDetail1.url.toString().contains("Events"))
      {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => New_AllEvents(std_id:AppCubit.std)),);

      }
      else if(listDetail1.url.toString().contains("Exams"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Exams( std_id: AppCubit.std),
            ));
      }
      else if(listDetail1.url.toString().contains("Badges"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => New_Badges( std_id: AppCubit.std,std_name:  AppCubit.name,),
            ));
      }
      else if(listDetail1.url.toString().contains("Marks"))
      {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => All_mark( std_id: AppCubit.std,image:listDetail1.icon_svg.toString()=='mark_yousef'? "" :listDetail1.icon_svg.toString(),),
            ));
      }
      else{
        //   Badges(std_id: '208',std_name: 'jjjj',)
        AppCubit.get(context).setUrl1( CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?listDetail1.arabicUrl.toString():listDetail1.url.toString());

        AppCubit.get(context).setUrl( CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?listDetail1.arabicUrl.toString():listDetail1.url.toString());
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebView_Login( CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'${listDetail1.arabicUrl}':'${listDetail1.url}'),
            ));}
    }
  }


  double calculateDistance(lat1, lon1, lat2, lon2){

    var p = 0.017453292519943295;
    var c = cos;

    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a))*1000;
  }
//   void _ndefWrite() {
//     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//       var ndef = Ndef.from(tag);
//       if (ndef == null || !ndef.isWritable) {
//         // result.value = 'Tag is not ndef writable';
//         // NfcManager.instance.stopSession(errorMessage: result.value);
//         return;
//       }
//
//       NdefMessage message = NdefMessage([
//         NdefRecord.createText('Hello World!'),
//         NdefRecord.createUri(Uri.parse('https://flutter.dev')),
//         NdefRecord.createMime(
//             'text/plain', Uint8List.fromList('Hello'.codeUnits)),
//         NdefRecord.createExternal(
//             'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
//       ]);
//
//
//       try {
//         // await ndef.write(message);
//         // result.value = 'Success to "Ndef Write"';
//         NfcManager.instance.stopSession();
//       } catch (e) {
//         // result.value = e;
//         // NfcManager.instance.stopSession(errorMessage: result.value.toString());
//         return;
//       }
//     });
//   }
//
//
//
//
//
//   void _tagRead() {
//     NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//       var ndef = Ndef.from(tag);
//       if (ndef == null || !ndef.isWritable) {
//         result.value = 'Tag is not ndef writable';
//         NfcManager.instance.stopSession(errorMessage: result.value);
//         return;
//       }
// print(AppCubit.std.toString());
//       NdefMessage message = NdefMessage([
//         NdefRecord.createText(AppCubit.std.toString()),
//
//       ]);
//
//       try {
//         await ndef.write(message);
//         Navigator.pop(context);
//         // result.value = 'Success to "Ndef Write"';
//         NfcManager.instance.stopSession();
//       } catch (e) {
//         Navigator.pop(context);
//         // result.value = e;
//         NfcManager.instance.stopSession(errorMessage: result.value.toString());
//         return;
//       }
//     });
//     // Navigator.pop(context);
//   }

}
