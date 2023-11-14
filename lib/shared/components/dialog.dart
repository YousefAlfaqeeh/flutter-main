
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';


import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/modelLibrary.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/modulesOdoo/absence.dart';
import 'package:udemy_flutter/modules/modulesOdoo/badges.dart';
import 'package:udemy_flutter/modules/modulesOdoo/libary.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_badges.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';






class dialog extends StatelessWidget {
  String massage;
  Widget title;

  dialog({required this.massage, required this.title});
  // static show(context,String massage,
//   Widget title)=>showDialog(context: context, builder: (_)=>dialog(title:title, massage: massage));
  void p(String m)
  {
    if(m==massage)
    {
      // print('jjjjjjjjj');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          height:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')? MediaQuery.of(context).size.height/8 :MediaQuery.of(context).size.height/12 ,
          width: MediaQuery.of(context).size.height/10,
          alignment: Alignment.topCenter,
          child:  title),
      content: Container(
        child: Text(massage),
      ),
      actions: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(40)),
            child: MaterialButton(
              child:  Text(
                AppLocalizations.of(context).translate('ok').toString(),
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                if (AppLocalizations.of(context).translate('pic')==massage ||massage.contains(AppLocalizations.of(context).translate('picup_distance'))){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => New_Detail()),
                );}else{Navigator.pop(context);}},
            ),
          ),
        )
      ],
    );
  }
}
class dialog_send_feed extends StatelessWidget {
  String massage;
  Widget title;

  dialog_send_feed({required this.massage, required this.title});
  void p(String m)
  {
    if(m==massage)
    {
      // print('jjjjjjjjj');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          height: 50,
          width: 50,
          alignment: Alignment.topCenter,
          child:  title),
      content: Container(
        padding: EdgeInsets.all(10),
        child: Text(massage,style: TextStyle(color: Colors.blue)),
      ),
      actions: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(40)),
            child: MaterialButton(
              child:  Text(
                AppLocalizations.of(context).translate('ok').toString(),
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                if (AppLocalizations.of(context).translate('pic')==massage ||massage.contains(AppLocalizations.of(context).translate('picup_distance'))){ Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => New_Detail()),
                );}else{Navigator.pop(context);}},
            ),
          ),
        )
      ],
    );
  }
}

class dialog_sure extends StatelessWidget {
  String massage;

  Future Function() functionOK;

  dialog_sure({required this.massage, required this.functionOK});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        child: Text(massage),
      ),
      actions: [
        Padding(
          padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8,vertical: 10),
          child: Container(

            width: double.infinity,
            // child: Expanded(
            child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                child: Container(
                  child: MaterialButton(
                    child:  Text(
                      AppLocalizations.of(context).translate('no'),
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(40)),
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(40)),
                  child: MaterialButton(
                    child:  Text(
                      AppLocalizations.of(context).translate('yes'),
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: functionOK,
                  ),
                ),
              )
            ]),
            // ),
          ),
        )
      ],
    );
  }
}

class dialogCall extends StatelessWidget {
  String school_name;
  String school_number;
  Future Function() functionCAll;

  dialogCall(
      {required this.school_name,
        required this.school_number,
        required this.functionCAll});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Container(
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
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
                  onPressed: functionCAll,
                ),
              ),
            ),
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
  }
}

class dialog_feedback extends StatefulWidget {
  Future Function() functionCancel;
  Future Function() functionOK;
  String? student_id;

  dialog_feedback(
      {required this.functionCancel,
        required this.functionOK,
        this.student_id});

  @override
  State<dialog_feedback> createState() => _dialog_feedbackState();
}

class _dialog_feedbackState extends State<dialog_feedback> {
  Color good = Colors.grey;
  Color bad = Colors.grey;
  Color ex = Colors.grey;
  TextEditingController feedback = TextEditingController();
  String? impression;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: Text('Feedback'),
      ),
      actions: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/10,vertical: 10),
                child: Container(

                  child: Row( children: [
                    Expanded(
                      child: Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                              border: Border.all(color: ex, width: 5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          //<-- SEE HERE
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              // print('ddddddddd');
                              setState(() {
                                good = Colors.grey;
                                bad = Colors.grey;
                                ex = Colors.green;
                                impression = 'Excellent';
                              });
                              // print(impression);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.sentiment_very_satisfied,
                                size: 40.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                              border: Border.all(color: good, width: 5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          //<-- SEE HERE
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              setState(() {
                                good = Colors.green;
                                bad = Colors.grey;
                                ex = Colors.grey;
                                impression = "Very Good";
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          decoration: BoxDecoration(
                              border: Border.all(color: bad, width: 5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50.0)),
                          //<-- SEE HERE
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100.0),
                            onTap: () {
                              setState(() {
                                good = Colors.grey;
                                bad = Colors.green;
                                ex = Colors.grey;
                                impression = "Good";
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                                size: 40.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                ),
              ),

              Container(
                height: 150,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),
                child: Center(
                  child: TextFormField(
                    controller: feedback,
                    maxLines: 60,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        hintText: "Enter  feedback",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(1))),
                    // controller: feedback,
                  ),
                ),
              ),

              Container(
                padding:EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/7,vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: MaterialButton(
                        child:  Text(
                          AppLocalizations.of(context).translate('cancel'),
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },

                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green),
                            borderRadius: BorderRadius.circular(40)),

                        child: MaterialButton(
                          child:  Text(
                            AppLocalizations.of(context).translate('ok'),
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () async {

                            var responseKids = await DioHelper.postData(
                                url: Feed_back,
                                data: {
                                  "student_id": widget.student_id,
                                  "impression": impression.toString(),
                                  "feed_back": feedback.text,
                                },
                                token: CacheHelper.getBoolean(
                                    key: 'authorization'))
                                .then(
                                  (value) {
                                Navigator.pop(context);
                                showDialog(context: context, builder: (context) => dialog_send_feed(massage: 'Your feedback was sent successfully', title: Text('')),);
                              },
                            )
                                .catchError((onError) {
                              // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
                            });
                          },
                        ),

                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        )
      ],
    );
  }
}

class dialog_absent extends StatefulWidget {
  String std_id;


  dialog_absent({required this.std_id});

  @override
  State<dialog_absent> createState() => _dialog_absentState();
}

class _dialog_absentState extends State<dialog_absent> {

  String? absent;
  late NavigatorState _navigator;


  @override
  void dispose() {

    // _navigator.pushAndRemoveUntil(, (route) => ...);
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
          height: 70,
          width: 70,
          alignment: Alignment.topCenter,
          child:
          // Expanded(
          //     child:
          Container(
            alignment: Alignment.center,
            child:
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('images/icon_ab.png'),
            ),

            // Text('will your chid be absent for:')

            // )
          )),

      // content:
      actions: [
        Container(
            alignment: Alignment.topCenter,
            child:  Text(AppLocalizations.of(context).translate('absentD'))),
        // Expanded(
        //   child:
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Row(

                children: [
                  Expanded(child: Text(AppLocalizations.of(context).translate('whole'))),
                  Expanded(child:   Radio(value: 'both', groupValue: absent, onChanged: (value) {
                    setState(() {
                      absent=value.toString();
                    });
                  },))

                ],


              ),
              Row(
                children: [
                  Expanded(child:  Text(AppLocalizations.of(context).translate('during'))),
                  Expanded(child:  Radio(value: 'pick', groupValue: absent, onChanged: (value) {
                    setState(() {
                      absent=value.toString();
                    });
                  },))

                ],


              ),
            ],
          ),
        ),
        // ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8,vertical: 10),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child:
            // Expanded(
            //   child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child:
                  Container(

                    decoration: BoxDecoration(

                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(40)),

                    child:
                    // Expanded(
                    //   child:
                    MaterialButton(
                      child:  Text(  AppLocalizations.of(context).translate('ok'),


                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () async {



                        if(absent.toString()!='null'){

                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          if (newDate == null) return;
                          var isChecked =newDate.day.toString()+'/'+newDate.month.toString()+'/'+newDate.year.toString();
                          var response=await  DioHelper.postData(url:Perent_Notification , data:{
                            'name':'childs_attendance',
                            'absent':'true',
                            'long':0.0,
                            'lat':0.0,
                            'target_rounds':absent,

                            'student_id':widget.std_id.toString(),
                            'when':newDate.day.toString()+'/'+newDate.month.toString()+'/'+newDate.year.toString() ,


                          },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {
                            Navigator.pop(context);
                            // showDialog(context: context, builder: (context) => AlertDialog(actions: [Text('data')]),);
                            showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('absent_sent'), title:Text('') ),);

                          },).catchError((onError){
                            // print(onError);

                            // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);

                          });
                          // showDialog(context: context, builder: (context) => dialog(massage:  AppLocalizations.of(context).translate('absent_sent111'), title:Text('') ),);

                          // if(isChecked!=CacheHelper.getBoolean(key: 'isChecked'))
                          //   {
                          //     showDialog(context: context, builder: (context) => dialog(massage: 'please', title: Image(image: AssetImage('images/img_error.png')) ),);
                          //
                          //   }
                          // else
                          //   {CacheHelper.saveData(key: 'isChecked', value: isChecked);
                          //     print(newDate);
                          //
                          //   var response=await  DioHelper.postData(url:Perent_Notification , data:{
                          //     'name':'childs_attendance',
                          //     'absent':'true',
                          //     'long':'',
                          //     'lat':'',
                          //     'target_rounds':absent,
                          //     'student_id':widget.std_id.toString(),
                          //     'when':newDate,
                          //
                          //
                          //   },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {
                          //
                          //     // print(student!.students.runtimeType);
                          //
                          //
                          //   },).catchError((onError){
                          //     // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);
                          //
                          //   });
                          //
                          //   }





                        }
                        else
                        {
                          showDialog(context: context, builder: (context) => dialog(massage: 'please select absent type', title: Image(image: AssetImage('images/img_error.png')) ),);

                        }
                      },
                    ),
                    // ),



                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(40)),
                    child:
                    // Expanded(
                    //   child:
                    MaterialButton(
                      child:  Text(
                        AppLocalizations.of(context).translate('cancel'),

                        style: TextStyle(color: Colors.blue,fontSize: 12.5),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    // ),

                  ),
                ),

              ],
            ),
            // ),
          ),
        ),

      ],
    );
    ;
  }
}


class dialog_confirmed_pick extends StatelessWidget {
  String massage;
  Widget title;
  String student_id;
  dialog_confirmed_pick({required this.student_id,required this.title,required this.massage});
  Future<void> confirmed_pick()
  async {


    var response=await DioHelper.postData(url:Perent_Notification , data:{
      'name':'confirmed_pick',
      'long':'',
      'lat':'',
      'mobile':'',
      'student_id':student_id.toString(),


    },token: CacheHelper.getBoolean(key: 'authorization') ).then((value) {





    },).catchError((onError){
      // print(onError);
      // showDialog(context: context, builder: (context) => dialog(massage: 'ddddddddddd', title: Image(image: AssetImage('images/img_error.png')) ),);

    });

  }
  @override
  Widget build(BuildContext context) {
    return   AlertDialog(
      title: Container(
          height: 50,
          width: 50,
          alignment: Alignment.topCenter,
          child:  title),
      content: Container(
        child: Text(massage),
      ),
      actions: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(40)),
            child: MaterialButton(
              child:  Text(
                AppLocalizations.of(context).translate('ok').toString(),
                style: TextStyle(color: Colors.green),
              ),
              onPressed: (){
                CacheHelper.saveData(key: 'pickup', value:'');
                CacheHelper.saveData(key: 'pickup'+student_id, value: '');
                Navigator.pop(context);

                confirmed_pick();
              },
            ),
          ),
        )
      ],
    );
  }
}


class  Dialog_badges extends StatefulWidget {

  String image,name,date,description;
  Dialog_badges({required this.image,required this.name,required this.date,required this.description});

  @override
  State<Dialog_badges> createState() => _Dialog_badgesState();
}

class _Dialog_badgesState extends State<Dialog_badges> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      margin: EdgeInsets.only(top: 30,),
      color: Colors.white,
      alignment: Alignment.center,

      child: Column(children: [
        Row(children: [
          Expanded(
            child: Container(alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,top: 10),
              padding: EdgeInsets.all(8),child:  DefaultTextStyle(style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 24,color: Color(0xff3c92d0)) ,
                  child: Text(AppLocalizations.of(context).translate('Badges'))),),
          ),

          Container(alignment: Alignment.centerRight,
            margin: EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(8),
            child:InkWell(onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => New_Badges( std_id: AppCubit.std,std_name:  AppCubit.name,),
                  ));
            },
                child:SvgPicture.asset("images/times_solid.svg")),


          ),
        ],),
        widget.image.toString().isNotEmpty? Container(alignment: Alignment.centerLeft
            ,  margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(height: 300,image:NetworkImage(widget.image)))):Visibility(
          visible: false,
          child: Container(
          ),
        ),
        Container(alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 30),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: DefaultTextStyle(
              child: Text(widget.date.toString(),),
              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Color(0xff3c92d0))),
        ),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: DefaultTextStyle( style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black),
              child: Text(widget.name.toString(),
              ),
            )),
        Expanded(
          child: SingleChildScrollView(
            child: Container(alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30),
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: DefaultTextStyle(
                  child: Text(widget.description.toString(),),
                  style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black)),
            ),
          ),
        ),



      ]),
    ),);
  }
}
class DialogTypeRequest extends StatefulWidget {
  String stu_name;
  DialogTypeRequest({required this.stu_name});

  @override
  State<DialogTypeRequest> createState() => _DialogTypeRequestState();
}

class _DialogTypeRequestState extends State<DialogTypeRequest> {
  List<dynamic> school_Request = ['Absence','Leave'];
  DateTime _dateTime = DateTime.now();
  String type=CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'إختيار النوع':'Select Type';
  String typeReason='Select Reason';
  bool isAbsence=false;
  bool isLeave=false;
  late DateTime fromDate;
  late DateTime fromTo;
  String textFrom = 'Select date';
  String textTo = 'Select date';
  List file1=[];
  TextEditingController note = TextEditingController();
  late Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:    AppBar(
      toolbarHeight: 75,
      backgroundColor:Colors.white,
      leadingWidth: double.infinity/4,
      leading: Padding(
        padding:EdgeInsets.only(left: 20,top: 20,bottom: 10,right: 0),
        // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: Container(
          margin: EdgeInsets.only(right: 20),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(

                child: Text(

              AppLocalizations.of(context).translate('absent_request'),style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),

              ),

            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 5),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(

                      width: 13.58,
                      height: 22.37,


                      child: SvgPicture.asset("images/times_solid.svg",color:Color(0xff98aac9),))),
            ],
          ),
        ),
      ],








    ),
      body:   Container(

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            SizedBox(height: 20,),
            Container(
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(
                AppLocalizations.of(context).translate('Request_for'),style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
            ),

            SizedBox(height: 20,),
            Container(
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(
                widget.stu_name,style: TextStyle(fontSize: 14,fontFamily: 'Nunito',fontWeight: FontWeight.normal,color: Colors.black),),
            ),
            // ),
            SizedBox(height: 20,),
            Container(
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(
                AppLocalizations.of(context).translate('Type'),style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
            ),

            SizedBox(height: 20,),
            Container(

              width: double.infinity,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20,right: 20),
              decoration: BoxDecoration(border: Border.all(color: Color(0xff00001f).withOpacity(.2)),borderRadius: BorderRadius.all(Radius.circular(5))),
              // padding: EdgeInsets.only(left: 10),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    style: Theme.of(context).textTheme.titleMedium,
                    // icon: Icon(Icons.arrow),

                    hint: Text( AppLocalizations.of(context).translate('Select_Type')),
                    items: <String>[ CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?'إختيار النوع':'Select Type',AppLocalizations.of(context).translate('absence_di')
                     ,AppLocalizations.of(context).translate('Late')].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (va) {
                      setState(() {
                        type=va.toString();
                        if(type==AppLocalizations.of(context).translate('Late'))
                        {
                          isAbsence=false;
                          isLeave=true;
                        }
                        else if(type==AppLocalizations.of(context).translate('absence_di'))
                        { isLeave=false;
                        isAbsence=true;
                        }
                        else
                        {
                          isLeave=false;
                          isAbsence=false;
                        }
                      });
                      // print(va);
                    },
                    value: type,
                  ),
                ),
              ),
            ),

            Visibility(visible:  isAbsence||isLeave,
                child: SizedBox(height: 20,)),
            Visibility(
              visible:  isAbsence||isLeave,
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(AppLocalizations.of(context).translate('Date_From')
                  ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
              ),
            ),
            Visibility(visible:  isAbsence||isLeave,child: SizedBox(height: 10,)),
            //d
            Visibility(
              visible: isAbsence||isLeave,
              child: InkWell(
                onTap: () async {

                  CupertinoRoundedDatePicker.show(

                    locale: Locale("ar", ""),
                    context,borderRadius: 16,initialDatePickerMode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (p0) {
                      setState(() {
                        fromTo = p0;
                        textTo = p0.year.toString() +
                            '-' +
                            p0.month.toString() +
                            '-' +
                            p0.day.toString();
                      });
                    },


                  );
                  // DateTime? newDate = await showDatePicker(
                  //     context: context,
                  //     initialDate: DateTime.now(),
                  //     firstDate: DateTime(2016),
                  //     lastDate: DateTime(2100));
                  // if (newDate == null) return;
                  // setState(() {
                  //   fromTo = newDate;
                  //   textTo = newDate.year.toString() +
                  //       '-' +
                  //       newDate.month.toString() +
                  //       '-' +
                  //       newDate.day.toString();
                  // });
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(border: Border.all(color: Color(0xff00001f).withOpacity(.2)),borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: EdgeInsets.only(left: 15),

                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(

                          child: Container(
                              margin: EdgeInsets.only(left: 10,right: 10),child: Text(textTo))),
                      Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                        alignment: Alignment.centerRight,
                          child:SvgPicture.asset("images/calendar_11.svg",color:  Color(0xff98aac9),width:20 ,))
                    ],
                  ),
                ),

              ),
            ),
            
            Visibility(
                visible:  isAbsence||isLeave,
                child: SizedBox(height: 15,)),
            
            Visibility(
              visible:  isLeave,
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(AppLocalizations.of(context).translate('Arrival_Time')
                 ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
              ),
            ),
            Visibility(
                visible:  isLeave,
                child: SizedBox(height: 5,)),
            Visibility(visible: isLeave, child:TimePickerSpinner(
              is24HourMode: false,
              normalTextStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.grey
              ),
              highlightedTextStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.black
              ),
              spacing: 50,
              itemHeight: 80,
              isForce2Digits: true,
              onTimeChange: (time) {
                setState(() {
                  _dateTime = time;
                });
              },
            )
            ),
            //d
            Visibility(
              visible: isAbsence,
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(AppLocalizations.of(context).translate('To')
                 ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
              ),
            ),
            //d
            Visibility(visible:  isAbsence,child: SizedBox(height: 5,)),
            Visibility(
              visible: isAbsence,
              child:  InkWell(

                onTap: () {
                  CupertinoRoundedDatePicker.show(context,borderRadius: 16,initialDatePickerMode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (p0) {

                      setState(() {
                        fromDate = p0;
                        textFrom = p0.year.toString() +
                            '-' +
                            p0.month.toString() +
                            '-' +
                            p0.day.toString();
                      });
                    },


                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration(border: Border.all(color: Color(0xff00001f).withOpacity(.2)),borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: EdgeInsets.only(left: 15),

                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(child: Container(margin: EdgeInsets.only(left: 10,right: 10),child: Text(textFrom))),
                      Container(
                          margin: EdgeInsets.only(left: 10,right: 10),
                          alignment: Alignment.centerRight,
                          child:SvgPicture.asset("images/calendar_11.svg",color:  Color(0xff98aac9),width:20 ,))
                    ],
                  ),
                ),
              ),
            ),
            Visibility(visible:  isAbsence||isLeave,
                child: SizedBox(height: 10,)),
            Visibility(
              visible:  isAbsence||isLeave,
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(AppLocalizations.of(context).translate('Reason')
               ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
              ),
            ),

            Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 5,)),
            Visibility(
              visible:  isAbsence||isLeave,
              child:  Container(

                width: double.infinity,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20,right: 20),
                decoration: BoxDecoration(border: Border.all(color:  Color(0xff00001f).withOpacity(.2)),borderRadius: BorderRadius.all(Radius.circular(5))),
                // padding: EdgeInsets.only(left: 10),
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      style: Theme.of(context).textTheme.titleMedium,

                      hint: Text(AppLocalizations.of(context).translate('Select_Reason')),
                      items: <String>['Select Reason','Sick','Accidental','Death of relative',"Other"].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (va) {
                        setState(() {
                          typeReason=va.toString();

                        });

                      },
                      value: typeReason,
                    ),
                  ),
                ),
              ),
            ),



            Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 10,)),
            Visibility(
              visible:  isAbsence||isLeave,
              child: Container(
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20,right: 20),
                child: Text(AppLocalizations.of(context).translate('Note')
                  ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
              ),
            ),
            Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 5,)),
            Visibility(
              visible:  isAbsence||isLeave,
              child: Container(
                  height: 100,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: TextFormField(
                      maxLines: 20,
                      decoration: InputDecoration(
                          // hintText:'Note here',
                          filled: true,
                          //<-- SEE HERE
                          fillColor: Colors.white,

                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey),
                              borderRadius:
                              BorderRadius.circular(8)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white),
                              borderRadius:
                              BorderRadius.circular(8))),
                      controller: note)),
            ),
            Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 10,)),
            // Visibility(
            //   visible:  isAbsence||isLeave,
            //   child: Container(
            //     alignment: Alignment.centerLeft,
            //     padding: EdgeInsets.only(left: 20),
            //     child: Text(
            //       'Attachment',style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
            //   ),
            // ),

            Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 5,)),
         Visibility( visible:  isAbsence||isLeave,
           child: ListView.builder(


                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 20,right: 20,bottom: 10),
                    itemCount:file1.length,
                    itemBuilder: (context, index) {
                      return InkWell(

                        //Display car block

                        child:  Container(

                          decoration: BoxDecoration(borderRadius:  BorderRadius.circular(3),
                              border:Border.all(color:Color(0xffbbc7db) )),

                          child: Row(
                            children: [
                              Container(

                                  padding: EdgeInsets.all(15),
                                  child: Image(image:AssetImage("images/pdf123.png")),
                                  // SvgPicture.asset("images/pdf.svg")
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(file1[index]['name'],style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),

                                    Container(
                                        alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(  file1[index]['size'].toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color:Color(0xff8e8c8c)))),
                                  ],
                                ),
                              ),
                              Container(

                                  padding: EdgeInsets.all(15),
                                  child: IconButton(onPressed: () {

                                    setState(() {
                                      file1=[];
                                    //   print(flg);
                                    //   if(file.length>0)
                                    //   {
                                    //     file.removeAt(index);
                                    //
                                    //     if(file.length>0) {
                                    //
                                    //       flg = true;
                                    //     }
                                    //     else{
                                    //
                                    //       flg = false;
                                    //     }
                                    //   }
                                    //   else{
                                    //
                                    //     flg = false;
                                    //   }
                                    //
                                    //
                                    });

                                  }, icon:  SvgPicture.asset("images/icons8_download_from_cloud.svg",color:  Color(0xffbbc7db)))),

                            ],
                          ),
                        ),         );
                    }),
         ),

            Visibility(
              visible: isAbsence||isLeave,
              child: InkWell(
                onTap: () async {

                },

                child: Container(


                  // margin: EdgeInsets.only(left: 20,right: 10),
                  padding: EdgeInsets.only(left: 20,right: 20),
                  height: 60,
                  child: DottedBorder(
                    radius: Radius.circular(10),
                    color: Colors.grey,
                    strokeWidth: 1,
                    dashPattern: [10,2],
                    child: InkWell(
                      onTap:
                          () async {
                        var status = await Permission.storage.request();

                        if (status.isGranted) {
                          final result = await FilePicker.platform.pickFiles();
                          if (result == null) return;
                          final file = result.files.first;
                          final path = file.path;
                          // print(result.files.first.name);
                          // print(await MultipartFile.fromFile(path.toString(),filename: file.name));

                          // FormData.fromMap({
                          //   "file":await MultipartFile.fromFile(),
                          // });
                          file1.clear();
                          file1.add({
                            "name":result.files.first.name,
                            "size":result.files.first.size
                          });
                          bytes = File(path!).readAsBytesSync();

                          // var responseSettings=await Dio().post(MAIN_URL+Post_Absence , data:data ).then((value) {
                          //   print('ssssssssssss');
                          //
                          //   // emit(AppSettingState());
                          //
                          //
                          // },).catchError((onError){
                          //   print(onError);
                          //
                          // });

                        }

                      },
                      child: Container(
                        width: double.infinity,
                        // margin: EdgeInsets.only(top: 20),
                        color: Color(0xfff5f7fb) ,
                        alignment: Alignment.center,

                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("images/group8555.svg",color:  Color(0xff98aac9),),
                              // Icon(Icons.cloud_upload,color:  Color(0xff98aac9)),
                              SizedBox(width: 10,),
                              Text(AppLocalizations.of(context).translate('Upload_File') ,style: TextStyle(color: Color(0xff98aac9))),
                            ]
                        ),
                      ),
                    ),
                  ),
                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 2, horizontal: 20),

              decoration: BoxDecoration(
                border: Border.all(color:Color(0xff3c92d0),width: 2 ),
                  color: Color(0xff3c92d0),
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              height: 55,
              // color: Colors.orange,
              child: MaterialButton(
                child: Text(AppLocalizations.of(context).translate('Submit'),style: TextStyle(color: Colors.white),),
                onPressed: () async {

                  Map data={};
                  String type1= type.toLowerCase();
                  if( type.toLowerCase().contains('death'))
                  {
                    type1='death';
                  }
                  if(isLeave||isAbsence) {

                    data['session'] =
                        CacheHelper.getBoolean(key: 'sessionId');

                    try{

if(file1.length>0) {
  data['file'] = base64Encode(bytes);
}
else
  {
    data['file']='';
  }
                    }
                    catch(e){
                      data['file']='';
                    }
                    data['student_id'] = AppCubit.std;
                    data['notes'] = note.text.toString();
                    data['type'] = type1;
                    data['Reason'] = typeReason.toLowerCase();
                    data['start_date'] = textTo.toString();
                    data['end_date'] = textFrom.toString();
                    data['base_url']=CacheHelper.getBoolean(key: 'base_url');

                    if (type == 'Late') {
                      data['arrival_time'] =
                          _dateTime.hour + _dateTime.minute / 60.0;
                    }
                    else {
                      data['arrival_time'] = '';
                    }
                    data['departure_time'] = [];
                    var responseSettings = await DioHelper.uplodeData(
                        url: Post_Absence,
                        data: data,
                        token: CacheHelper.getBoolean(key: 'authorization'))
                        .then((value) {
                          // print(value.data);
                      if (type != 'Late') {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => DialogTypeApsence(image_name: "images/unnamed.png",
                                tit: "Absence",
                                message: "YOUR ABSENCE REQUEST",messageSubm:'SUBMITTED' ,messageSucc: "SUCCESSFULLY",std_name: widget.stu_name));
                      }
                      else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,

                            builder: (_) =>
                                DialogTypeApsence(image_name: "images/unnamed.png",
                                    tit: "Late",
                                    message: "YOUR LATE REQUEST ",messageSubm:'SUBMITTED' ,messageSucc: "SUCCESSFULLY",std_name: widget.stu_name));
                      }
                    },).catchError((onError) {
                      // print("doodododo"+onError.toString());
                    });
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return const Center(
                    //       child: const CircularProgressIndicator(),
                    //     );
                    //   },
                    // );
                  }
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  vertical: 2, horizontal: 20),
height: 55,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff3c92d0),width: 2.5),
                  borderRadius: BorderRadius.circular(10)),
              width: double.infinity,
              // color: Colors.orange,
              child: MaterialButton(
                child: Text(AppLocalizations.of(context).translate('cancel'),style: TextStyle(color: Color(0xff3c92d0)),),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std,std_name: widget.stu_name,)));
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return const Center(
                  //       child: const CircularProgressIndicator(),
                  //     );
                  //   },
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    ),);
//       AlertDialog(
//
//     actions: [
//       Container(
//         height: 300,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Container(
//                 width: double.infinity,
//                 color: Color(0xff3c92d0),
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//
//                     Expanded(
//                       child: Container(
//                           padding: EdgeInsets.only(left: 20),
//                           child: Text(
//                             'Request',style: TextStyle(fontSize: 24,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.white),),
//                         ),
//                     ),
//
//                     IconButton(
//           onPressed: () {
//           Navigator.pop(context);
//           },
//           icon: Container(
//
//           width: 13.58,
//           height: 22.37,
//
//
//           child: SvgPicture.asset("images/times_solid.svg",color: Colors.white,))),
//
//
//                   ],
//                 ),
//
//               ),
//               SizedBox(height: 20,),
//              Container(
//                alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Request for',style: TextStyle(fontSize: 18,fontFamily: 'Nunito',fontWeight: FontWeight.normal,color: Colors.black),),
//                 ),
//
//               SizedBox(height: 20,),
//            Container(
//              alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     widget.stu_name,style: TextStyle(fontSize: 18,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Color(0xff3c92d0)),),
//                 ),
//               // ),
//               SizedBox(height: 20,),
//           Container(
//             alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Type',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//                 ),
//
//               SizedBox(height: 20,),
//              Container(
//
//                   width: double.infinity,
//                   alignment: Alignment.centerLeft,
//                   margin: EdgeInsets.only(left: 20,right: 10),
//                   decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(8))),
//                   padding: EdgeInsets.only(left: 10),
//                   child: DropdownButtonHideUnderline(
//                     child: ButtonTheme(
//                       alignedDropdown: true,
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         style: Theme.of(context).textTheme.titleMedium,
//
//                       hint: Text('Select Type'),
//                         items: <String>['Select Type','Absence','Late'].map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (va) {
// setState(() {
//   type=va.toString();
//   if(type=='Late')
//     {
//           isAbsence=false;
//           isLeave=true;
//     }
//   else if(type=='Absence')
//     { isLeave=false;
//           isAbsence=true;
//     }
//   else
//     {
//           isLeave=false;
//           isAbsence=false;
//     }
// });
//                         print(va);
//                         },
//                         value: type,
//                       ),
//                     ),
//                   ),
//                 ),
//
//               Visibility(visible:  isAbsence||isLeave,
//                   child: SizedBox(height: 20,)),
//               Visibility(
//                 visible:  isAbsence||isLeave,
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'From',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//                 ),
//               ),
//               Visibility(visible:  isAbsence||isLeave,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible: isAbsence||isLeave,
//                 child: InkWell(
//                     onTap: () async {
//                       DateTime? newDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2016),
//                           lastDate: DateTime(2100));
//                       if (newDate == null) return;
//                       setState(() {
//                         fromTo = newDate;
//                         textTo = newDate.year.toString() +
//                             '-' +
//                            newDate.month.toString() +
//                             '-' +
//                             newDate.day.toString();
//                       });
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 50,
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.only(left: 20,right: 10),
//                       decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(8))),
//                       padding: EdgeInsets.only(left: 10),
//
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: Text(textTo),
//                     ),
//
//                 ),
//               ),
//               Visibility(
//                   visible:  isAbsence||isLeave,
//                   child: SizedBox(height: 20,)),
//               // Visibility(
//               //   visible:  isLeave,
//               //   child: Container(
//               //     alignment: Alignment.centerLeft,
//               //     padding: EdgeInsets.only(left: 20),
//               //     child: Text(
//               //       'Arrival Time',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//               //   ),
//               // ),
//               Visibility(visible: isLeave, child:TimePickerSpinner(
//                 is24HourMode: false,
//                 normalTextStyle: TextStyle(
//                     fontSize: 24,
//                     color: Colors.grey
//                 ),
//                 highlightedTextStyle: TextStyle(
//                     fontSize: 24,
//                     color: Colors.black
//                 ),
//                 spacing: 50,
//                 itemHeight: 80,
//                 isForce2Digits: true,
//                 onTimeChange: (time) {
//                   setState(() {
//                     _dateTime = time;
//                   });
//                 },
//               )
//               ),
//               Visibility(
//                 visible: isAbsence,
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'To',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//                 ),
//               ),
//               Visibility(visible:  isAbsence,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible: isAbsence,
//                 child:  InkWell(
//                     onTap: () async {
//                       DateTime? newDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2016),
//                           lastDate: DateTime(2100));
//                       if (newDate == null) return;
//                       setState(() {
//                         fromDate = newDate;
//                         textFrom = newDate.year.toString() +
//                             '-' +
//                             newDate.month.toString() +
//                             '-' +
//                             newDate.day.toString();
//                       });
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       height: 50,
//                       alignment: Alignment.centerLeft,
//                       margin: EdgeInsets.only(left: 20,right: 10),
//                       decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(8))),
//                       padding: EdgeInsets.only(left: 10),
//
//                       clipBehavior: Clip.antiAliasWithSaveLayer,
//                       child: Text(textFrom),
//                     ),
//                   ),
//                 ),
//               Visibility(visible:  isAbsence||isLeave,
//                   child: SizedBox(height: 20,)),
//               Visibility(
//                 visible:  isAbsence||isLeave,
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Reason',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//                 ),
//               ),
//
//               Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible:  isAbsence||isLeave,
//                 child:  Container(
//
//                   width: double.infinity,
//                   alignment: Alignment.centerLeft,
//                   margin: EdgeInsets.only(left: 20,right: 10),
//                   decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(8))),
//                   padding: EdgeInsets.only(left: 10),
//                   child: DropdownButtonHideUnderline(
//                     child: ButtonTheme(
//                       alignedDropdown: true,
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         style: Theme.of(context).textTheme.titleMedium,
//
//                         hint: Text('Select Reason'),
//                         items: <String>['Select Reason','Sick','Accidental','Death of relative',"Other"].map((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                         onChanged: (va) {
//                           setState(() {
//                             typeReason=va.toString();
//
//                           });
//
//                         },
//                         value: typeReason,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//
//
//               Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible:  isAbsence||isLeave,
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Note',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//                 ),
//               ),
//               Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible:  isAbsence||isLeave,
//                 child: Container(
//                   height: 100,
//                     alignment: Alignment.centerLeft,
//                     padding: EdgeInsets.only(left: 20),
//                     child: TextFormField(
//                         maxLines: 20,
//                         decoration: InputDecoration(
//                             hintText:'Note here',
//                             filled: true,
//                             //<-- SEE HERE
//                             fillColor: Colors.white,
//
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                     color: Colors.grey),
//                                 borderRadius:
//                                 BorderRadius.circular(8)),
//                             border: OutlineInputBorder(
//                                 borderSide: const BorderSide(
//                                     color: Colors.white),
//                                 borderRadius:
//                                 BorderRadius.circular(8))),
//                         controller: note)),
//               ),
//               Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible:  isAbsence||isLeave,
//                 child: Container(
//                   alignment: Alignment.centerLeft,
//                   padding: EdgeInsets.only(left: 20),
//                   child: Text(
//                     'Attachment',style: TextStyle(fontSize: 20,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
//                 ),
//               ),
//               Visibility( visible:  isAbsence||isLeave,child: SizedBox(height: 20,)),
//               Visibility(
//                 visible: isAbsence||isLeave,
//                 child: InkWell(
//                   onTap: () async {
//
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(left: 20,right: 10),
//                     padding: EdgeInsets.only(left: 10),
//                     height: 50,
//                     child: DottedBorder(
//                       color: Colors.grey,
//                       strokeWidth: 3,
//                       dashPattern: [10,6],
//                       child: InkWell(
//                         onTap:
//                         () async {
//     var status = await Permission.storage.request();
//
//     if (status.isGranted) {
//       final result = await FilePicker.platform.pickFiles();
//       if (result == null) return;
//       final file = result.files.first;
//       final path = file.path;
//       // print(await MultipartFile.fromFile(path.toString(),filename: file.name));
//
//       // FormData.fromMap({
//       //   "file":await MultipartFile.fromFile(),
//       // });
//       bytes = File(path!).readAsBytesSync();
//
//       // var responseSettings=await Dio().post(MAIN_URL+Post_Absence , data:data ).then((value) {
//       //   print('ssssssssssss');
//       //
//       //   // emit(AppSettingState());
//       //
//       //
//       // },).catchError((onError){
//       //   print(onError);
//       //
//       // });
//
//     }
//
//                         },
//                         child: Container(
//                           width: double.infinity,
//
//                           alignment: Alignment.centerLeft,
//
//                           // decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.all(Radius.circular(8))),
//                           // padding: EdgeInsets.only(left: 10),
//
//                           // clipBehavior: Clip.antiAliasWithSaveLayer,
//                           child: Text('Drag & drop files here'),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                 ),
//               ),
//               SizedBox(height: 20,),
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                     vertical: 10, horizontal: 16),
//
//                 decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(20)),
//                 width: double.infinity,
//                 // color: Colors.orange,
//                 child: MaterialButton(
//                   child: Text('SUBMIT',style: TextStyle(color: Colors.white),),
//                   onPressed: () async {
//
//                     Map data={};
//                     String type1= type.toLowerCase();
//                     if( type.toLowerCase().contains('death'))
//                       {
//                         type1='death';
//                       }
//                     if(isLeave||isAbsence) {
//
//                       data['session'] =
//                           CacheHelper.getBoolean(key: 'sessionId');
//
//                       try{
//
//
//                       data['file'] = base64Encode(bytes);}
//                       catch(e){
//                         data['file']='';
//                       }
//                       data['student_id'] = AppCubit.std;
//                       data['notes'] = note.text.toString();
//                       data['type'] = type1;
//                       data['Reason'] = typeReason.toLowerCase();
//                       data['start_date'] = textTo.toString();
//                       data['end_date'] = textFrom.toString();
//                       data['base_url']=CacheHelper.getBoolean(key: 'base_url');
//                       if (type == 'Late') {
//                         data['arrival_time'] =
//                             _dateTime.hour + _dateTime.minute / 60.0;
//                       }
//                       else {
//                         data['arrival_time'] = '';
//                       }
//                       data['departure_time'] = [];
//                       var responseSettings = await DioHelper.uplodeData(
//                           url: Post_Absence,
//                           data: data,
//                           token: CacheHelper.getBoolean(key: 'authorization'))
//                           .then((value) {
//                         if (type != 'Late') {
//                           showDialog(
//                               context: context,
//                               barrierDismissible: false,
//                               builder: (_) => DialogTypeApsence(image_name: "images/absent.png",
//                                   tit: "Absence",
//                                   message: "YOUR ABSENCE REQUEST",messageSubm:'SUBMITTED' ,messageSucc: "SUCCESSFULLY",std_name: widget.stu_name));
//                         }
//                         else {
//                           showDialog(
//                               context: context,
//                               barrierDismissible: false,
//
//                               builder: (_) =>
//                                   DialogTypeApsence(image_name: "images/school_Monochromatic.png",
//                                       tit: "Late",
//                                       message: "YOUR LATE REQUEST ",messageSubm:'SUBMITTED' ,messageSucc: "SUCCESSFULLY",std_name: widget.stu_name));
//                         }
//                       },).catchError((onError) {
//
//                       });
//                       // showDialog(
//                       //   context: context,
//                       //   builder: (context) {
//                       //     return const Center(
//                       //       child: const CircularProgressIndicator(),
//                       //     );
//                       //   },
//                       // );
//                     }
//                   },
//                 ),
//               ),
//
//               Container(
//                 margin: const EdgeInsets.symmetric(
//                     vertical: 10, horizontal: 16),
//
//                 decoration: BoxDecoration(
//                     color: Colors.grey,
//                     borderRadius: BorderRadius.circular(20)),
//                 width: double.infinity,
//                 // color: Colors.orange,
//                 child: MaterialButton(
//                   child: Text('CANCEL',style: TextStyle(color: Colors.black),),
//                   onPressed: () async {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std,std_name: widget.stu_name,)));
//                     // showDialog(
//                     //   context: context,
//                     //   builder: (context) {
//                     //     return const Center(
//                     //       child: const CircularProgressIndicator(),
//                     //     );
//                     //   },
//                     // );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//
//
//     ],
//
//     );
  }
}


class DialogTypeApsence extends StatefulWidget {
  String image_name,tit,message,messageSucc,messageSubm,std_name;
  DialogTypeApsence({required this.image_name,required this.tit,required this.message,required this.messageSubm,required this.messageSucc,required this.std_name});

  @override
  State<DialogTypeApsence> createState() => _DialogTypeApsenceState();
}

class _DialogTypeApsenceState extends State<DialogTypeApsence> {
  String type='Absence';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,

              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std,std_name: widget.std_name)));

                      },
                      icon: Container(

                          width: 13.58,
                          height: 22.37,


                          child: Icon(Icons.dangerous,color: Colors.grey,))),
                ],
              ),

            ),
            SizedBox(height: 10,),
            Container(child:Image(image: AssetImage(widget.image_name)) ),
            Container(alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              width: double.infinity,
              child:  Text(AppLocalizations.of(context).translate('successfully_sent'),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color:Color(0xff3c92d0) ),),),
            SizedBox(height: 2,),
            Container(alignment: Alignment.center, padding: EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
              child: Text(AppLocalizations.of(context).translate('has_successfully'),style: TextStyle(fontSize: 15,fontWeight: FontWeight.
                normal,color:Color(0xff707070) ),
              ),),
            SizedBox(height: 10,),

          ],)


      ],

    );
  }
}


class new_badges_dialogs extends StatelessWidget {
  String image;
  String name;

  new_badges_dialogs({required this.name, required this.image});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
         
          width: MediaQuery.of(context).size.height/10,
          alignment: Alignment.center,
          child: Text( AppLocalizations.of(context)
              .translate(
              'Congratulation'),style: TextStyle(color: Color(0xfff9a200),fontWeight: FontWeight.bold,fontSize:28 ),) ),
      actions: [Container(
        child: Column(
          children: [
            Container(
                child: InkWell(
                  child: Container(
                    width: double.infinity,



                    child: Stack(
                      alignment:
                      CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                          ? Alignment.center
                          : Alignment.center,
                      fit: StackFit.passthrough,
                      children: [

                       Container(
                              height: MediaQuery.of(context).size.height / 4,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),


                              ),
                         child: Image(image: AssetImage('images/badge_da.png')),
                     ),
                       

                        Stack(
                          children: [


                            //  images/bus_genr.png
                            // Padding(
                            //   padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/13),
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //       height: MediaQuery.of(context).size.height/4,
                            //
                            //
                            //       child: Image(
                            //         image: AssetImage("images/casual_life_3d_reward_badge_with_star_and_ribbon.png"),
                            //
                            //         // height: MediaQuery.of(context).size.height/5,
                            //       )),
                            // ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height/55,


                              ),
                              child: Container(
                                  height: 85,
                                  alignment: Alignment.center,

                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                      radius: 10,
                                      backgroundImage: NetworkImage("${AppCubit.image}"))),
                              //  images/bus_genr.png
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            SizedBox(height: 20,),
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(AppLocalizations.of(context)
                    .translate(
                    'New_Badge_Earn'),style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10,),
                    Text("For "+name, style: TextStyle(fontSize: 17,color: Colors.black,fontWeight: FontWeight.normal
                    )),
                  ],
                )),
          ],
        ),
      ),],

    );
  }
}


class send_pickup extends StatelessWidget {
   send_pickup();

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: Container(

          width: MediaQuery.of(context).size.height/10,
          alignment: Alignment.topRight,
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.dangerous,color:Color(0xff98aac9) ,))),
      actions: [Container(
        child: SingleChildScrollView(
          
          child: Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height/10,

                  child:SvgPicture.asset("images/back_to_school_pana.svg",)
                  // Lottie.asset('assets/lang/high.json'),
              ),
              SizedBox(height: 20,),
              Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppLocalizations.of(context).translate('successfully_sent'),style: TextStyle(fontSize: 22,color:Color(0xff7cb13b),fontWeight: FontWeight.bold)),
                      SizedBox(height: 10,),
                      Text(AppLocalizations.of(context).translate('The_pickup_request_has_successfully'),textAlign: TextAlign.center, style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.normal )),

                          // Text(AppLocalizations.of(context).translate('sent'), style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal )),


                      SizedBox(height: 10,),
                    ],
                  )),
            ],
          ),
        ),
      ),],

    );
  }
}


class send_abs extends StatelessWidget {
  send_abs();

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(


shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Container(

          width: MediaQuery.of(context).size.height/10,
          alignment: Alignment.topRight,
          child: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.dangerous,color:Color(0xff98aac9) ,))),
      content: Container(
        height: 35.h ,
        child: SingleChildScrollView(

          child: Column(
            children: [
              Container(

                  // height: MediaQuery.of(context).size.height/10,
width: 120,
                  child:Lottie.asset('assets/lang/sent_successfully.json'),
                // Lottie.asset('assets/lang/high.json'),
              ),
              SizedBox(height: 30,),
              Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context).translate('successfully_sent'),style: TextStyle(fontSize: 22,color:Color(0xfff9a200),fontWeight: FontWeight.bold)),
                      SizedBox(height: 10,),

                      Container(

                          // width: 700,
                          child: Text(AppLocalizations.of(context).translate('Absent_Notification_sent_successfully'),textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal ))),




                      SizedBox(height: 10,),
                    ],
                  )),
            ],
          ),
        ),
      ),
      // actions: [Container(
      //   child: SingleChildScrollView(
      //
      //     child: Column(
      //       children: [
      //         Container(
      //             height: MediaQuery.of(context).size.height/10,
      //
      //             child:SvgPicture.asset("images/confirmed_pana_ab.svg",)
      //           // Lottie.asset('assets/lang/high.json'),
      //         ),
      //         SizedBox(height: 20,),
      //         Container(
      //             width: double.infinity,
      //             alignment: Alignment.center,
      //             child: Column(
      //               children: [
      //                 Text("successfully sent",style: TextStyle(fontSize: 22,color:Color(0xfff9a200),fontWeight: FontWeight.bold)),
      //                 SizedBox(height: 10,),
      //
      //                 Text("Absent Notification sent successfully ",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal )),
      //
      //
      //
      //
      //                 SizedBox(height: 10,),
      //               ],
      //             )),
      //       ],
      //     ),
      //   ),
      // ),],

    );
  }
}

class send_book extends StatelessWidget {
  send_book();

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Container(

          width: MediaQuery.of(context).size.height/10,
          alignment: Alignment.topRight,
          child: IconButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Library(std_id: AppCubit.std,std_name: AppCubit.name)));
          }, icon: Icon(Icons.dangerous,color:Color(0xff98aac9) ,))),
      content: Container(
        height: 35.h ,
        child: SingleChildScrollView(

          child: Column(
            children: [
              Container(

                // height: MediaQuery.of(context).size.height/10,
                width: 120,
                child:Lottie.asset('assets/lang/sent_successfully.json'),
                // Lottie.asset('assets/lang/high.json'),
              ),
              SizedBox(height: 30,),
              Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("successfully sent",style: TextStyle(fontSize: 22,color:Color(0xfff9a200),fontWeight: FontWeight.bold)),
                      SizedBox(height: 10,),

                      Container(
                        // color: Colors.red,
                          width: 500,
                          child: Text("Book Notification sent successfully ",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal ))),




                      SizedBox(height: 10,),
                    ],
                  )),
            ],
          ),
        ),
      ),
      // actions: [Container(
      //   child: SingleChildScrollView(
      //
      //     child: Column(
      //       children: [
      //         Container(
      //             height: MediaQuery.of(context).size.height/10,
      //
      //             child:SvgPicture.asset("images/confirmed_pana_ab.svg",)
      //           // Lottie.asset('assets/lang/high.json'),
      //         ),
      //         SizedBox(height: 20,),
      //         Container(
      //             width: double.infinity,
      //             alignment: Alignment.center,
      //             child: Column(
      //               children: [
      //                 Text("successfully sent",style: TextStyle(fontSize: 22,color:Color(0xfff9a200),fontWeight: FontWeight.bold)),
      //                 SizedBox(height: 10,),
      //
      //                 Text("Absent Notification sent successfully ",textAlign: TextAlign.center, style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.normal )),
      //
      //
      //
      //
      //                 SizedBox(height: 10,),
      //               ],
      //             )),
      //       ],
      //     ),
      //   ),
      // ),],

    );
  }
}



class RequestBookDialog extends StatefulWidget {

  String stu_name;
  RequestBookDialog({required this.stu_name});
  @override
  State<RequestBookDialog> createState() => _RequestBookDialogState();
}

class _RequestBookDialogState extends State<RequestBookDialog> {
   late Book book_id;
   String? selectedValue;
   bool copy = false;
   int countDay=0;
   String borrow_day='0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:    AppBar(
        toolbarHeight: 75,
        backgroundColor:Colors.white,
        leadingWidth: double.infinity/4,
        leading: Padding(
          padding:EdgeInsets.only(left: 20,top: 20,bottom: 10,right: 20),
          // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: Container(

            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(

                  child: Text(AppLocalizations.of(context).translate('book_Request'),style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),

                ),

              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 5),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(

                        width: 13.58,
                        height: 22.37,


                        child: SvgPicture.asset("images/times_solid.svg",color:Color(0xff98aac9),))),
              ],
            ),
          ),
        ],








      ),
      body:SingleChildScrollView(
        child: Container(
          // height: 100.h,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

            SizedBox(height: 20,),
            Container(
              // color: Colors.red,
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(AppLocalizations.of(context).translate('book_name')
                ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
            ),


            Padding(
              padding:  EdgeInsets.symmetric(
                  vertical: 4.w, horizontal: 5.w),
              child: DropdownButtonFormField2<dynamic>(
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

                    // Padding(
                    //   padding: EdgeInsets.only(right: 10.0,top: 15,bottom: 15,left: 0),
                    //   child: SvgPicture.asset("images/icons8_school_building.svg",color:  Color(0xff98aac9),width:5.w ,),
                    // ),
                    Text(  AppLocalizations.of(context).translate('select_book')
                  ,
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

                items: AppCubit.book_list
                    .map((item) => DropdownMenuItem(
                  value: item,
                  child: Row(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(right: 4.w),
                      //   child: SvgPicture.asset("images/icons8_school_building.svg",color:  Colors.blue,width:6.w ,),
                      // ),

                      Text(
                        item.name.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ))
                    .toList(),
                validator: (value) {

                  if (value == null) {
                    return 'choose book';
                  }
                },
                onChanged: (value) {
                  // print(book_id);
                  setState(() {
                    book_id = value;
                    // print(book_id);
                    borrow_day=book_id.borrow_days.toString();
                  });
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  setState(() {
                    borrow_day=value.borrow_days.toString();
                  });
                  // print(book_id);
                  selectedValue =  value.name.toString();
                },
              ),
            ),
            SizedBox(height: 20,),
            Container(
              // alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(AppLocalizations.of(context).translate('borrow_period')
               ,style: TextStyle(fontSize: 16,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Colors.black),),
            ),
            SizedBox(height: 10,),
            Row(children: [
              Container(
                  // alignment: Al
                // ignment.centerLeft,
                  padding: EdgeInsets.only(left: 20,right: 20),
                  child: Text(AppLocalizations.of(context).translate('days'))),

              // Card(
              // //
              // //   elevation: 2,
              //   color: Colors.white.withOpacity(.7),
              //   shape:RoundedRectangleBorder(
              //
              //       borderRadius: BorderRadius.circular(6),) ,
              //   margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              // //
              //   child:
              //   Container(
              //     margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              //     child:
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             setState(() {
              //               if(countDay>0){
              //               countDay--;}
              //
              //             });
              //
              //           },
              //           child: Container(
              //             width: 35,
              //             // margin: EdgeInsets.symmetric(vertical: 20),
              //             //   decoration: BoxDecoration(color: color_co_Daily,borderRadius: BorderRadius.circular(8)),
              //             //   height: MediaQuery.of(context).size.height/18,
              //               alignment: Alignment.center,
              //               child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Nunito',color:Colors.black ),)),),
              //         Container(
              //
              //             alignment: Alignment.center,
              //             child: Text("|",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Nunito',color:Colors.black.withOpacity(.2) ),)),
              //         InkWell(
              //           onTap: () {
              //
              //             setState(() {
              //
              //                 countDay++;
              //
              //             });
              //
              //           },
              //           child: Container(
              //               width: 35,
              //               alignment: Alignment.center,
              //               child: Text("+",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,fontFamily: 'Nunito',color:Colors.black ))),)
              //
              // //
              //       ],
              //     ),
              //   )
              // //   ,
              // ),

            ]),
            SizedBox(height: 10,),
            Row(children: [
              Container(
                  // alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20,right: 20),
                child: FlutterSwitch(
                  width: 50.0,
                  // height: 55.0,
                  // valueFontSize: 25.0,
                  // toggleSize: 45.0,
                  value: copy,
                  activeColor: Colors.green,
                  // borderRadius: 30.0,
                  // padding: 8.0,
                  // showOnOff: true,
                  onToggle: (val) {
                    setState(() {
                      copy = val;
                    });
                  },
                ),),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Text(AppLocalizations.of(context).translate('soft_copy'),style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),)),

            ]),

            Container(
height: 50.h,
              // color: Colors.red,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 20),

                    decoration: BoxDecoration(
                        border: Border.all(color:Color(0xff3c92d0),width: 2 ),
                        color: Color(0xff3c92d0),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    height: 55,
                    // color: Colors.orange,
                    child: MaterialButton(
                      child: Text(AppLocalizations.of(context).translate('Submit'),style: TextStyle(color: Colors.white),),
                      onPressed: () async {
                        Map data={};
                        data['student_id']=AppCubit.std;
                        data['copy']=copy;
                        data['book_id']=book_id.id;
                        data['countDay']=int.parse(borrow_day);

                        var responseSettings = await DioHelper.uplodeData(
                            url: Post_Library,
                            data: data,
                            token: CacheHelper.getBoolean(key: 'authorization'))
                            .then((value) {
                          showAnimatedDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return send_book();
                            },
                            animationType: DialogTransitionType.scale,
                            curve: Curves.fastOutSlowIn,
                            duration: Duration(seconds: 1),
                          );
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => Library(std_id: AppCubit.std,std_name: widget.stu_name,)));
                        },).catchError((onError) {

                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 2, horizontal: 20),
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff3c92d0),width: 2.5),
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    // color: Colors.orange,
                    child: MaterialButton(
                      child: Text(AppLocalizations.of(context).translate('cancel'),style: TextStyle(color: Color(0xff3c92d0)),),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Library(std_id: AppCubit.std,std_name: widget.stu_name,)));
                      },
                    ),
                  ),
                ],
              ),
            ),


          ]),


        ),
      ) ,


    );
  }
}


