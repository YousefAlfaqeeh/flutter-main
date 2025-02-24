import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';

import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/canteen/item.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class Food_day_student extends StatefulWidget {
  String name;

  int day_id;

  Food_day_student({required this.name, required this.day_id});

  @override
  State<Food_day_student> createState() => _Food_day_studentState();
}

class _Food_day_studentState extends State<Food_day_student> {
  bool all_day = false;
  bool all_ch = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getFood(widget.day_id),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // shwoDialog();
        },
        builder: (context, state) {
          FirebaseMessaging.onMessageOpenedApp.listen((event) {});

          FirebaseMessaging.onMessage.listen((event) {});
          return WillPopScope(
              onWillPop: () async {
                AppCubit()
                  ..getCanteen().then(
                    (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Create_Canteen()));
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Create_Canteen(),));
                              },
                              icon: SvgPicture.asset(
                                  "images/chevron_left_solid.svg",
                                  color: Color(0xff98aac9)),
                            ),
                          ),
                          Text(
                            widget.name,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Item_food(
                                              name: AppLocalizations.of(context)
                                                  .translate('banned_food'),
                                              type: "day",
                                              day_id: widget.day_id,
                                            )));
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xff3c92d0)),
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
                                              .translate('add_item1'),
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
                                      AppCubit.student_name = '';
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
                                      AppCubit.student_name = '';
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
                                      AppCubit.student_name = '';
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
                                      AppCubit.student_name = '';
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
                                      AppCubit.student_name = '';
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
                      children: AppCubit.dateItem.length > 0
                          ? [
                              Container(
                                height: 55.h,
                                color: Color(0xfff5f7fb),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      list_item(index),
                                  itemCount: AppCubit.dateItem.length < 0
                                      ? AppCubit.dateItem.length + 2
                                      : AppCubit.dateItem.length,
                                ),
                              ),
                              // SizedBox(
                              //   height: 100,
                              // ),
                              // Container(child: Text('data'),)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, ),
                                child: Container(
                                  // color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Theme(
                                        data: ThemeData(
                                            unselectedWidgetColor:
                                                Color(0xff98aac9)),
                                        child: Checkbox(
                                          checkColor: Colors.white,
                                          value: all_day,
                                          onChanged: (bool? value)async {
                                            setState(() {
                                              all_day = value!;
                                            });
                                            if(all_day)
                                              {

                                                await DioHelper.postData(
                                                    url: Post_canteen_all_day,
                                                    data: {
                                                      "student_id": AppCubit.std,
                                                      "all_ch": all_ch,
                                                      "day_id":widget.day_id

                                                    },
                                                    token: CacheHelper.getBoolean(key: 'authorization'))
                                                    .then(
                                                      (value) async {
                                                        print(value.data);
                                                  },
                                                ).catchError((onError) {
                                                  print("---------");
                                                  print(onError);
                                                });
                                              }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: RichText(
                                              text: TextSpan(
                                            text:  AppLocalizations.of(context)
                                                .translate('all_day'),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                                color: Colors.black,
                                                fontSize: 16),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16),
                          child: Container(
                            // color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                      Color(0xff98aac9)),
                                  child: Checkbox(
                                    checkColor: Colors.white,
                                    value: all_ch,
                                    onChanged: (bool? value)async {

                                      setState(() {
                                        all_ch = value!;
                                      });
                                      await DioHelper.postData(
                                          url: Get_food_all_student,
                                          data: {
                                            "student_id": AppCubit.std,
                                            "all_ch": all_ch,
                                            "day_id":widget.day_id

                                          },
                                          token: CacheHelper.getBoolean(key: 'authorization'))
                                          .then(
                                            (value) async {

                                        },
                                      ).catchError((onError) {
                                        // print(onError);
                                      });

                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment:
                                    AlignmentDirectional.centerStart,
                                    child: RichText(
                                        text: TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate('all_ch'),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Nunito',
                                              color: Colors.black,
                                              fontSize: 16),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                            ]
                          : [
                              empty(
                                  "images/food_11.png",
                                  AppLocalizations.of(context)
                                      .translate('canteen_profile_food'))
                            ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget list_item(int ind) {
    if (AppCubit.dateItem.length >= ind) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text(
                AppCubit.dateItem[ind].type.toString() != 'all'
                    ? AppCubit.dateItem[ind].type.toString()
                    : "",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                  child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Image(
                    image: NetworkImage("${AppCubit.dateItem[ind].image}"),
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
                          AppCubit.dateItem[ind].name.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          AppCubit.dateItem[ind].type.toString() != 'all'
                              ? AppCubit.dateItem[ind].type.toString()
                              : "",
                          style: TextStyle(
                              color: Color(0xff98aac9),
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(AppCubit.dateItem[ind].price.toString(),
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
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: IconButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) => dialog_sure(
                                massage: AppLocalizations.of(context).translate('remove_data'),
                                functionOK: () async {
                                  await DioHelper.postData(
                                      url: Delete_food,
                                      data: {
                                        "id": AppCubit.dateItem[ind].id,
                                      },
                                      token: CacheHelper.getBoolean(
                                          key: 'authorization'))
                                      .then(
                                        (value) async {
                                      AppCubit()
                                        ..getCanteen().then((value) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Food_day_student(
                                                        name: widget.name,
                                                        day_id: widget.day_id,
                                                      )));
                                        });
                                    },
                                  ).catchError((onError) {
                                    // print(onError);
                                  });
                                },
                              ),
                            );


                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          )))
                ],
              )),
            ),
          ],
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
        padding: EdgeInsets.only(top: 50),
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
                  color: Colors.black)),
        ]),
      ),
    );
  }
}
