// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';
// import 'package:udemy_flutter/localizations.dart';
// import 'package:udemy_flutter/models/kidsList.dart';
// import 'package:udemy_flutter/models/method.dart';
// import 'package:udemy_flutter/models/modelClinic.dart';
// import 'package:udemy_flutter/models/product.dart';
// import 'package:udemy_flutter/modules/cubit/cubit.dart';
// import 'package:udemy_flutter/modules/cubit/states.dart';
// import 'package:udemy_flutter/modules/home/new_home.dart';
// import 'package:udemy_flutter/modules/notification/filter_odoo.dart';
// import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
// import 'package:udemy_flutter/shared/components/customWidget.dart';
//
// class Ecanteen extends StatefulWidget {
//   String std_id;
//
//   Ecanteen({required this.std_id});
//
//   @override
//   State<Ecanteen> createState() => _EcanteenState();
// }
//
// class _EcanteenState extends State<Ecanteen> {
//   List<Widget> student = [];
//   List<ResultProduct> list_Ass_Search = [];
//   bool flg = false;
//   bool isChecked = false;
//
//   // onSearchTextChanged() async {
//   //   list_Ass_Search.clear();
//   //   // if(AppCubit.stutes_notif_odoo.isNotEmpty){
//   //   if (AppCubit.fromDate_odoo.toString().isEmpty &&
//   //       AppCubit.fromTo_odoo.toString().isEmpty) {
//   //     setState(() {});
//   //     return;
//   //   } else if (AppCubit.fromDate_odoo.toString().isEmpty &&
//   //       AppCubit.fromTo_odoo.toString().isNotEmpty) {
//   //     AppCubit.list_clinic.forEach((element) {
//   //       flg = true;
//   //       DateTime dt1 = DateFormat('dd MMM yyyy').parse(element.date.toString());
//   //       if ((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||
//   //           dt1.isBefore(AppCubit.fromTo_odoo))) {
//   //         list_Ass_Search.add(element);
//   //       }
//   //     });
//   //   } else if (AppCubit.fromDate_odoo.toString().isNotEmpty &&
//   //       AppCubit.fromTo_odoo.toString().isNotEmpty) {
//   //     AppCubit.list_clinic.forEach((element) {
//   //       flg = true;
//   //       DateTime dt1 = DateFormat('dd MMM yyyy').parse(element.date.toString());
//   //       if (((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
//   //           dt1.isAtSameMomentAs(AppCubit.fromTo_odoo)) ||
//   //           ((dt1.isBefore(AppCubit.fromTo_odoo) &&
//   //               dt1.isAfter(AppCubit.fromDate_odoo))))) {
//   //         list_Ass_Search.add(element);
//   //       }
//   //     });
//   //   } else if (AppCubit.stutes_notif_odoo.isNotEmpty &&
//   //       AppCubit.fromDate_odoo.toString().isNotEmpty &&
//   //       AppCubit.fromTo_odoo.toString().isEmpty) {
//   //     AppCubit.list_clinic.forEach((element) {
//   //       flg = true;
//   //       DateTime dt1 = DateFormat('dd MMM yyyy').parse(element.date.toString());
//   //       if ((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||
//   //           dt1.isAfter(AppCubit.fromDate_odoo))) {
//   //         list_Ass_Search.add(element);
//   //       }
//   //     });
//   //   }
//   //   if (list_Ass_Search.isEmpty) {
//   //     flg = true;
//   //   } else {
//   //     flg = false;
//   //   }
//   //   setState(() {});
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     // onSearchTextChanged();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     student.clear();
//     for (int i = 0; i < AppCubit.list_st.length; i++) {
//       //
//       setState(() {
//         student.add(student_list(i, AppCubit.list_st[i]));
//       });
//     }
//     return BlocProvider(
//       create: (context) => AppCubit()..getAllProduct(widget.std_id),
//       child: BlocConsumer<AppCubit, AppStates>(
//         builder: (context, state) {
//           return WillPopScope(
//             onWillPop: () async {
//               Reset.clear_searhe();
//               // AppCubit.stutes_notif_odoo='';
//               // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
//               // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
//               AppCubit.show_st = true;
//               if (AppCubit.back_home) {
//                 AppCubit.back_home = false;
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Hiome_Kids()),
//                 );
//               } else {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => New_Detail()),
//                 );
//               }
//               return false;
//             },
//             child: Scaffold(
//               bottomNavigationBar: CustomBottomBar(
//                   "images/icons8_four_squares.svg",
//                   "images/icons8_home.svg",
//                   "images/picup_empty.svg",
//                   "images/icon_feather_search.svg",
//                   "images/bus.svg",
//                   Color(0xff98aac9),
//                   Color(0xff98aac9),
//                   Color(0xff98aac9),
//                   Color(0xff98aac9),
//                   Color(0xff98aac9)),
//               appBar: CustomAppBar(
//                   student, 'ECanteen'),
//               body: Container(
//                 color: Color(0xfff5f7fb),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Container(
//                         margin:
//                         EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.w),
//                         alignment: Alignment.centerRight,
//                         child: FilterOdoo(page: () {
//                           AppCubit.show_st = false;
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => Filter_odoo(),
//                               ));
//                         })
//
//                         // Row(
//                         //   crossAxisAlignment: CrossAxisAlignment.center,
//                         //   mainAxisAlignment: MainAxisAlignment.end,
//                         //   children: [
//                         //     Container(
//                         //       // color: Colors.red,
//                         //       child: Text('Filter', style: TextStyle(
//                         //           fontWeight: FontWeight.normal,
//                         //           fontSize: 13,
//                         //
//                         //           fontFamily: 'Nunito',
//                         //           color: Color(0xff222222))),
//                         //     ),
//                         //     IconButton(onPressed: () {
//                         //       AppCubit.show_st=false;
//                         //       Navigator.push(
//                         //           context,
//                         //           MaterialPageRoute(
//                         //             builder: (context) => Filter_odoo(),
//                         //           ));
//                         //
//                         //     }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),),
//                         //   ],
//                         // )
//                         ,
//                       ),
//               Container(
//
//                   decoration: BoxDecoration(
//                       color: Color(0xfff5f7fb),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(MediaQuery.of(context).size.width/7.2),
//                         topRight: Radius.circular(MediaQuery.of(context).size.width/7.2),
//                       )),
//                   child:  Container(
//                     padding: EdgeInsets.only(left: 15,right: 15),
//
//                     child: GridView.count(
//                       shrinkWrap: true,
//
//                       // childAspectRatio: 1,
//                       mainAxisSpacing: 2,
//                       crossAxisSpacing: 2,
//                       // childAspectRatio: .85,
//                       physics: NeverScrollableScrollPhysics(),
//                       crossAxisCount: 2,
//
//                       // padding:
//                       // EdgeInsets.only(top: MediaQuery.of(context).size.height/21.1, left: MediaQuery.of(context).size.width/24, right: MediaQuery.of(context).size.width/24, bottom: MediaQuery.of(context).size.height/61.5),
//                       children: List.generate(AppCubit.list_Product.length, (index) {
//                         return product(AppCubit.list_Product[index]);
//                       }),
//                     ),
//                   ),
//
//               ),
//                       // AppCubit.list_Product.length != 0
//                       //     ? Expanded(
//                       //   child: list_Ass_Search.length != 0
//                       //       ? ListView.separated(
//                       //     itemBuilder: (context, index) =>
//                       //         product(list_Ass_Search[index]),
//                       //     itemCount: list_Ass_Search.length,
//                       //     separatorBuilder: (context, index) {
//                       //       return Container(
//                       //           child: SizedBox(
//                       //             height: 3,
//                       //           ));
//                       //     },
//                       //   )
//                       //       :GridView.count(
//                       //     shrinkWrap: true,
//                       //
//                       //     // childAspectRatio: 1,
//                       //     mainAxisSpacing: 2,
//                       //     crossAxisSpacing: 2,
//                       //     // childAspectRatio: .85,
//                       //     physics: NeverScrollableScrollPhysics(),
//                       //     crossAxisCount: 2,
//                       //
//                       //     // padding:
//                       //     // EdgeInsets.only(top: MediaQuery.of(context).size.height/21.1, left: MediaQuery.of(context).size.width/24, right: MediaQuery.of(context).size.width/24, bottom: MediaQuery.of(context).size.height/61.5),
//                       //     children: List.generate(AppCubit.list_Product.length, (index) {
//                       //       return product(AppCubit.list_Product[index]);
//                       //     }),
//                       //   )
//                       //   //   ListView.separated(
//                       //   //   itemBuilder: (context, index) =>
//                       //   //       product(AppCubit.list_Product[index]),
//                       //   //   itemCount: AppCubit.list_Product.length,
//                       //   //   separatorBuilder: (context, index) {
//                       //   //     return Container(
//                       //   //         child: SizedBox(
//                       //   //           height: 3,
//                       //   //         ));
//                       //   //   },
//                       //   // ),
//                       // )
//                       //     : Expanded(
//                       //   child: CustomEmpty(
//                       //       "images/no_clinic_visits.png", "No ECanteen  "),
//                         // emptyClinic()
//                       // ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//         listener: (context, state) {},
//       ),
//     );
//   }
//
//   Widget student_list(int ind, Students listDetail1) {
//     List<Features> listFeatures1 = [];
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: InkWell(
//         onTap: () {
//           AppCubit.school_image = listDetail1.schoolImage.toString();
//
//           listFeatures1.clear();
//           // if(listDetail1.changeLocation=true)
//           // {
//           //
//           //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
//           //
//           // }
//
//           listDetail1.features!.forEach((element) {
//             listFeatures1.add(element);
//           });
//
//           AppCubit.get(context).setDetalil(
//               listDetail1.name,
//               listDetail1.studentGrade ?? "",
//               listDetail1.schoolName,
//               listDetail1.avatar,
//               listDetail1.id.toString(),
//               listDetail1.schoolLat,
//               listDetail1.schoolId.toString(),
//               listDetail1.schoolLng,
//               listDetail1.pickupRequestDistance.toString(),
//               listFeatures1);
//
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   Ecanteen(std_id: listDetail1.id.toString()),
//             ),
//           );
//         },
//         child: Row(children: [
//           CircleAvatar(
//             backgroundColor: Colors.transparent,
//             maxRadius: MediaQuery.of(context).size.width / 12,
//             backgroundImage: NetworkImage(
//               '${listDetail1.avatar}',
//             ),
//           ),
//           SizedBox(
//             height: 10,
//             width: 10,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "${listDetail1.fname}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Nunito',
//                     fontSize: 9),
//               ),
//               Text(
//                 "${AppCubit.grade}",
//                 style: TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Nunito',
//                     fontSize: 9),
//               ),
//             ],
//           ),
//         ]),
//       ),
//     );
//   }
//
//   Widget product(ResultProduct result){
//     print('lddlldld');
//     return Card(
//       // elevation: 2,
//     child: Column(children: [
//       Container(
//         // color: Colors.red,
//         height: 40,
//         // width: double.infinity,
//         decoration: BoxDecoration(
//  // color: Colors.red,
//             image: DecorationImage(image: NetworkImage(result.image.toString()),fit: BoxFit.cover)),
//       ),
//       SizedBox(height: 10,),
//       Container(width: double.infinity,
// child: Text(result.name.toString()),
//       ),
//       SizedBox(height: 10,),
//       Container(
//
//           child: Divider(
//             color: Colors.grey,
//           )),
//       Row(
//         children: [
//
//           Container(
//             child: Text('Price : '),
//           ),
//
//           Container(
//             child: Text(result.listPrice.toString()),
//           ),
//         ],
//       ),
//
//       SizedBox(height: 10,),
//       Container(
//
//           child: Divider(
//             color: Colors.grey,
//           )),
//       Row(
//         children: [
//
//           Container(
//             child: Text('Meals Description : '),
//           ),
//
//           Container(
//             child: Text(result.descriptionForMeals.toString()),
//           ),
//         ],
//       ),
//
//       // SizedBox(height: 10,),
//       // Container(
//       //
//       //     child: Divider(
//       //       color: Colors.grey,
//       //     )),
//       // Row(
//       //   children: [
//       //
//       //     Container(width: double.infinity,
//       //       child: Text('Nutritional Values : '),
//       //     ),
//       //
//       //     Container(width: double.infinity,
//       //       child: Text(result.nutritionalValue.toString()),
//       //     ),
//       //   ],
//       // ),
//       //
//       // SizedBox(height: 10,),
//       // Container(
//       //
//       //     child: Divider(
//       //       color: Colors.grey,
//       //     )),
//       // Row(
//       //   children: [
//       //
//       //     Container(width: double.infinity,
//       //       child: Text('Allergies : '),
//       //     ),
//       //
//       //     Container(width: double.infinity,
//       //       child: Text(result.listPrice.toString()),
//       //     ),
//       //   ],
//       // ),
//       //
//       //
//       //
//       // SizedBox(height: 10,),
//       // Container(
//       //
//       //     child: Divider(
//       //       color: Colors.grey,
//       //     )),
//       // Row(
//       //   children: [
//       //
//       //     Container(width: double.infinity,
//       //       child: Text('Allowed To Sell : '),
//       //     ),
//       //
//       //     Container(width: double.infinity,
//       //       child: Checkbox(value:isChecked , onChanged: (value) {
//       //         setState(() {
//       //           isChecked=value!;
//       //         });
//       //
//       //       },),
//       //     ),
//       //   ],
//       // ),
//
//
//     ]),
//     );
//
//
//   }
//
// }
