import 'dart:async';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/canteen_student.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/modules/canteen/Food_Allergies.dart';
import 'package:udemy_flutter/modules/canteen/banned_profiel.dart';
import 'package:udemy_flutter/modules/canteen/category.dart';
import 'package:udemy_flutter/modules/canteen/daily_spending.dart';
import 'package:udemy_flutter/modules/canteen/day_food.dart';
import 'package:udemy_flutter/modules/canteen/item.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';

import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:upgrader/upgrader.dart';

class Create_Canteen extends StatefulWidget {
  const Create_Canteen({Key? key}) : super(key: key);

  @override
  State<Create_Canteen> createState() => _Create_CanteenState();
}

class _Create_CanteenState extends State<Create_Canteen> {
  final controller = ScrollController();
  List colors=[Color(0xfff9a200),Color(0xff3c92d0),Color(0xff7cb13b),Color(0xffe84314),Color(0xfff9a200),Color(0xff3c92d0),Color(0xff7cb13b),];
  int index_co=0;
  String student_name = '';
  bool flg = false;
  String bannedFood = '';
  double par=0;
  List<GestureDetector> list_allergie = [];
  static List<Spending> spending = [];
  static List<SchduleMeals> schduleMeals = [];
  static List<FoodAllegies> foodAllegies = [];

  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState

    if (AppCubit.spending.length>0) {

      if (AppCubit.spending[0].canteenSpending == '0' ||
          AppCubit.spending[0].canteenSpending == 'None') {
        flg = true;
        AppCubit.show_ecan = false;
        AppCubit()
          ..getAllAllergies(AppCubit.std);
      }
      else {
        setState(() {
          spending = AppCubit.spending;
          foodAllegies = AppCubit.foodAllegies;
          schduleMeals = AppCubit.schduleMeals;
          bannedFood = AppCubit.bannedFood;
          par = spending[0].perSpending!;
          AppCubit.show_ecan = true;
          for (int i = 0; i < AppCubit.foodAllegies.length; i++) {
            list_allergie.add(GestureDetector(
              onTap: () {},
              child: Container(
                width: 100,
                child: Card(
                  color: Color(0xfffdede8),
                  shape:
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11)),
                  child: Row(children: [
                    Icon(
                      Icons.disabled_visible,
                      color: Colors.red,
                      size: 13,
                    ),
                    Expanded(
                        child: Text(
                          AppCubit.foodAllegies[i].name.toString(),
                          style: TextStyle(fontSize: 10, color: Colors.red),
                        ))
                  ]),
                ),
              ),
            ));
          }
        });
      }
    }
    setState(() {});
    super.initState();

  }





  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getCanteen(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          index_co=0;

        },
        builder: (context, state) {
          FirebaseMessaging.onMessageOpenedApp.listen((event) {});

          FirebaseMessaging.onMessage.listen((event) {});
          return WillPopScope(
              onWillPop: () async {
                AppCubit.student_name='';
                AppCubit.show_ecan = false;
                flg=false;
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => General_app()));
                return false;
              },
              child: UpgradeAlert(
                upgrader: Upgrader(
                    shouldPopScope: () => true,
                    canDismissDialog: true,
                    durationUntilAlertAgain: Duration(days: 1),
                    dialogStyle: Platform.isIOS
                        ? UpgradeDialogStyle.cupertino
                        : UpgradeDialogStyle.material),
                child: Scaffold(
                  bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home6.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9), Color(0xff3c92d0), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),

                  backgroundColor: Color(0xfff5f7fb),
                  //end navigation bar
                  body: SingleChildScrollView(
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: 1,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                Container(
                                    color: Colors.white,
                                    alignment:
                                        CacheHelper.getBoolean(key: 'lang')
                                                .toString()
                                                .contains('ar')
                                            ? Alignment.topRight
                                            : Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 30, top: 0, right: 30),
                                    child: Image(
                                      image: AssetImage(
                                          AppCubit.trackware_school),
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                    )),
                                Container(
                                  color: Colors.white,
                                  height: 30.w,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: AppCubit.list_st.length,
                                    itemBuilder: (context, index) {
                                      return student_list(
                                          index, AppCubit.list_st[index]);
                                    },
                                  ),
                                ),
                                AppCubit.show_ecan?Visibility(visible: AppCubit.show_ecan,
                                    child: ecanteen('image', 'text')): Visibility(
                            visible:  !AppCubit.show_ecan,
                            child: empty(
                            "images/food_11.png",
                            AppLocalizations.of(context)
                                .translate('canteen_profile')),
                            ),


                                Visibility(
                                    visible:  !AppCubit.show_ecan&&flg,
                                    child: Container(
                                      child: Text(
                                          "craete " +
                                              ' \'${AppCubit.student_name}\' ' +
                                              " Canteen Profile",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff98aac9))),
                                    )),
                                Visibility(
                                  visible:  !AppCubit.show_ecan&&flg,
                                  child: InkWell(
                                    onTap: () async {
                                      //Allergies
                                      // AppCubit.show_ecan=true;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Allergies()));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 80, vertical: 30),
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Color(0xff3c92d0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)
                                            .translate('create'),
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                ),
              ));
        },
      ),
    );
  }

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: EdgeInsets.only(
          left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
              ? 0
              : 8,
          right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
              ? 8
              : 0),
      child: InkWell(
        onTap: () async{
          AppCubit.student_name = listDetail1.fname!;
          AppCubit.std= listDetail1.id.toString();
          AppCubit.image=listDetail1.avatar.toString();
          setState(() {
            flg = true;
            AppCubit.show_ecan=false;
            list_allergie.clear();
          });
          await AppCubit()..getCanteen().then((value) {
            // print(AppCubit.spending[0].canteenSpending);
            if(AppCubit.spending[0].canteenSpending != '0' && AppCubit.spending[0].canteenSpending != 'None')
              {
                setState(() {
                  spending =AppCubit.spending;
                  foodAllegies =AppCubit.foodAllegies;
                  schduleMeals =AppCubit.schduleMeals;
                  bannedFood=AppCubit.bannedFood;
                  par=spending[0].perSpending!;
                  AppCubit.show_ecan = true;

                  for (int i = 0; i < AppCubit.foodAllegies.length; i++) {
                    list_allergie.add(GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 100,
                        child: Card(
                          color: Color(0xfffdede8),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                          child: Row(children: [
                            Icon(
                              Icons.disabled_visible,
                              color: Colors.red,
                              size: 13,
                            ),
                            Expanded(
                                child: Text(
                                  AppCubit.foodAllegies[i].name.toString(),
                                  style: TextStyle(fontSize: 10, color: Colors.red),
                                ))
                          ]),
                        ),
                      ),
                    ));
                  }
                });
              }


          }).onError((error, stackTrace) {


          });

        },
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: CacheHelper.getBoolean(key: 'lang')
                        .toString()
                        .contains('ar')
                    ? 0
                    : 10,
                right: CacheHelper.getBoolean(key: 'lang')
                        .toString()
                        .contains('ar')
                    ? 10
                    : 0),
            child: Column(children: [
              Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(60.0))),
                elevation: 4.0,
                child: Container(
                  height: 16.w,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    maxRadius: MediaQuery.of(context).size.width / 12,
                    backgroundImage: NetworkImage(
                      '${listDetail1.avatar}',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${listDetail1.fname}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito',
                    fontSize: 9.sp),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget ecanteen(String image, String text) {
    return SingleChildScrollView(
      child: Container(
        // alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20),

        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(AppCubit.student_name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    color: Colors.black)),
            Column(
              children: [
                Card(
                  color: Color(0xff3c92d0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  // width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: CircularPercentIndicator(
                        radius: 90,
                        lineWidth: 10,
                        animation: true,
                        arcType: ArcType.HALF,
                        percent: par,
                        arcBackgroundColor: Colors.white.withOpacity(0.3),
                        startAngle: 1,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.white,
                        center: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('daily_Spending'),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppCubit.spending[0].studentSpending.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "/"+ AppCubit.spending[0].canteenSpending.toString() +"JOD",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: InkWell(
                                  onTap: () async {
                                    //Allergies
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Spending_day()));
                                  },
                                  child: Container(
                                    height: 30,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    // padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Color(0xfff9a200),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('Add_Allawnce'),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Allergies()));
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            AppLocalizations.of(context)
                                .translate('food_Allergies'),
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 12,
                                color: Colors.black)),
                        Wrap(
                            // alignment: WrapAlignment.spaceEvenly,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: list_allergie),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xffa3c9e6),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            "images/ingredients.svg",
                            height: 20,
                            width: 20,
                            color: Colors.white,
                          )),
                    ),
                  )
                ]),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Stack(children: <Widget>[
                Stack(
                  alignment: CacheHelper.getBoolean(key: 'lang')
                          .toString()
                          .contains('ar')
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 50 / 2.0, bottom: 15),

                      ///here we create space for the circle avatar to get ut of the box
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xffe84d1f),
                        ),
                        width: double.infinity,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 0, bottom: 0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate('banned_Food'),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            bannedFood +" "+
                                                AppLocalizations.of(context)
                                                    .translate('items'),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {

                                        await AppCubit()..getBanned();


                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Banned_Profiel()));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SvgPicture.asset(
                                          "images/add_icon.svg",
                                          height: 20,
                                          width: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),

                    ///Image Avatar
                    Container(
                        margin: EdgeInsets.only(left: 0, right: 0),
                        width: 100,
                        height: 80,
                        child: Image.asset(
                          'images/pizza_1.png',
                        )),
                  ],
                ),
              ]),
            ),
            Text(AppLocalizations.of(context).translate('schedule_Meals'),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 14,
                    color: Colors.black)),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                  itemCount: schduleMeals.length+1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {

                    if(schduleMeals.length<=index){

                      return SizedBox(height: 100,);
                    }
                    else{
                    return list_schedule(schduleMeals[index],index);}
                  },),
          ]),
        ),
      ),
    );
  }

  Widget list_schedule(SchduleMeals schduleMeals_1,int index) {


    
    return Card(
      elevation: 0,
      color: colors[index].withOpacity(.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),side: BorderSide(color:colors[index] )),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(50)),
            child: Padding(
                padding: EdgeInsets.all(5),
                child: SvgPicture.asset(
                  "images/icons8_vegetarian_food.svg",
                  height: 20,
                  width: 20,
                  color:Colors.white,
                )),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                schduleMeals_1.name.toString(),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                schduleMeals_1.lenItem.toString()+" " + AppLocalizations.of(context).translate('items'),
                style: TextStyle(color: colors[index], fontSize: 12),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                int day_id=schduleMeals_1.day_id!;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Food_day_student(name:schduleMeals_1.name.toString(),day_id:day_id ,)));
              //  Item_food
              },
              child: SvgPicture.asset(
                "images/add_icon.svg",
                height: 20,
                width: 20,
                color: colors[index],
              ),
            ))
      ]),
    );
  }

  Widget list_allergies(String text) {
    return Container(
      width: 100,
      child: Card(
        color: Colors.blue,
        child: Row(children: [
          Icon(
            Icons.disabled_visible,
            color: Colors.red,
            size: 10,
          ),
          Expanded(
              child: Text(
            text.toString(),
            style: TextStyle(fontSize: 10, color: Colors.red),
          ))
        ]),
      ),
    );
  }

  Widget empty(String image, String text) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(children: [
            // CustomLotte('assets/lang/seedRound_Cup.json'),
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
      ),
    );
  }
}
