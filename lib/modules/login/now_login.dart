import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/school_moudle.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/services/location_services.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';


class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}
class _AddNewTaskState extends State<AddNewTask> {
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  School? data_base, s;
  TextEditingController user_name = TextEditingController(),
      pass = TextEditingController();
  bool isChecked = false;
  bool isChecked2 = false;
  final List<String> genderItems = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  @override
  void initState() {
    // TODO: implement initState

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

              // Navigator.pop(context);
              // AppCubit.get(context).get_notif('', '');
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
              // Navigator.pop(context);
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
              // Timer timer = new Timer(new Duration(seconds: 5), () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Hiome_Kids()));
              // });


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
            child:   Scaffold(
              body: SingleChildScrollView(
                // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                  alignment: Alignment.bottomCenter,
                 color: Colors.white,
               height:MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(


                        decoration: const BoxDecoration(
                          image: DecorationImage(image: AssetImage('images/home_50.png'),fit: BoxFit.cover,colorFilter: ColorFilter.mode( Color(0xff083f6c), BlendMode.lighten)),
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100),bottomRight:  Radius.circular(0)),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff2b78b8),
                                Color(0xff3c92d0),
                              ],
                            )),
                        width: double.infinity,

                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // SizedBox(height:  150),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.only(left: 30,top: 12.w,right: 30),
                                      child: Text(AppLocalizations.of(context)
                                          .translate('login_button'),style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*22, fontFamily: 'Nunito',fontWeight: FontWeight.w900,color: Colors.white))),
                                ),

                                Padding(
                                  padding:  EdgeInsets.only(left: 4.w,right: 4.w,top: 14.w),

                                  child: GestureDetector(
                                    onTap: () {
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
                                    },
                                    child: Container(

                                      alignment: Alignment.center,
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          // width: 70,
                                          height: MediaQuery.of(context).size.height/25,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(20)),
                                          ),
                                          // color: Colors.white,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  AppLocalizations.of(context)
                                                      .translate('language'),
                                                  style:
                                                  TextStyle(color: Color(0xff3c92d0))),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              Text(
                                                "|",
                                                style: TextStyle(color: Color(0xff3c92d0)),
                                              ),
                                              SizedBox(
                                                width: 3,
                                              ),
                                              //images/icons8_english_to_arabic.svg
                                              SvgPicture.asset("images/icons8_english_to_arabic.svg",color:  Color(0xff3c92d0),width:MediaQuery.of(context).size.width/20 ,),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // Icon(Icons.g_translate,
                                              //     size: 20, color: Color(0xff3c92d0)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // Container(alignment: Alignment.topLeft,
                            //     padding: EdgeInsets.only(left: 30),
                            //     child: Text('Login',style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*22, fontFamily: 'Nunito',fontWeight: FontWeight.w900,color: Colors.white))),
                            SizedBox(height:  4.w,),
                            // Container(alignment: Alignment.topLeft,
                            //     padding: EdgeInsets.only(left: 30), child: Text('stay up to date with your Son school ',style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14, fontFamily: 'Nunito',fontWeight: FontWeight.normal,color: Colors.white))),
                            // Container(alignment: Alignment.topLeft,
                            //     padding: EdgeInsets.only(left: 30),child: Text('Homework’s, announcement',style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14, fontFamily: 'Nunito',fontWeight: FontWeight.normal,color: Colors.white))),
                            // Container(alignment: Alignment.topLeft,
                            //     padding: EdgeInsets.only(left: 30),child: Text('transportation and more',style: TextStyle(fontSize: MediaQuery.of(context).textScaleFactor*14, fontFamily: 'Nunito',fontWeight: FontWeight.normal,color: Colors.white))),
                            SizedBox(height:  70,)
                          ],
                        ),
                      ),
                      //button Login
                      Expanded(
                        child: Container(
                          // color: Colors.red,
                          // alignment: Alignment.bottomCenter,
                          padding: EdgeInsets.only(top:  40),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding:  EdgeInsets.symmetric(
                                vertical: 4.w, horizontal: 8.w),
                                  child: DropdownButtonFormField2<dynamic>(
                                    isExpanded: true,
                                    buttonDecoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(width: 1,color:Color(0xff98aac9))


                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    // isExpanded: true,
                                    hint: Row(
                                      children: [

                                        Padding(
                                          padding: EdgeInsets.only(right:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:10,top: 15,bottom: 15,left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?10:0),
                                          child: SvgPicture.asset("images/icons8_school_building.svg",color:  Color(0xff98aac9),width:5.w ,),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('school_name'),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),

                                    icon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color:Colors.black,

                                      ),
                                    ),
                                    iconSize: 25

                                    ,
                                    buttonHeight: 15.w,

                                    // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),

                                    items: AppCubit.school_list1
                                        .map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:4.w,left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?4.w:0),
                                            child: SvgPicture.asset("images/icons8_school_building.svg",color:  Colors.blue,width:6.w ,),
                                          ),

                                          Expanded(
                                            child: Text(

                                              AppCubit
                                                  .locale
                                                  .toString()
                                                  .contains(
                                                  'en')
                                                  ? item.nameEn.toString()
                                                  : item.nameAr.toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                        .toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return AppLocalizations.of(context)
                                            .translate('choose_the_school');
                                      }
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        data_base = value;
                                      });
                                      //Do something when changing the item if you want.
                                    },
                                    onSaved: (value) {
                                      // setState(() {
                                      //   data_base = value;
                                      // });
                                      selectedValue = AppCubit
                                          .locale
                                          .toString()
                                          .contains(
                                          'en')
                                          ? value.nameEn.toString()
                                          : value.nameAr.toString();
                                    },
                                  ),
                                ),
                                Container(
                                  // height: 30.w,
                                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                                    // padding: const EdgeInsets.symmetric(
                                    //     vertical: 10, horizontal: 16),
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value?.length == 0) {
                                            Navigator.pop(context);
                                            return "please enter your user name";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical:5.w ),
                                            hintText: AppLocalizations.of(context)
                                                .translate('user_name'),
                                            hintStyle: TextStyle(color:Color(0xff98aac9).withOpacity(.6) ),
                                            filled: true,
                                            //<-- SEE HERE
                                            fillColor: Colors.white,
                                            prefixIcon:  Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                                              child: Icon(
                                                Icons.account_circle_outlined,
                                                color: Color(0xff98aac9),
                                                size: 7.w,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xffbbc7db)),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            border: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                BorderRadius.circular(10))),
                                        controller: user_name)),
                                Container(
                                    margin: EdgeInsets.only(left: 8.w,right: 8.w,top: 5.w),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value?.length == 0) {
                                          // return "please enter your Password";
                                        }
                                        return null;
                                      },
                                      // textDirection: TextDirection.rtl,
                                      decoration: InputDecoration(
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
                                          contentPadding: EdgeInsets.symmetric(vertical:5.w ),
                                          hintText: AppLocalizations.of(context)
                                              .translate('password'),
                                          hintStyle: TextStyle(color:Color(0xff98aac9).withOpacity(.6)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: Container(
                                              margin: EdgeInsets.symmetric(horizontal: 13),
                                              child: SvgPicture.asset("images/icons8_secure.svg",color:  Color(0xff98aac9),width:6.5.w ,)) ,

                                          enabledBorder: OutlineInputBorder(

                                              borderSide: const BorderSide(
                                                  color: Color(0xffbbc7db)),
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                      obscureText:  AppCubit.get(context).isObscur1,
                                      controller: pass,
                                    )),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 5),
                                //   child:
                                //   Container(
                                //       margin: const EdgeInsets.symmetric(
                                //           vertical:
                                //           0, horizontal: 16),
                                //       child: TextFormField(
                                //         validator: (value) {
                                //           if (value?.length == 0) {
                                //             // return "please enter your Password";
                                //           }
                                //           return null;
                                //         },
                                //         decoration: InputDecoration(
                                //             hintText: AppLocalizations.of(context)
                                //                 .translate('password'),
                                //             filled: true,
                                //             fillColor: Colors.white,
                                //             prefixIcon: Container(
                                //               margin: EdgeInsets.symmetric(horizontal: 15),
                                //                 child: SvgPicture.asset("images/icons8_secure.svg",color:  Color(0xff98aac9),width:6.w ,)) ,
                                //
                                //             enabledBorder: OutlineInputBorder(
                                //                 borderSide: const BorderSide(
                                //                     color: Color(0xffbbc7db)),
                                //                 borderRadius:
                                //                 BorderRadius.circular(10)),
                                //             border: OutlineInputBorder(
                                //                 borderSide: const BorderSide(
                                //                     color: Colors.white),
                                //                 borderRadius:
                                //                 BorderRadius.circular(10))),
                                //         obscureText: true,
                                //         controller: pass,
                                //       )),
                                // ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.5.w),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          // Checkbox(
                                          //   checkColor: Colors.white,
                                          //   value: isChecked2,
                                          //
                                          //   onChanged: (bool? value) {
                                          //     setState(() {
                                          //       isChecked2 = value!;
                                          //     });
                                          //   },
                                          // ),
                                          Expanded(
                                            child: Text(
                                             '',
                                              // AppLocalizations.of(context)
                                              //     .translate('remember_me'),
                                              style: TextStyle(
                                                  color: Colors.black, fontSize: 12),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 10, right: 10),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('forgot_password'),
                                              style: TextStyle(
                                                  color: Color(0xff98aac9),
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.w,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            value: isChecked,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isChecked = value!;
                                              });
                                            },
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment:
                                              AlignmentDirectional.centerStart,
                                              child: RichText(
                                                  text: TextSpan(
                                                    text: AppLocalizations.of(context)
                                                        .translate('by_sigining'),
                                                    style: const TextStyle(
                                                        color: Colors.black, fontSize: 12),
                                                    children: [

                                                      TextSpan(
                                                          text: AppLocalizations.of(context)
                                                              .translate('Privacy'),
                                                          recognizer:
                                                          new TapGestureRecognizer()
                                                            ..onTap = () {
                                                              // AppCubit.get(context).setUrl1('login');
                                                              // AppCubit.get(context).setUrl('login');
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        WebView_Login1(
                                                                            'https://trackware.com/privacy-policy/'),
                                                                  ));
                                                            },
                                                          style: const TextStyle(
                                                            color: Color(0xff3c92d0),
                                                            decoration:
                                                            TextDecoration.underline,
                                                          )),
                                                      TextSpan(
                                                        text: AppLocalizations.of(context)
                                                            .translate('and'),
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            ),
                                                      ),
                                                      TextSpan(
                                                          text: AppLocalizations.of(context)
                                                              .translate('Terms'),
                                                          recognizer:
                                                          new TapGestureRecognizer()
                                                            ..onTap = () {
                                                              // AppCubit.get(context).setUrl1('login');
                                                              // AppCubit.get(context).setUrl('login');
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        WebView_Login1(
                                                                            'https://trackware.com/privacy-policy/'),
                                                                  ));
                                                            },
                                                          style: const TextStyle(
                                                            color: Color(0xff3c92d0),
                                                            decoration:
                                                            TextDecoration.underline,
                                                          )),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                InkWell(
                                  onTap: () async {
                                    if(isChecked){
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                            child: const CircularProgressIndicator(),
                                          );
                                        },
                                      );
                                      AppCubit.get(context).Login(
                                          user_name.text,
                                          pass.text,
                                          data_base!.dbName.toString());
                                    }
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return const Center(
                                    //       child: const CircularProgressIndicator(),
                                    //     );
                                    //   },
                                    // );
                                    // var formdata = loginKey.currentState;
                                    // if (formdata!.validate()) {
                                    //   if (data_base?.dbName.toString() !=
                                    //       'null' &&
                                    //       user_name.text
                                    //           .toString()
                                    //           .isNotEmpty &&
                                    //       pass.text.toString().isNotEmpty) {
                                    //     AppCubit.get(context).Login(
                                    //         user_name.text,
                                    //         pass.text,
                                    //         data_base!.dbName.toString());
                                    //   } else {
                                    //     Navigator.pop(context);
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (context) => dialog(
                                    //           massage:
                                    //           AppLocalizations.of(context)
                                    //               .translate('wrong'),
                                    //           title: const Image(
                                    //               image: AssetImage(
                                    //                   'images/img_error.png'))),
                                    //     );
                                    //   }
                                    // }}
                                  },

                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 1.w),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: isChecked?Color(0xff3c92d0):Color(0xffbbc7db).withOpacity(.51),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .translate('login_button'),
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(vertical: 20),
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(AppCubit.new_logo),
                                    width: 50.w,
                                    height: 10.w,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // ),
                    ],
                  ),
                  // ),
                ),
              ),
            ),
          );
        },
      ),
    );

  }
  // Future<Widget> login() async {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Container(
  //         decoration: const BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage('images/home_50.png'),
  //             fit: BoxFit.cover,
  //             colorFilter: ColorFilter.mode(
  //               Color(0xff083f6c),
  //               BlendMode.lighten,
  //             ),
  //           ),
  //           borderRadius: BorderRadius.only(
  //             bottomLeft: Radius.circular(100),
  //             bottomRight: Radius.circular(0),
  //           ),
  //           gradient: LinearGradient(
  //             begin: Alignment.topRight,
  //             end: Alignment.bottomLeft,
  //             colors: [
  //               Color(0xff2b78b8),
  //               Color(0xff3c92d0),
  //             ],
  //           ),
  //         ),
  //         width: double.infinity,
  //         child: Column(
  //           children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 14.w),
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       if (AppLocalizations.of(context).translate('language').toString() == "English") {
  //                         CacheHelper.saveData(key: 'lang', value: 'en');
  //                       } else {
  //                         CacheHelper.saveData(key: 'lang', value: 'ar');
  //                       }
  //                       AppCubit.get(context).setLang();
  //                       Phoenix.rebirth(context);
  //                     },
  //                     child: Container(
  //                       alignment: Alignment.center,
  //                       child: InkWell(
  //                         child: Container(
  //                           alignment: Alignment.center,
  //                           height: MediaQuery.of(context).size.height / 25,
  //                           decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.all(Radius.circular(20)),
  //                           ),
  //                           child: Row(
  //                             children: [
  //                               SizedBox(width: 10),
  //                               Text(
  //                                 AppLocalizations.of(context).translate('language'),
  //                                 style: TextStyle(color: Color(0xff3c92d0)),
  //                               ),
  //                               SizedBox(width: 3),
  //                               Text(
  //                                 "|",
  //                                 style: TextStyle(color: Color(0xff3c92d0)),
  //                               ),
  //                               SizedBox(width: 3),
  //                               SvgPicture.asset(
  //                                 "images/icons8_english_to_arabic.svg",
  //                                 color: Color(0xff3c92d0),
  //                                 width: MediaQuery.of(context).size.width / 20,
  //                               ),
  //                               SizedBox(width: 10),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Container(
  //               alignment: Alignment.topLeft,
  //               padding: EdgeInsets.only(left: 30),
  //               child: Text(
  //                 'WELCOME BACK',
  //                 style: TextStyle(
  //                   fontSize: MediaQuery.of(context).textScaleFactor * 22,
  //                   fontFamily: 'Nunito',
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 4.w),
  //             Container(
  //               alignment: Alignment.topLeft,
  //               padding: EdgeInsets.only(left: 30),
  //               child: Text(
  //                 'stay up to date with your Sun school ',
  //                 style: TextStyle(
  //                   fontSize: MediaQuery.of(context).textScaleFactor * 14,
  //                   fontFamily: 'Nunito',
  //                   fontWeight: FontWeight.normal,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               alignment: Alignment.topLeft,
  //               padding: EdgeInsets.only(left: 30),
  //               child: Text(
  //                 'Homework’s, announcement',
  //                 style: TextStyle(
  //                   fontSize: MediaQuery.of(context).textScaleFactor * 14,
  //                   fontFamily: 'Nunito',
  //                   fontWeight: FontWeight.normal,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             Container(
  //               alignment: Alignment.topLeft,
  //               padding: EdgeInsets.only(left: 30),
  //               child: Text(
  //                 'transportation and more',
  //                 style: TextStyle(
  //                   fontSize: MediaQuery.of(context).textScaleFactor * 14,
  //                   fontFamily: 'Nunito',
  //                   fontWeight: FontWeight.normal,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 15.w),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: Container(
  //           child: SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Padding(
  //                   padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 8.w),
  //                   child: DropdownButtonFormField2<dynamic>(
  //                     buttonDecoration: BoxDecoration(
  //                       color: Colors.white,
  //                       borderRadius: BorderRadius.circular(8),
  //                       border: Border.all(width: 1, color: Color(0xff98aac9)),
  //                     ),
  //                     decoration: InputDecoration(
  //                       isDense: true,
  //                       contentPadding: EdgeInsets.zero,
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(8),
  //                       ),
  //                     ),
  //                     hint: Row(
  //                       children: [
  //                         Padding(
  //                           padding: EdgeInsets.only(right: 10.0, top: 15, bottom: 15, left: 0),
  //                           child: SvgPicture.asset(
  //                             "images/icons8_school_building.svg",
  //                             color: Color(0xff98aac9),
  //                             width: 5.w,
  //                           ),
  //                         ),
  //                         Text(
  //                           AppLocalizations.of(context).translate('school_name'),
  //                           style: TextStyle(fontSize: 15),
  //                         ),
  //                       ],
  //                     ),
  //                     icon: Padding(
  //                       padding: const EdgeInsets.all(10.0),
  //                       child: const Icon(
  //                         Icons.keyboard_arrow_down,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     iconSize: 25,
  //                     buttonHeight: 15.w,
  //                     dropdownDecoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     items: AppCubit.school_list1.map((item) => DropdownMenuItem(
  //                       value: item,
  //                       child: Row(
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.only(right: 4.w),
  //                             child: SvgPicture.asset(
  //                               "images/icons8_school_building.svg",
  //                               color: Colors.blue,
  //                               width: 6.w,
  //                             ),
  //                           ),
  //                           Text(
  //                             AppCubit.locale.toString().contains('en') ? item.nameEn.toString() : item.nameAr.toString(),
  //                             style: const TextStyle(
  //                               fontSize: 15,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )).toList(),
  //                     validator: (value) {
  //                       if (value == null) {
  //                         return AppLocalizations.of(context).translate('choose_the_school');
  //                       }
  //                     },
  //                     onChanged: (value) {
  //                       setState(() {
  //                         data_base = value;
  //                       });
  //                     },
  //                     onSaved: (value) {
  //                       selectedValue = AppCubit.locale.toString().contains('en') ? value.nameEn.toString() : value.nameAr.toString();
  //                     },
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 8.w),
  //                   child: TextFormField(
  //                     validator: (value) {
  //                       if (value?.isEmpty ?? true) {
  //                         return AppLocalizations.of(context).translate('please_enter_your_user_name');
  //                       }
  //                       return null;
  //                     },
  //                     decoration: InputDecoration(
  //                       contentPadding: EdgeInsets.symmetric(vertical: 5.w),
  //                       hintText: AppLocalizations.of(context).translate('user_name'),
  //                       hintStyle: TextStyle(color: Color(0xff98aac9).withOpacity(.6)),
  //                       filled: true,
  //                       fillColor: Colors.white,
  //                       prefixIcon: Padding(
  //                         padding: EdgeInsets.symmetric(horizontal: 2.5.w),
  //                         child: Icon(
  //                           Icons.account_circle_outlined,
  //                           color: Color(0xff98aac9),
  //                           size: 7.w,
  //                         ),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: Color(0xffbbc7db)),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       border: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: Colors.white),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     controller: user_name,
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 8.w, right: 8.w, top: 5.w),
  //                   child: TextFormField(
  //                     validator: (value) {
  //                       if (value?.isEmpty ?? true) {
  //                         // return "please enter your Password";
  //                       }
  //                       return null;
  //                     },
  //                     decoration: InputDecoration(
  //                       contentPadding: EdgeInsets.symmetric(vertical: 5.w),
  //                       hintText: AppLocalizations.of(context).translate('password'),
  //                       hintStyle: TextStyle(color: Color(0xff98aac9).withOpacity(.6)),
  //                       filled: true,
  //                       fillColor: Colors.white,
  //                       prefixIcon: Container(
  //                         margin: EdgeInsets.symmetric(horizontal: 13),
  //                         child: SvgPicture.asset(
  //                           "images/icons8_secure.svg",
  //                           color: Color(0xff98aac9),
  //                           width: 6.5.w,
  //                         ),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: Color(0xffbbc7db)),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       border: OutlineInputBorder(
  //                         borderSide: const BorderSide(color: Colors.white),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                     obscureText: true,
  //                     controller: pass,
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(horizontal: 5.5.w),
  //                   child: Column(
  //                     children: [
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Checkbox(
  //                             checkColor: Colors.white,
  //                             value: isChecked2,
  //                             onChanged: (bool? value) {
  //                               setState(() {
  //                                 isChecked2 = value!;
  //                               });
  //                             },
  //                           ),
  //                           Expanded(
  //                             child: Text(
  //                               AppLocalizations.of(context).translate('remember_me'),
  //                               style: TextStyle(color: Colors.black, fontSize: 12),
  //                             ),
  //                           ),
  //                           Padding(
  //                             padding: EdgeInsets.only(left: 10, right: 10),
  //                             child: Text(
  //                               AppLocalizations.of(context).translate('forgot_password'),
  //                               style: TextStyle(color: Color(0xff98aac9), fontSize: 12),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(height: 6.w),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.start,
  //                         children: [
  //                           Checkbox(
  //                             checkColor: Colors.white,
  //                             value: isChecked,
  //                             onChanged: (bool? value) {
  //                               setState(() {
  //                                 isChecked = value!;
  //                               });
  //                             },
  //                           ),
  //                           Expanded(
  //                             child: Container(
  //                               alignment: AlignmentDirectional.centerStart,
  //                               child: RichText(
  //                                 text: TextSpan(
  //                                   text: AppLocalizations.of(context).translate('by_sigining'),
  //                                   style: const TextStyle(color: Colors.black, fontSize: 12),
  //                                   children: [
  //                                     TextSpan(
  //                                       text: AppLocalizations.of(context).translate('Privacy'),
  //                                       recognizer: TapGestureRecognizer()
  //                                         ..onTap = () {
  //                                           Navigator.push(
  //                                             context,
  //                                             MaterialPageRoute(
  //                                               builder: (context) => WebView_Login1('https://trackware.com/privacy-policy/'),
  //                                             ),
  //                                           );
  //                                         },
  //                                       style: const TextStyle(
  //                                         color: Color(0xff3c92d0),
  //                                         decoration: TextDecoration.underline,
  //                                       ),
  //                                     ),
  //                                     TextSpan(
  //                                       text: AppLocalizations.of(context).translate('and'),
  //                                       style: const TextStyle(
  //                                         color: Colors.black,
  //                                       ),
  //                                     ),
  //                                     TextSpan(
  //                                       text: AppLocalizations.of(context).translate('Terms'),
  //                                       recognizer: TapGestureRecognizer()
  //                                         ..onTap = () {
  //                                           Navigator.push(
  //                                             context,
  //                                             MaterialPageRoute(
  //                                               builder: (context) => WebView_Login1('https://trackware.com/privacy-policy/'),
  //                                             ),
  //                                           );
  //                                         },
  //                                       style: const TextStyle(
  //                                         color: Color(0xff3c92d0),
  //                                         decoration: TextDecoration.underline,
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 InkWell(
  //                   onTap: () async {
  //                     if (isChecked) {
  //                       showDialog(
  //                         context: context,
  //                         builder: (context) => const Center(child: CircularProgressIndicator()),
  //                       );
  //                       AppCubit.get(context).Login(
  //                         user_name.text,
  //                         pass.text,
  //                         data_base!.dbName.toString(),
  //                       );
  //                     }
  //                   },
  //                   child: Container(
  //                     margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.w),
  //                     padding: EdgeInsets.all(15),
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: isChecked ? Color(0xff3c92d0) : Color(0xffbbc7db).withOpacity(.51),
  //                     ),
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       AppLocalizations.of(context).translate('login_button'),
  //                       style: GoogleFonts.montserrat(
  //                         color: Colors.white,
  //                         fontSize: 18,
  //                         fontWeight: FontWeight.normal,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.symmetric(vertical: 20),
  //                   alignment: Alignment.center,
  //                   child: Image(
  //                     image: AssetImage(AppCubit.new_logo),
  //                     width: 50.w,
  //                     height: 10.w,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
