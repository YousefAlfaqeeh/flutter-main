import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/main.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/loginModel.dart';
import 'package:udemy_flutter/models/school_moudle.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/models/listdetail.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/home.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/splash_screen/home_screen.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  TextEditingController user_name = TextEditingController(),
      pass = TextEditingController();

  // List<School> school_list = [];
  // List<dynamic> school_list1 = [];
  // Kids_list? student;
  // LoginModel? login_info;
  School? data_base, s;
  dialog_sure x= dialog_sure(
  massage: 'change_language',
  functionOK: () async {});

  // Future<bool> internetConnectionChecker() async {
  //   bool result = await InternetConnectionChecker().hasConnection;
  //   if (result == true) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Future Login() async {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     },
  //   );
  //
  //   var formdata = loginKey.currentState;
  //   if (formdata!.validate()) {
  //     if (await internetConnectionChecker()) {
  //       var response = await DioHelper.postData(data: {
  //         'user_name': user_name.text,
  //         'password': pass.text,
  //         'platform': Platform.isAndroid ? 'android' : 'ios',
  //         'mobile_token': 'ssss',
  //         'school_name': data_base?.dbName.toString()
  //       }, url: Login1)
  //           .then((value) async {
  //         login_info = LoginModel.fromJson(value.data);
  //         if (login_info?.status == 'ok') {
  //           CacheHelper.saveData(
  //               key: 'school_name', value: data_base?.dbName.toString());
  //           CacheHelper.saveData(
  //               key: 'authorization', value: login_info?.authorization);
  //           CacheHelper.saveData(
  //               key: 'sessionId', value: login_info?.sessionId);
  //           CacheHelper.saveData(key: 'uid', value: login_info?.uid);
  //           var responseKids = await DioHelper.postData(
  //                   url: Kids_List, data: {}, token: login_info?.authorization)
  //               .then(
  //             (value) async {
  //               student = Kids_list.fromJson(value.data);
  //
  //               if (student!.students!.length > 0) {
  //                 // AppCubit.get(context).setStudents(student!.students!);
  //                 if (CacheHelper.getBoolean(key: 'swtBusCheckOut')
  //                     .toString()
  //                     .isEmpty) {
  //                   var data = {
  //                     "notifications": {
  //                       "\"nearby\"": 'true',
  //                       "\"check_in\"": 'true',
  //                       "\"check_out\"": 'true',
  //                       "\"locale\"": "en",
  //                     }.toString()
  //                   };
  //                   var responseKids = await DioHelper.postData(
  //                           url: Settings,
  //                           data: data,
  //                           token: CacheHelper.getBoolean(key: 'authorization'))
  //                       .then(
  //                     (value) {
  //                       CacheHelper.saveData(
  //                           key: 'swtBusCheckOut', value: true);
  //                       CacheHelper.saveData(key: 'swtBusNear', value: true);
  //                       CacheHelper.saveData(key: 'locale', value: 'en');
  //                       CacheHelper.saveData(key: 'swtBusCheckIn', value: true);
  //                     },
  //                   ).catchError((onError) {
  //                     showDialog(
  //                       context: context,
  //                       builder: (context) => dialog(
  //                           massage: 'Connection Error',
  //                           title: Image(
  //                               image: AssetImage('images/img_error.png'))),
  //                     );
  //                   });
  //                 }
  //                 Navigator.push(
  //                     context,
  //                     MaterialPageRoute(
  //                       builder: (context) => Kids(),
  //                     ));
  //               } else {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) => dialog(
  //                       massage: 'No Children',
  //                       title:
  //                           Image(image: AssetImage('images/img_error.png'))),
  //                 );
  //               }
  //             },
  //           ).catchError((onError) {
  //             print(onError);
  //             showDialog(
  //               context: context,
  //               builder: (context) => dialog(
  //                   massage: 'ddddddddddd',
  //                   title: Image(image: AssetImage('images/img_error.png'))),
  //             );
  //           });
  //         } else {
  //           showDialog(
  //             context: context,
  //             builder: (context) => dialog(
  //                 massage: 'Wrong User name or Password',
  //                 title: Image(image: AssetImage('images/img_error.png'))),
  //           );
  //         }
  //       }).catchError((onError) {
  //         showDialog(
  //           context: context,
  //           builder: (context) => dialog(
  //               massage: 'Connection Error',
  //               title: Image(image: AssetImage('images/img_error.png'))),
  //         );
  //       });
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (context) => dialog(
  //             massage: 'Connection Error',
  //             title: Image(image: AssetImage('images/img_error.png'))),
  //       );
  //     }
  //   }
  // }

  @override
  void initState() {
    // getschool();
    BlocProvider(create:(context) => AppCubit()..getschool());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          // print(state);

          if (state is AppLoginState) {
            if (AppCubit.get(context).status == 'OK') {
              Navigator.pop(context);
              AppCubit.get(context).getChildren();
              // AppCubit.get(context).setting();
            } else if (AppCubit.get(context).status == 'Wrong') {
              // print("--------------------------------Wrong");
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => dialog(
                    massage: AppLocalizations.of(context).translate('wrong'),
                    title: const Image(image: AssetImage('images/img_error.png'))),
              );
            } else if (AppCubit.get(context).status == 'Connection') {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => dialog(
                    massage:
                        AppLocalizations.of(context).translate('connection'),
                    title: const Image(image: AssetImage('images/img_error.png'))),
              );
            }
          }
          if (state is AppKidsState) {
            if (AppCubit.get(context).status == 'ok') {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Hiome_Kids()));

              // AppCubit.get(context).getStudent();
            } else if (AppCubit.get(context).status == 'No Children') {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => dialog(
                    massage:
                        AppLocalizations.of(context).translate('no_Children'),
                    title: const Image(image: AssetImage('images/img_error.png'))),
              );
            } else if (AppCubit.get(context).status == 'Connection') {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => dialog(
                    massage:
                        AppLocalizations.of(context).translate('connection'),
                    title: const Image(image: AssetImage('images/img_error.png'))),
              );
            }
          }
        },
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              SystemNavigator.pop();
              return false;
            },
            child: Scaffold(
              body: Form(
                key: loginKey,
                child: Container(
                  decoration: const BoxDecoration(
                      gradient:  LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      // Colors.white,
/*
                  Colors.blue,
// */
                      Colors.white,
                      const Color.fromRGBO(221, 221, 221, 100),
                      // Colors.blue[100]!,
                    ],
                  )),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 80),
                                // const Placeholder(
                                //   fallbackHeight: 180,
                                // ),
// /*
                                const Image(
                                    image:
                                        AssetImage("images/ic_new_logo.png")),
// */
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          padding:
                                              const EdgeInsetsDirectional.all(
                                                  25),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('login_text'),
                                              style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ))),
                                    ),
                                    Container(
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        padding:
                                            const EdgeInsetsDirectional.all(25),
                                        child: TextButton(onPressed: () {
                                          if(AppLocalizations.of(context).translate('language').toString()=="English")
                                          {
                                            CacheHelper.saveData(
                                                key: 'lang', value: 'en');
                                          }
                                          else{
                                            CacheHelper.saveData(
                                                key: 'lang', value: 'ar');
                                          }
                                          AppCubit.get(context).setLang();
                                          Phoenix.rebirth(context);
                                        }, child: Row(children: [
                                          const Icon(Icons.language,
                                              color: Colors.blue),
                                            Text(
                                                AppLocalizations.of(context)
                                                    .translate('language'),
                                                style:
                                                const TextStyle(color: Colors.blue)

                                              )
                                        ],))
                                    ),
                                  ],
                                ),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: SizedBox(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        // width: double.infinity,
                                        child: Row(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Icon(Icons
                                                  .account_balance_outlined),
                                            ),
                                            DropdownButton<dynamic>(
                                                underline: Container(),
                                                dropdownColor: Colors.white,
                                                icon: const Visibility(
                                                    visible: false,
                                                    child: const Icon(
                                                        Icons.arrow_downward)),
                                                alignment: AlignmentDirectional
                                                    .bottomStart,
                                                // hint: const Icon(Icons.school),
                                                hint: Text(AppLocalizations.of(
                                                        context)
                                                    .translate('school_name')),
                                                items: AppCubit.school_list1
                                                    .map(
                                                        (e) => DropdownMenuItem(
                                                              value: e,
                                                              // child: Expanded(
                                                                  child: Text(AppCubit
                                                                          .locale
                                                                          .toString()
                                                                          .contains(
                                                                              'en')
                                                                      ? e.nameEn.toString()
                                                                      : e.nameAr.toString())),
                                                            )
                                            // )
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    data_base = value;
                                                  });
                                                },
                                                value: data_base)
                                          ],
                                        ),
                                      ),
                                    )),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value?.length == 0) {
                                            Navigator.pop(context);
                                            return "please enter your user name";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .translate('user_name'),
                                            filled: true,
                                            //<-- SEE HERE
                                            fillColor: Colors.white,
                                            prefixIcon:
                                                const Icon(Icons.person_pin),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        controller: user_name)),
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value?.length == 0) {
                                          // return "please enter your Password";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: AppLocalizations.of(context)
                                              .translate('password'),
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Icon(Icons.lock),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              AppCubit.get(context).isObscur();
                                              // setState(() {
                                              //   _isObscur = !_isObscur;
                                              // });
                                            },
                                            child: Icon(
                                                AppCubit.get(context).isObscur1
                                                    ? Icons.visibility_off
                                                    : Icons.visibility),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(15))),
                                      obscureText:
                                          AppCubit.get(context).isObscur1,
                                      controller: pass,
                                    )),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 16),

                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: double.infinity,
                                  // color: Colors.orange,
                                  child: MaterialButton(
                                    child: Text(AppLocalizations.of(context)
                                        .translate('login_text')),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                            child: const CircularProgressIndicator(),
                                          );
                                        },
                                      );
                                      var formdata = loginKey.currentState;

                                      if (formdata!.validate()) {
                                        if (data_base?.dbName.toString() !=
                                                'null' &&
                                            user_name.text
                                                .toString()
                                                .isNotEmpty &&
                                            pass.text.toString().isNotEmpty) {
                                          AppCubit.get(context).Login(
                                              user_name.text,
                                              pass.text,
                                              data_base!.dbName.toString());
                                        } else {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) => dialog(
                                                massage:
                                                    AppLocalizations.of(context)
                                                        .translate('wrong'),
                                                title: const Image(
                                                    image: AssetImage(
                                                        'images/img_error.png'))),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 16),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate('forgot_password'),
                                    style: const TextStyle(
                                      color: Color.fromRGBO(71, 151, 214, 100),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: RichText(
                                      text: TextSpan(
                                    text: AppLocalizations.of(context)
                                        .translate('by_sigining'),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate('Privacy'),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                            AppCubit.get(context).setUrl1('login');
                                            AppCubit.get(context).setUrl('login');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WebView_Login1(
                                                            'https://trackware.com/privacy-policy/'),
                                                  ));
                                            }
                                           ,
                                          style: const TextStyle(
                                            color: const Color.fromRGBO(
                                                71, 151, 214, 100),
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                      TextSpan(
                                        text: AppLocalizations.of(context)
                                            .translate('and'),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                          text: AppLocalizations.of(context)
                                              .translate('Terms'),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              AppCubit.get(context).setUrl1('login');
                                              AppCubit.get(context).setUrl('login');
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        WebView_Login1(
                                                            'https://trackware.com/terms-conditions/'),
                                                  ));
                                            } ,
                                          style: const TextStyle(
                                            color: const Color.fromRGBO(
                                                71, 151, 214, 100),
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                    ],
                                  )),
                                ),
                              ]),
                          const Spacer(),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context).translate('rights'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 25.0,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.red,
                                  Colors.blue,
                                  Colors.green,
                                ],
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
