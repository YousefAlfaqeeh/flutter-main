import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/home.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/login/now_login.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List data = ["English", "عربي"];
  bool swtBusCheckIn = true, swtBusCheckOut = true, swtBusNear = true;
  var lang, lang1;

  // postsetting() async {
  //   var data = {
  //     "notifications": {
  //       "nearby": swtBusNear.toString(),
  //       "check_in": swtBusCheckIn.toString(),
  //       "check_out": swtBusCheckOut.toString(),
  //       "locale": "\"$lang\"",
  //     }.toString()
  //   };
  //   // print(CacheHelper.getBoolean(key: 'swtBusNear'));
  //   var responseKids=await DioHelper.postData(url:Settings , data:data,token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {
  //   },).catchError((onError){
  //     showDialog(context: context, builder: (context) => dialog(massage: 'Connection Error', title: Image(image: AssetImage('images/img_error.png')) ),);
  //
  //   });
  //
  //
  //
  // }
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getSetting(),

      child:BlocConsumer<AppCubit,AppStates>(
         listener: (context, state) {

         },
        builder: (context, state) {
          return
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark,
            child: Scaffold(

              backgroundColor: Colors.white,
              bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/settings_full.svg","images/bus.svg", Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9),  Color(0xff7cb13b), Color(0xff98aac9)),


              body: SingleChildScrollView(
                child: SafeArea(
                  minimum: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Container(
                    color: Colors.grey[300],
                    // decoration: ,

                    child: Container(
                      color: Colors.white,

                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(child: Image(image: AssetImage(AppCubit.trackware_school) ,width: MediaQuery.of(context).size.width/6,height: MediaQuery.of(context).size.height/10,) ),
                        Row(children: [
                           Expanded(
                              child: Text(AppLocalizations.of(context).translate('checked_in')
                       ,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),
                              )),
                          Switch(
                            value: AppCubit.get(context).swtBusCheckIn,
                            onChanged: (val) {
                              // setState(() {
                              //   swtBusCheckIn = val;
                              CacheHelper.saveData(key: 'swtBusCheckIn', value: val);
                              AppCubit.get(context).getSettingLocal();

                               AppCubit.get(context).setting();
                              // postsetting();
                              // });
                            },
                          )
                        ]),
                        const Divider(color: Colors.black),
                        SizedBox(
                          width: double.infinity,
                          child: Row(children: [
                             Expanded(
                                child: Text( AppLocalizations.of(context).translate('checked_out')
                                  ,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )),
                            Switch(
                              value: AppCubit.get(context).swtBusCheckOut,
                              onChanged: (val) {
                                CacheHelper.saveData(key: 'swtBusCheckOut', value: val);
                                AppCubit.get(context).getSettingLocal();

                                  AppCubit.get(context).setting();
                                // postsetting();

                              },
                            )
                          ]),
                        ),
                        const Divider(color: Colors.black),
                        SizedBox(
                          width: double.infinity,
                          child: Row(children: [
                             Expanded(
                                child: Text(
                                  AppLocalizations.of(context).translate('near'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,  fontSize: 17
                                  ),
                                )),
                            Switch(
                              value:AppCubit.get(context).swtBusNear,
                              onChanged: (val) {
                                // setState(() {
                                //   swtBusNear = val;
                                //   CacheHelper.saveData(key: 'swtBusNear', value: val);
                                //   postsetting();
                                // });

                                CacheHelper.saveData(key: 'swtBusNear', value: val);
                                AppCubit.get(context).getSettingLocal();
                                AppCubit.get(context).setting();
                                // postsetting();

                              },
                            )
                          ]),
                        ),
                        const Divider(color: Colors.black),
                        Row(children: [
                           Expanded(
                              child: Text(AppLocalizations.of(context).translate('language2')
                                ,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,  fontSize: 17
                                ),
                              )),
                          DropdownButton(
                            hint:  Text(
                              AppLocalizations.of(context).translate('language1'),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            items: ["English", "عربي"]
                                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                lang1 = value;
                              });
                              if (value == 'عربي') {
                                lang = 'ar';
                              } else {
                                lang = 'en';
                              }

                              showDialog(
                                context: context,
                                builder: (context) => dialog_sure(
                                  massage: AppLocalizations.of(context).translate('change_language'),
                                  functionOK: () async {
                                    Navigator.pop(context);
                                    CacheHelper.saveData(key: 'lang', value: lang);
                                    AppCubit.get(context).getSettingLocal();
                                    AppCubit.get(context).setting();
                                    AppCubit.get(context).setLang();
                                    // postsetting();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Hiome_Kids(),
                                        ));
                                  },
                                ),
                              );

                            },
                            value: lang1,
                          )
                        ]),
                            const Divider(color: Colors.black),
                            InkWell(onTap: () async {
                              AppCubit()
                                ..getschool();
                              await AppCubit.get(context).getschool();
                              await  AppCubit()..logout();

                              CacheHelper.saveData(
                                  key: 'authorization', value: '');
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddNewTask(),));

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => AddNewTask()),
                              // );
                            },
                              child: Text(AppLocalizations.of(context).translate('logout')
                              ,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,  fontSize: 17
                              ),
                            ),)

                      ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )

    );;
  }
}
