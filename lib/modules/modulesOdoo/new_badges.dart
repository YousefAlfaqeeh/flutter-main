import 'dart:async';

import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/modelClinic.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/badgesModel.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/components/widget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';


class New_Badges extends StatefulWidget {
  String std_id;
  String std_name;
  New_Badges({required this.std_id,required this.std_name});


  @override
  State<New_Badges> createState() => _New_BadgesState();
}

class _New_BadgesState extends State<New_Badges> {
  List<Widget> student=[];
  String last_badge='';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    student.clear();
    for(int i=0;i<AppCubit.list_st.length;i++)
    {
    //
    setState(() {
      MaterialPageRoute navigator=  MaterialPageRoute(
        builder: (context) => New_Badges( std_id: AppCubit.list_st[i].id.toString(),std_name:  AppCubit.list_st[i].name.toString(),),
      );
      student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));

    });

    }
    return BlocProvider(create: (context) => AppCubit()..getBadges(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {

        return WillPopScope(
          onWillPop: () async{
            if(AppCubit.back_home) {
              AppCubit.back_home=false;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Hiome_Kids()),
              );
            }
            else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => New_Detail()),
              );
            }
            return false;
          },
          child: Scaffold(
            bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9),  Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),

            appBar: CustomAppBar(student,AppLocalizations.of(context).translate('badge') ),
            body:Container(
              width: double.infinity,
              height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: Container(
                          width:double.infinity,
                          padding: EdgeInsets.all(20),
                          child:  Text(
                          AppLocalizations.of(context).translate('badge'),
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22.0,
                              color: Color(0xff3c92d0)),
                        ),),
                      ),
                      Visibility(
                          visible: AppCubit.list_Badges.length>0,
                          child:last_Badge() ),
                      AppCubit.list_Badges.length!=0
                          ?
                        Container(
                          child: ListView.separated(
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>index< AppCubit.list_Badges.length?badges(index,AppCubit.list_Badges[index]):SizedBox(height: 200,),
                            itemCount: AppCubit.list_Badges.length+1,
                            separatorBuilder: (context, index) {
                              if(index==0){
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20),
                                  child: Container(

                                      child:FDottedLine(color: Colors.grey,
                                      width: MediaQuery.of(context).size.width,
                                      strokeWidth: 2,
                                      dottedLength: 10,
                                      space: 2,)),
                                );}
                              return SizedBox(height: 1,);
                            },
                          ),
                        )

                      :
                      CustomEmpty("images/no_Badges.png", AppLocalizations.of(context).translate('no_Badge') ),
                      // emptyBadges(),

                    ],
                  ),
                ),
              ),

          ),
        );
      }, listener: (context, state) {

        if(AppCubit.modelBadges?.newAdd==true)
        {
          showDialog(
              context: context,
              builder: (_) =>new_badges_dialogs(image: AppCubit.list_Badges[0].image.toString(), name:  AppCubit.name));
         Timer timer = new Timer(new Duration(seconds: 5), () {
            Navigator.pop(context);
          });
        }

      },),

    );
  }

  Widget badges(int index,ResultBadges result){
    //result.date.toString()
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(result.date.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String date = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):result.date.toString();
    return  InkWell(
        onTap: () {
          if(result.disable==true){
            showDialog(
                context: context,
                builder: (_) =>Dialog_badges(image: result.image.toString(), name:  result.name.toString(), date:  result.date.toString(), description:  result.description.toString()));}

        },

        child: result.disable==true?index==0 ?
        Padding(
          padding: const EdgeInsets.all(20),
          child:  Card(


            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.orangeAccent ,width: 4),borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  width: 20,
                ),
                Container(
                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30,right: 30),
                    padding: EdgeInsets.only(left: 20,top: 20),
                    child: Text(date,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color: Color(0xff98aac9)))),
                SizedBox(
                  height: 20,
                ),

                result.image.toString().contains('http')?
                Container(alignment: Alignment.centerLeft
                    ,  margin: EdgeInsets.only(left: 30,right: 30), width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height/4,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(image:NetworkImage(result.image.toString())))):
                Container(alignment: Alignment.centerLeft
                  ,  margin: EdgeInsets.only(left: 30,right: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                ),

                Container(

                    child:SizedBox(height: 10,)
                    // Divider(
                    //   color: Colors.grey,
                    // )
                ),
                Container(

                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 30,right: 30),
                    // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width/14,
                            backgroundImage: NetworkImage(result.imageT.toString())),
                        SizedBox(width: 10,),
                        Expanded(

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(result.teacher.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black)),
                              Text(result.jopNmae=="null"?result.jopNmae.toString():"",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    )),



              ],
            ),
          ),

        ):
        Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: Colors.white,

            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white ,width: 4),borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 30,top: 20,right: 30),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color:Color(0xff7cb13b),borderRadius:BorderRadius.circular(5) ),
                          child: Text(AppLocalizations.of(context)
                              .translate(
                              'Active')
                              ,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color: Colors.white))),
                    ),
                    Container(
                      // alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        padding: EdgeInsets.only(left: 20,top: 20),
                        child: Text(date,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color: Color(0xff98aac9)))),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffbdd9f8),
                        child: SvgPicture.network('https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Badge.svg',color:Color(0xff3c92d0) ,),

                      ),
                      Container(
                        // alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          padding: EdgeInsets.only(left: 20,top: 10),
                          child: Text(result.name.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))),
                    ],
                  ),
                ),
                result.image.toString().contains('http')?
                Container(
                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 0
                        : 30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 30
                        : 0),
                    width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height/4,

                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(image:NetworkImage(result.image.toString())))):
                Container(
                  // alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                ),
                Container(
                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 0
                        : 30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 30
                        : 0),
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(result.description.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black))),
                Container(

                    child: Divider(
                      color: Colors.grey,
                    )),
                Container(alignment: Alignment.centerLeft,
                    margin:EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 0
                        : 30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 30
                        : 0),
                    // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width/14,
                            backgroundImage: NetworkImage(result.imageT.toString())),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(result.teacher.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black)),
                              Text(result.jopNmae=="null"?result.jopNmae.toString():"",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    )),



              ],
            ),
          ),
        ):
        Padding(
          padding: const EdgeInsets.all(20),
          child: Card(
            color: Colors.white,

            shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white ,width: 4),borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 30,top: 20,right: 30),
                          padding: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(color:Color(0xffe84314),borderRadius:BorderRadius.circular(5) ),
                          child: Text(AppLocalizations.of(context)
                              .translate(
                              'Expired'),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color: Colors.white))),
                    ),
                    Container(
                      // alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 30,right: 30),
                        padding: EdgeInsets.only(left: 20,top: 20),
                        child: Text(date,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color: Color(0xff98aac9).withOpacity(.5)))),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffbdd9f8).withOpacity(.5),
                        child: SvgPicture.network('https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Badge.svg',color:Color(0xff3c92d0).withOpacity(.5) ,),

                      ),
                      Container(
                        // alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          padding: EdgeInsets.only(left: 20,top: 10),
                          child: Text(result.name.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0).withOpacity(.5)))),
                    ],
                  ),
                ),
                result.image.toString().contains('http')?
                Container(
                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 0
                        : 30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 30
                        : 0), width: MediaQuery.of(context).size.width,
                    height:  MediaQuery.of(context).size.height/4,
                    // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    // padding: EdgeInsets.only(left: 20,top: 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image(image:NetworkImage(result.image.toString())))):
                Container(
                  // alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                ),
                Container(
                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 0
                        : 30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 30
                        : 0),
                    padding: EdgeInsets.only(bottom: 15),
                    child: result.description.toString().contains('null')?Text('',style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black.withOpacity(.5))):Text(result.description.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black.withOpacity(.5)))),
                Container(

                    child: Divider(
                      color: Colors.grey.withOpacity(.5),
                    )),
                Container(
                  // alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 0
                        : 30,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                        ? 30
                        : 0),
                    // padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: MediaQuery.of(context).size.width/14,
                            backgroundImage: NetworkImage(result.imageT.toString())),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(result.teacher.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black.withOpacity(.5))),
                              Text(result.jopNmae=="null"?result.jopNmae.toString():"",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black.withOpacity(.5))),
                            ],
                          ),
                        ),
                      ],
                    )),



              ],
            ),
          ),
        )

    );
  }
   Widget last_Badge(){
     last_badge=AppCubit.list_Badges.length>0?AppCubit.list_Badges[0].date.toString():"";
     if(last_badge.isNotEmpty){
       DateTime dt1 = DateFormat('dd MMM yyyy').parse(AppCubit.list_Badges[0].date.toString());
       var formatter = DateFormat.yMMMd('ar_SA');
       last_badge= CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):AppCubit.list_Badges[0].date.toString();
     }
    return  Container(

        child: InkWell(
          child: Container(
            width: double.infinity,

            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10, right: MediaQuery.of(context).size.width/10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            // alignment: Alignment.bottomLeft,
            child: Stack(
              alignment:
              Alignment.center,
              fit: StackFit.passthrough,
              children: [

                Container(
                  height: MediaQuery.of(context).size.height / 6,

                ),
                Padding(
                  padding:  EdgeInsets.only(top: 0,bottom: 40,left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:10,right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?10:0),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Color(0xff3c92d0),
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.only(bottom: 10.0, right:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?MediaQuery.of(context).size.width/4:15,left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?15:MediaQuery.of(context).size.width/4),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context).translate('total_badges')
                                ,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              //AppCubit.list_Badges.length
                              Text(
                                AppCubit.list_Badges.length.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(  AppLocalizations.of(context).translate('last_Badge')
                                ,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              //AppCubit.list_Badges.length
                              Text(

                                AppCubit.list_Badges.length>0?last_badge:"",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                    color: Colors.white),
                              ),
                            ]),
                      )),
                ),

                Stack(
                  children: [

                    Container(

                      // padding: EdgeInsets.only(left: 10),
                        height: 120,
                        child: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Image(
                          image: AssetImage("images/casual_r.png"),)

                        // height: MediaQuery.of(context).size.height/5,
                            :Image(
                          image: AssetImage("images/casual_life_3d_gold_trophy_1.png"),

                          // height: MediaQuery.of(context).size.height/5,
                        )),
                    //  images/bus_genr.png

                    Padding(
                      padding: EdgeInsets.only(
                          top: 40,
                          right: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?60:0,
                          left: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?0:60

                      ),
                      child: Container(
                          height: 85,


                          child: Image(
                            image: AssetImage("images/casual_life_3d_reward_badge_with_star_and_ribbon.png"),

                            // height: MediaQuery.of(context).size.height/5,
                          )),
                      //  images/bus_genr.png
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
   }

}
