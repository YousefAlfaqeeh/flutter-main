import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';

import 'package:udemy_flutter/shared/local/cache_helper.dart';


class General_app extends StatefulWidget {
  @override
  State<General_app> createState() => _General_appState();
}

class _General_appState extends State<General_app> {
  _callNumber() async {
    const number = '0799807675'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  List<String> school_number=[];
  List<String> school_name=[];
@override
  void initState() {
    // TODO: implement initState
  school_number.clear();
  for(int i=0;i<AppCubit.list_st.length;i++)
    {
      if(!school_number.contains(AppCubit.list_st[i].schoolMobileNumber.toString())){
      school_number.add(
        AppCubit.list_st[i].schoolMobileNumber.toString(),
      );
      school_name.add(   AppCubit.list_st[i].schoolName.toString()
      );
    }

    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppStates>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: CustomBottomBar("images/icons8_four_squares_full.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xffe84314), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),



              body: Container(

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                          .toString()
                                          .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: Image(
                                    image: AssetImage(
                                        'images/trackware_school.png'),
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                  )),
                              SizedBox(height: 20,),
                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                      .toString()
                                      .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: InkWell(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("images/icons8_technical_support.svg",color: Color(0xff98aac9),),
                                       // Icon(Icons.support_rounded),
                                        SizedBox(width: 20,),
                                        Text( AppLocalizations.of(context)
                                            .translate('support')),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 20,),

                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                      .toString()
                                      .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: InkWell(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("images/icons8_comments6.svg",color: Color(0xff98aac9),),
                                        // Icon(Icons.message_outlined),
                                        SizedBox(width: 20,),
                                        Text( AppLocalizations.of(context)
                                            .translate('feedback')),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 20,),
                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                      .toString()
                                      .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: InkWell(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("images/icons8_help.svg",color: Color(0xff98aac9),),
                                        // Icon(Icons.help_outline),
                                        SizedBox(width: 20,),
                                        Text( AppLocalizations.of(context)
                                            .translate('help')),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 20,),
                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                      .toString()
                                      .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: InkWell(
                                    onTap: () =>   showDialog(
                                      context: context,
                                      builder: (context) => call(),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.call_outlined,color: Color(0xff98aac9)),
                                        SizedBox(width: 20,),
                                        Text( AppLocalizations.of(context)
                                            .translate('call_school')),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 20,),
                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                      .toString()
                                      .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: InkWell(
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("images/icons8_info_squared1.svg",color: Color(0xff98aac9),),
                                        // Icon(Icons.info_outline),
                                        SizedBox(width: 20,),
                                        Text( AppLocalizations.of(context)
                                            .translate('about')),

                                      ],
                                    ),
                                  )),
                              SizedBox(height: 20,),
                              Container(
                                  color: Colors.white,
                                  alignment: CacheHelper.getBoolean(key: 'lang')
                                      .toString()
                                      .contains('ar')
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  padding: EdgeInsets.only(
                                      left: 30, top: 0, right: 30),
                                  child: InkWell(
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>Create_Canteen() ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset("images/ecanteen.svg",color: Color(0xff98aac9),width: 30,),
                                        // Icon(Icons.info_outline),
                                        SizedBox(width: 20,),
                                        Text( AppLocalizations.of(context)
                                            .translate('ecanteen')),

                                      ],
                                    ),
                                  )),




                              // general_feeed_leave(),

                            ],
                          )),
                      // card_tracking(),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {},
        ));
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      // height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: school_number.length,
        itemBuilder: (BuildContext context, int index) {
          return school_num(school_name[index].toString(),school_number[index].toString());
        },
      ),
    );
  }
  Widget call()
  {
 return AlertDialog(
   content: setupAlertDialoadContainer(),
   actions: [
     Container(
       width: double.infinity,

       child:  Column(mainAxisAlignment: MainAxisAlignment.center, children: [


         Container(
           child: MaterialButton(
             child:  Text(
               AppLocalizations.of(context).translate('cancel'),
               style: TextStyle(color: Colors.red),
             ),
             onPressed: () => Navigator.pop(context),
           ),
           decoration: BoxDecoration(
               border: Border.all(color: Colors.red),
               borderRadius: BorderRadius.circular(40)),
         ),
       ]),
     )
   ],

 );
//     return AlertDialog(
//       content:  Container(
// height: 200,
//         color: Color(0xfff5f7fb),
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount:1,
//           itemBuilder: (ctx,int){
// return Text("data");
//
//             // return school_num(school_name[int].toString(),school_number[int].toString());
//           },
//         ),
//       ),
//       actions: [
//         Container(
//           width: double.infinity,
//
//           child:  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//
//
//             Container(
//               child: MaterialButton(
//                 child:  Text(
//                   AppLocalizations.of(context).translate('cancel'),
//                   style: TextStyle(color: Colors.red),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.red),
//                   borderRadius: BorderRadius.circular(40)),
//             ),
//           ]),
//         )
//       ],
//     );
  }
Widget school_num(String school_name,String school_number)
{
  return  Container(
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(),
    child: Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: [ BoxShadow(color: Colors.black,blurRadius: 10,spreadRadius: 20)],
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(10)),
      child: MaterialButton(
        child: Row(
          children: [
            SizedBox(
              width: 11,
            ),
            Icon(
              Icons.call,
              size: 30.0,
              color: Colors.green,
            ),
            VerticalDivider(
              color: Colors.green,
              width: 40,
              thickness: 3,
              indent: 7,
              endIndent: 7,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    school_name,
                    style: TextStyle(color: Colors.green),
                  ),
                  Text(
                    school_number,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
        onPressed: () async {
          await FlutterPhoneDirectCaller.callNumber(school_number);
        },
      ),
    ),
  );
}
  // Widget profil_student(Features listDetail) {
  //   return Container(
  //     child: Card(
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //           side: BorderSide(color: Color(0xff98aac9))),
  //       clipBehavior: Clip.antiAlias,
  //       child: InkWell(
  //         onTap: () {
  //           profile_achtion(listDetail);
  //         },
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: <Widget>[
  //               // Image(image:  NetworkImage('${listDetail.icon}'),width: 50,height: 50,),
  //
  //               SvgPicture.network(
  //                 '${listDetail.icon_svg}',
  //                 color: Color(0xff3c92d0),
  //                 width: MediaQuery.of(context).size.width / 12,
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //
  //               Text(
  //                 CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //                     ? '${listDetail.nameAr}'
  //                     : '${listDetail.name}',
  //                 style: TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     fontFamily: 'Nunito',
  //                     fontSize: 12),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget card_tracking() {
  //   return Column(
  //     children: [
  //       // Container(
  //       //
  //       //   child: InkWell(
  //       //
  //       //     child: Container(
  //       //       padding: EdgeInsets.only(left: 30,right: 30),
  //       //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //       //       width: double.infinity,
  //       //       child: Stack(children: <Widget>[
  //       //         Stack(
  //       //           alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.topRight:Alignment.topLeft,
  //       //           children: <Widget>[
  //       //             Padding(
  //       //               padding:
  //       //               EdgeInsets.only(top: 250 / 5.0,bottom: 0 ),  ///here we create space for the circle avatar to get ut of the box
  //       //               child: Container(
  //       //                 height: MediaQuery.of(context).size.height/8,
  //       //                 alignment: Alignment.bottomRight,
  //       //                 decoration: BoxDecoration(
  //       //                   borderRadius: BorderRadius.circular(15.0),
  //       //                   color: Color(0xfff88c0b),
  //       //
  //       //                 ),
  //       //                 width: double.infinity,
  //       //                 child:Padding(
  //       //                   padding: const EdgeInsets.only(bottom: 8.0,right: 15),
  //       //                   child: Row(
  //       //                       mainAxisAlignment: MainAxisAlignment.end,
  //       //                       children: [
  //       //                         Text('Bus Trackaing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0,color: Colors.white),),
  //       //                         SizedBox(width: 10,),
  //       //                         Container(decoration: BoxDecoration(
  //       //                           borderRadius: BorderRadius.circular(50),
  //       //                           color:Colors.white,
  //       //
  //       //                         ),child: Icon(Icons.arrow_forward, color: Color(0xfff88c0b)),)
  //       //                   ]),
  //       //                 ),
  //       //               ),
  //       //             ),
  //       //
  //       //             // images/icons8_megaphone.svg
  //       //
  //       //             ///Image Avatar
  //       //             Container(
  //       //
  //       //               margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? MediaQuery.of(context).size.width/1.5:0,right:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: MediaQuery.of(context).size.width/1.5),
  //       //
  //       //
  //       //               child:  Center(
  //       //                   child: Container(
  //       //
  //       //                     child: SvgPicture.asset('images/students.svg',width: 100,height: 100,), /// replace your image with the Icon
  //       //                   ),
  //       //                 ),
  //       //
  //       //             ),
  //       //           ],
  //       //         ),
  //       //       ]),
  //       //     ),
  //       //   ),
  //       // ),
  //
  //       Container(
  //           child: InkWell(
  //             child: Container(
  //               width: double.infinity,
  //               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10, right: MediaQuery.of(context).size.width/10),
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //               child: Stack(
  //                 alignment:
  //                 CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //                     ? Alignment.topRight
  //                     : Alignment.topLeft,
  //                 fit: StackFit.passthrough,
  //                 children: [
  //                   Container(
  //                     height: MediaQuery.of(context).size.height / 6,
  //                     color: Colors.transparent,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 29.0),
  //                     child: Container(
  //                         height: MediaQuery.of(context).size.height / 9,
  //                         alignment: Alignment.bottomRight,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(15.0),
  //                           color: Color(0xfff88c0b),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(bottom: 10.0, right: 15),
  //                           child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: [
  //                                 Text(
  //                                   'Bus Trackaing',
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 22.0,
  //                                       color: Colors.white),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 10,
  //                                 ),
  //                                 Container(
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(50),
  //                                     color: Colors.white,
  //                                   ),
  //                                   child: Icon(Icons.arrow_forward,
  //                                       color: Color(0xff7cb13b)),
  //                                 )
  //                               ]),
  //                         )),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       right: MediaQuery.of(context).size.width / 2,
  //                     ),
  //                     child: Container(
  //                       margin: EdgeInsets.only(right: 40, bottom: 20),
  //                       height: 100,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(100),
  //                         color: Colors.white.withOpacity(.5),
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       right: MediaQuery.of(context).size.width / 1.8,
  //
  //                     ),
  //                     child: Container(
  //
  //                       alignment: Alignment.topLeft,
  //
  //                         child: Image(
  //                           image: AssetImage("images/bus_genr.png"),
  //                          // height: MediaQuery.of(context).size.height/5,
  //                         )),
  //                   //  images/bus_genr.png
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )),
  //       Container(
  //           child: InkWell(
  //         child: Container(
  //           width: double.infinity,
  //           padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10, right: MediaQuery.of(context).size.width/10),
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //           child: Stack(
  //             alignment:
  //                 CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //                     ? Alignment.topRight
  //                     : Alignment.topLeft,
  //             fit: StackFit.passthrough,
  //             children: [
  //               Container(
  //                 height: MediaQuery.of(context).size.height / 6,
  //                 color: Colors.transparent,
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 29.0),
  //                 child: Container(
  //                     height: MediaQuery.of(context).size.height / 9,
  //                     alignment: Alignment.bottomRight,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(15.0),
  //                       color: Color(0xff7cb13b),
  //                     ),
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(bottom: 10.0, right: 15),
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.end,
  //                           children: [
  //                             Text(
  //                               'Pickup request',
  //                               style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                   fontSize: 22.0,
  //                                   color: Colors.white),
  //                             ),
  //                             SizedBox(
  //                               width: 10,
  //                             ),
  //                             Container(
  //                               decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(50),
  //                                 color: Colors.white,
  //                               ),
  //                               child: Icon(Icons.arrow_forward,
  //                                   color: Color(0xff7cb13b)),
  //                             )
  //                           ]),
  //                     )),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   right: MediaQuery.of(context).size.width / 2.2,
  //                 ),
  //                 child: Container(
  //                   margin: EdgeInsets.only(right: 40, bottom: 20),
  //                   height: 100,
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(60),
  //                     color: Colors.white.withOpacity(.5),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: EdgeInsets.only(
  //                   right: MediaQuery.of(context).size.width / 1.8,
  //                 ),
  //                 child: Container(
  //
  //                     // alignment: Alignment.topLeft,
  //
  //                     child: SvgPicture.asset(
  //                   'images/new_bus.svg',
  //                   height: 120,
  //                 )),
  //               )
  //             ],
  //           ),
  //         ),
  //       )),
  //       Container(
  //           child: InkWell(
  //             child: Container(
  //               width: double.infinity,
  //               padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10, right: MediaQuery.of(context).size.width/10),
  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //               child: Stack(
  //                 alignment:
  //                 CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //                     ? Alignment.topRight
  //                     : Alignment.topLeft,
  //                 fit: StackFit.passthrough,
  //                 children: [
  //                   Container(
  //                     height: MediaQuery.of(context).size.height / 6,
  //                     color: Colors.transparent,
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 29.0),
  //                     child: Container(
  //                         height: MediaQuery.of(context).size.height / 9,
  //                         alignment: Alignment.bottomRight,
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(15.0),
  //                           color: Color(0xff2b78b8),
  //                         ),
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(bottom: 10.0, right: 15),
  //                           child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.end,
  //                               children: [
  //                                 Text(
  //                                   'Shop Now',
  //                                   style: TextStyle(
  //                                       fontWeight: FontWeight.bold,
  //                                       fontSize: 22.0,
  //                                       color: Colors.white),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 10,
  //                                 ),
  //                                 Container(
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(50),
  //                                     color: Colors.white,
  //                                   ),
  //                                   child: Icon(Icons.arrow_forward,
  //                                       color: Color(0xff7cb13b)),
  //                                 )
  //                               ]),
  //                         )),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       right: MediaQuery.of(context).size.width / 2.2,
  //                     ),
  //                     child: Container(
  //                       margin: EdgeInsets.only(right: 40, bottom: 20),
  //                       height: 100,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(60),
  //                         color: Colors.white.withOpacity(.5),
  //                       ),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(
  //                       right: MediaQuery.of(context).size.width / 1.8,
  //                     ),
  //                     child: Container(
  //
  //                       // alignment: Alignment.topLeft,
  //
  //                         child: Image(
  //                           image: AssetImage("images/cart.png"),
  //                           height: MediaQuery.of(context).size.height/6.5,
  //                         )
  //                     //images/cart.png
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )),
  //       // Container(
  //       //
  //       //   child: InkWell(
  //       //
  //       //     child: Container(
  //       //       width: double.infinity,
  //       //       padding: EdgeInsets.only(left: 30,right: 30),
  //       //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
  //       //       child: Stack(children: <Widget>[
  //       //         Stack(
  //       //           alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.topRight:Alignment.topLeft,
  //       //           children: <Widget>[
  //       //             Padding(
  //       //               padding:
  //       //               EdgeInsets.only(top: 200 / 5.0,bottom: 0 ),  ///here we create space for the circle avatar to get ut of the box
  //       //               child: Container(
  //       //                 height: MediaQuery.of(context).size.height/8,
  //       //                 alignment: Alignment.bottomRight,
  //       //                 decoration: BoxDecoration(
  //       //                   borderRadius: BorderRadius.circular(15.0),
  //       //                   color: Color(0xff2b78b8),
  //       //
  //       //                 ),
  //       //                 width: double.infinity,
  //       //                 child:Padding(
  //       //                   padding: const EdgeInsets.only(bottom: 8.0,right: 15),
  //       //                   child: Row(
  //       //                       mainAxisAlignment: MainAxisAlignment.end,
  //       //                       children: [
  //       //                         Text('Shop Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0,color: Colors.white),),
  //       //                         SizedBox(width: 10,),
  //       //                         Container(decoration: BoxDecoration(
  //       //                           borderRadius: BorderRadius.circular(50),
  //       //                           color:Colors.white,
  //       //
  //       //                         ),child: Icon(Icons.arrow_forward, color: Color(0xff2b78b8)),)
  //       //                       ]),
  //       //                 ),
  //       //               )
  //       //             ),
  //       //
  //       //             // images/icons8_megaphone.svg
  //       //
  //       //             ///Image Avatar
  //       //             Container(
  //       //
  //       //               margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? MediaQuery.of(context).size.width/1.5:0,right:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0: MediaQuery.of(context).size.width/1.5),
  //       //
  //       //
  //       //               child:  Center(
  //       //                 child: Container(
  //       //
  //       //                   child: SvgPicture.asset('images/new_bus.svg',width: 100,height: 100,), /// replace your image with the Icon
  //       //                 ),
  //       //               ),
  //       //
  //       //             ),
  //       //           ],
  //       //         ),
  //       //       ]),
  //       //     ),
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
  //
  // void profile_achtion(Features listDetail1) async {
  //   if (listDetail1.name == AppLocalizations.of(context).translate('call')) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => dialogCall(
  //         school_name: listDetail1.school_name.toString(),
  //         school_number: listDetail1.mobile_number.toString(),
  //         functionCAll: () async {
  //           await FlutterPhoneDirectCaller.callNumber(
  //               listDetail1.mobile_number.toString());
  //         },
  //       ),
  //     );
  //   } else if (listDetail1.name ==
  //       AppLocalizations.of(context).translate('absent')) {
  //     showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => dialog_absent(std_id: AppCubit.std.toString()),
  //     );
  //   } else if (listDetail1.name ==
  //       AppLocalizations.of(context).translate('chang_home_location')) {
  //     showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) => dialog_sure(
  //         massage: 'Change home location',
  //         functionOK: () async {
  //           Navigator.pop(context);
  //           // if(Platform.isAndroid)
  //           //   {
  //           Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => HomeLocation(std_id: AppCubit.std),
  //               ));
  //           // }
  //           // else
  //           //   {
  //           //     Navigator.push(
  //           //         context,
  //           //         MaterialPageRoute(
  //           //           builder: (context) => FRoute(),
  //           //         ));
  //           //   }
  //         },
  //       ),
  //     );
  //   } else if (listDetail1.name ==
  //       AppLocalizations.of(context).translate('pick_up')) {
  //     LocationData? _myLocation = await LoctionService().currentLocation();
  //
  //     print(_myLocation);
  //
  //     var distance = AppCubit.distance;
  //     showDialog(
  //       context: context,
  //       builder: (context) => dialog_sure(
  //         massage: 'are you sure ?',
  //         functionOK: () async {
  //           var lat = AppCubit.school_lat;
  //           var lon = AppCubit.school_lng;
  //
  //           if (calculateDistance(
  //                   double.parse(lat ?? "0"),
  //                   double.parse(lon ?? "0"),
  //                   _myLocation?.latitude,
  //                   _myLocation?.longitude) <
  //               double.parse(distance!)) {
  //             var response = await DioHelper.postData(
  //                     url: Pre_Arrive,
  //                     data: {
  //                       'school_id': AppCubit.school_id.toString(),
  //                       'student_id': AppCubit.std.toString(),
  //                       'locale': CacheHelper.getBoolean(key: 'locale'),
  //                     },
  //                     token: CacheHelper.getBoolean(key: 'authorization'))
  //                 .then(
  //               (value) {
  //                 Navigator.pop(context);
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) => dialog(
  //                       massage: AppLocalizations.of(context).translate('pic'),
  //                       title: Text('')),
  //                 );
  //               },
  //             ).catchError((onError) {
  //               // print(onError);
  //               // // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
  //               // showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('pic'), title:Text('') ),);
  //             });
  //           } else {
  //             Navigator.pop(context);
  //             showDialog(
  //               context: context,
  //               builder: (context) => dialog(
  //                   massage: AppLocalizations.of(context)
  //                           .translate('picup_distance') +
  //                       distance.toString() +
  //                       AppLocalizations.of(context).translate('meters'),
  //                   title: Image(image: AssetImage('images/img_error.png'))),
  //             );
  //           }
  //         },
  //       ),
  //     );
  //   } else if (listDetail1.name ==
  //       AppLocalizations.of(context).translate('feedback')) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => dialog_feedback(
  //           functionCancel: () async {},
  //           functionOK: () async {},
  //           student_id: AppCubit.std),
  //     );
  //   } else {
  //     if (listDetail1.url.toString().contains("Clinic")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Clinic(std_id: AppCubit.std),
  //           ));
  //     } else if (listDetail1.url.toString().contains("Assignments")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Assignments(std_id: AppCubit.std),
  //           ));
  //     } else if (listDetail1.url.toString().contains("Absence")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => Absence(
  //                     std_id: AppCubit.std,
  //                     std_name: AppCubit.name,
  //                   )));
  //     } else if (listDetail1.url.toString().contains("Weekly")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => AllWeeklyPlans(std_id: AppCubit.std),
  //           ));
  //     } else if (listDetail1.url.toString().contains("Calendar")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Calendar(std_id: AppCubit.std),
  //           ));
  //     } else if (listDetail1.url.toString().contains("Homeworks")) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => AllWorksheets(std_id: AppCubit.std)),
  //       );
  //     } else if (listDetail1.url.toString().contains("Events")) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => AllEvents(std_id: AppCubit.std)),
  //       );
  //     } else if (listDetail1.url.toString().contains("Exams")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Exams(std_id: AppCubit.std),
  //           ));
  //     } else if (listDetail1.url.toString().contains("Badges")) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => Badges(
  //               std_id: AppCubit.std,
  //               std_name: AppCubit.name,
  //             ),
  //           ));
  //     } else {
  //       //   Badges(std_id: '208',std_name: 'jjjj',)
  //       AppCubit.get(context).setUrl1(
  //           CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //               ? listDetail1.arabicUrl.toString()
  //               : listDetail1.url.toString());
  //
  //       AppCubit.get(context).setUrl(
  //           CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //               ? listDetail1.arabicUrl.toString()
  //               : listDetail1.url.toString());
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => WebView_Login(
  //                 CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //                     ? '${listDetail1.arabicUrl}'
  //                     : '${listDetail1.url}'),
  //           ));
  //     }
  //   }
  // }
  //
  // Widget general_feeed_leave() {
  //   return Padding(
  //     padding: EdgeInsets.only(
  //         left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //             ? 0
  //             : 40,
  //         right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
  //             ? 40
  //             : 0),
  //     child: Row(
  //       children: [
  //         Container(
  //           color: Colors.white,
  //           child: Column(children: [
  //             InkWell(
  //               child: Container(
  //                 // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //                 child: SizedBox(
  //                   width: 80,
  //                   height: 80,
  //                   child: Card(
  //                     elevation: 10,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(50)),
  //                     clipBehavior: Clip.antiAlias,
  //                     child: InkWell(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: <Widget>[
  //                             SvgPicture.asset(
  //                               'images/absence_new.svg',
  //                               color: Color(0xffd23204),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "Absent ",
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontFamily: 'Nunito',
  //                   fontSize: 12),
  //             ),
  //             Text(
  //               "Request ",
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontFamily: 'Nunito',
  //                   fontSize: 12),
  //             ),
  //           ]),
  //         ),
  //         Container(
  //           color: Colors.white,
  //           padding: EdgeInsets.only(left: 20, right: 20),
  //           child: Column(children: [
  //             InkWell(
  //               child: Container(
  //                 // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //                 child: SizedBox(
  //                   width: 80,
  //                   height: 80,
  //                   child: Card(
  //                     elevation: 10,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(50)),
  //                     clipBehavior: Clip.antiAlias,
  //                     child: InkWell(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: <Widget>[
  //                             SvgPicture.asset(
  //                               'images/icons8_fire_exit.svg',
  //                               color: Color(0xfff9a200),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               "Leave ",
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontFamily: 'Nunito',
  //                   fontSize: 12),
  //             ),
  //             Text(
  //               "Request ",
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontFamily: 'Nunito',
  //                   fontSize: 12),
  //             ),
  //           ]),
  //         ),
  //         Container(
  //           color: Colors.white,
  //           child: Column(children: [
  //             InkWell(
  //               child: Container(
  //                 // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
  //                 child: SizedBox(
  //                   width: 80,
  //                   height: 80,
  //                   child: Card(
  //                     elevation: 10,
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(50)),
  //                     clipBehavior: Clip.antiAlias,
  //                     child: InkWell(
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(top: 20),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.center,
  //                           children: <Widget>[
  //                             SvgPicture.asset(
  //                               'images/icons8_comments.svg',
  //                               color: Color(0xff3c92d0),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             ),
  //             Text(
  //               AppLocalizations.of(context).translate('feedback'),
  //               style: TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontFamily: 'Nunito',
  //                   fontSize: 12),
  //             ),
  //             SizedBox(
  //               height: 10,
  //             )
  //           ]),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var c = cos;
  //
  //   var a = 0.5 -
  //       c((lat2 - lat1) * p) / 2 +
  //       c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a)) * 1000;
  // }
}
