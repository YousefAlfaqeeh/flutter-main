import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/models/item_m.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/canteen/category.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/canteen/item.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class Banned_Profiel extends StatefulWidget {
  @override
  State<Banned_Profiel> createState() => _Banned_ProfielState();
}

class _Banned_ProfielState extends State<Banned_Profiel> {



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getBanned(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // shwoDialog();
        },
        builder: (context, state) {
          FirebaseMessaging.onMessageOpenedApp.listen((event) {});

          FirebaseMessaging.onMessage.listen((event) {});
          return WillPopScope(
              onWillPop: () async {


    AppCubit()..getCanteen().then((value) {



    Navigator.push(
    context, MaterialPageRoute(builder: (context) => Create_Canteen()));

    },
    ).catchError((onError) {
    // print(onError);
    });



                return false;
              },
              child: Scaffold(
                appBar: AppBar(
                  // primary: false,
                  toolbarHeight: 60,
                  backgroundColor: Colors.white,
                  leadingWidth: MediaQuery.of(context).size.width / 1,

                  leading: Container(
                      padding: EdgeInsets.only(left: 18, top: 10),
                      child: Row(
                        children: [
                          Transform.rotate(
                            angle: CacheHelper.getBoolean(key: 'lang')
                                    .toString()
                                    .contains('ar')
                                ? 9.5
                                : 0,
                            child: IconButton(
                              onPressed: () {
                                Reset.clear_searhe();
                                Navigator.pop(context);
                              },
                              icon: SvgPicture.asset(
                                  "images/chevron_left_solid.svg",
                                  color: Color(0xff98aac9)),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate('banned_food'),
                            style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff3c92d0),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                backgroundColor: Color(0xfff5f7fb),
                bottomNavigationBar: BottomAppBar(
                  shape: CircularNotchedRectangle(),
                  notchMargin: 20,
                  child: Container(
                    height: 140,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          // width: 300,

                          child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  context: context,
                                  builder: (context) =>
                                      DraggableScrollableSheet(
                                    initialChildSize: .3,
                                    minChildSize: .2,
                                    maxChildSize: .97,
                                    expand: false,
                                    builder: (context, scrollController) =>
                                        Scaffold(
                                      bottomNavigationBar: BottomAppBar(
                                        shape: CircularNotchedRectangle(),
                                        notchMargin: 20,
                                        child: Container(
                                          height: 20.h,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await AppCubit()
                                                    ..getCategory();

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Category_food()));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'add_category'),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                child: Divider(
                                                    color: Colors.black,
                                                    endIndent: 10),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Item_food(
                                                                name: AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        'banned_food'),
                                                                type: "banned",
                                                                day_id: 0,
                                                              )));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .translate(
                                                            'add_by_item'),
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      backgroundColor: Colors.transparent,
                                      body: SingleChildScrollView(
                                          controller: scrollController,
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Card(
                                                    color: Color(0xffeaeaea),
                                                    elevation: 0,
                                                    child: Container(
                                                      height: 6,
                                                      width: 50,
                                                    )),
                                                // infoAbsent(),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffe84314)),
                                  height: 60,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 20),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('add'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Tajawal',
                                              fontSize: 15,
                                              color: Colors.white)),
                                    ],
                                  ))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      AppCubit.student_name='';
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Setting(),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "images/icon_feather_search.svg",
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      AppCubit.student_name='';
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Tracking(),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "images/bus.svg",
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      AppCubit.student_name='';
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Hiome_Kids(),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "images/icons8_home.svg",
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      AppCubit.student_name='';
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PickUp_Request(),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "images/picup_empty.svg",
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: MaterialButton(
                                    minWidth: 40,
                                    onPressed: () {
                                      AppCubit.student_name='';
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => General_app(),
                                          ));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          "images/icons8_four_squares.svg",
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    // width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AppCubit.dateIte.length>0 || AppCubit.dataCat.length>0?[
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('banned_categorias'),
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(

                            height:AppCubit.dataCat.length>0?AppCubit.dataCat.length<=2?MediaQuery.of(context).size.height/6:MediaQuery.of(context).size.height/3.5:0,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  filter_list(index),
                              itemCount: AppCubit.dataCat.length,
                              // scrollDirection: Axis.horizontal,
                            )),

                        Expanded(flex: 0,
                          child: Container(
                            height: 50,

                            child: Padding(
                              padding: const EdgeInsets.all(18),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('banned_Items'),
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),



                        Expanded(
                          child: Container(
                            color: Color(0xfff5f7fb),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => list_item(index),
                              itemCount: AppCubit.dateIte.length < 0
                                      ? AppCubit.dateIte.length + 2
                                  : AppCubit.dateIte.length,
                            ),
                          ),
                        ),
                      ]:[empty(
                          "images/food_11.png",
                          AppLocalizations.of(context)
                              .translate('canteen_profile_food'))],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget filter_list(int ind) {

    return InkWell(
     
      child: Padding(
        padding: EdgeInsets.only(
            left: 10,
            right:10),
        child: Container(
          // width: 15.w,
          // height: 100,

          // color: Colors.red,
          child: Card(
            shape: const RoundedRectangleBorder(
                side: BorderSide(width: .8, color: Color(0xffd4ddee)),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(AppCubit.dataCat[ind].name.toString(),style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text(AppCubit.dataCat[ind].categorySup.toString(),style: TextStyle(color: Color(0xff98aac9),fontSize: 12,fontWeight: FontWeight.normal),),

                    ],),
                  ),
                  IconButton(onPressed: () async {


                    await DioHelper.postData(
                        url: Delete_banned,
                        data: {

                          "banned_id":AppCubit.dataCat[ind].id ,

                        },
                        token: CacheHelper.getBoolean(key: 'authorization'))
                        .then(
                          (value) async {
                        AppCubit()..getCanteen().then((value) { Navigator.push(
                            context, MaterialPageRoute(builder: (context) => Banned_Profiel()));});



                      },
                    ).catchError((onError) {
                      // print(onError);
                    });

                  }, icon: Icon(Icons.delete_outline,color: Colors.red,))


                ],

              ),
            ),

          ),
        ),
      ),
    );
  }

  Widget list_item(int ind) {

      if (AppCubit.dateIte.length >= ind) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
                child: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Image(
                  image: NetworkImage("${AppCubit.dateIte[ind].image}"),
                  height: 70,
                  width: 70,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppCubit.dateIte[ind].name.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        AppCubit.dateIte[ind].type.toString() != 'all'
                            ? AppCubit.dateIte[ind].type.toString()
                            : "",
                        style: TextStyle(
                            color: Color(0xff98aac9),
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(AppCubit.dateIte[ind].price.toString(),
                          style: TextStyle(
                              color: Color(0xff3c92d0),
                              fontWeight: FontWeight.normal,
                              fontSize: 15)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child:   IconButton(onPressed: () async {

                      await DioHelper.postData(
                          url: Delete_banned,
                          data: {

                            "banned_id":AppCubit.dateIte[ind].id ,

                          },
                          token: CacheHelper.getBoolean(key: 'authorization'))
                          .then(
                            (value) async {
                          AppCubit()..getCanteen().then((value) { Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Banned_Profiel()));});



                        },
                      ).catchError((onError) {
                        // print(onError);
                      });
                    }, icon: Icon(Icons.delete_outline,color: Colors.red,)))
              ],
            )),
          ),
        );
      }
      return SizedBox(
        height: 100,
      );

  }

  Widget empty(String image, String text) {
    return SingleChildScrollView(
      child: Container(
        padding:EdgeInsets.only(top: 50) ,
        alignment: Alignment.center,
        child: Column(children: [

          Image(
            image: AssetImage(image),
            width: 400,
            height: 239,
          ),
          SizedBox(
            height: 8,
          ),
          Text(text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nunito',
                  fontSize: 22,
                  color: Color(0xff3c92d0))),
        ]),
      ),
    );
  }
}
