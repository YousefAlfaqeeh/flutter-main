import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

class CustomLotte extends StatelessWidget {
  String url;
  CustomLotte(this.url);
 @override
 Widget build(BuildContext context) {
  // TODO: implement build
  return Container(child: Lottie.asset(url),);
 }


}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget  {
  List<Widget> student=[];
  String name;
  // MaterialPageRoute back;

  // const CustomStudent({Key? key}) : super(key: key);
  CustomAppBar(this.student,this.name);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80);


}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return   AppBar(
      elevation: 0,
      // flexibleSpace: ClipRect(child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 0,sigmaY: 0 ))),
      toolbarHeight: 80,
      backgroundColor:Colors.white,
      leadingWidth: double.infinity/4,
      leading: Padding(
        padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 0),
        // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
        child: Container(

          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(angle:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?9.5:0 ,
                child:  IconButton(
                onPressed: () {
                  Reset.clear_searhe();
                  AppCubit.filter=false;
                  AppCubit.typeAbs='Daily';
                  if(AppCubit.back_home) {
                    AppCubit.back_home=false;
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Hiome_Kids()),
                    );
                  }
                  else {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => New_Detail()),
                    );
                  }
                },
                icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
              ),),
              // IconButton(
              //   onPressed: () {
              //     Reset.clear_searhe();
              //     if(AppCubit.back_home) {
              //       AppCubit.back_home=false;
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => Hiome_Kids()),
              //       );
              //     }
              //     else {
              //       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => New_Detail()),
              //       );
              //     }
              //   },
              //   icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
              // ),
              Container(

                // child: Text("ufuufufufufufu"),
                child: Text(widget.name,style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold, fontFamily: 'Nunito'   )),

              ),

            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 20),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent ,
                maxRadius: 6.w,
                backgroundImage: NetworkImage('${AppCubit.image}', ),
              ),
              PopupMenuButton(offset: Offset(0,AppBar().preferredSize.height),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child:Icon(Icons.keyboard_arrow_down,size: 8.w,color: Color(0xff98aac9)) ,itemBuilder: (context) => [

                  PopupMenuItem(child:
                  Container(
                    width:35.w,
                    child: Column(
                      children:widget.student,

                    ),
                  ))
                ],)
            ],
          ),
        ),
      ],








    );
  }
  // Widget student_list(int ind,Students  listDetail1) {
  //
  //
  //
  //   List<Features> listFeatures1=[];
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 8.0),
  //     child: InkWell(
  //
  //       onTap: () {
  //
  //         AppCubit.stutes_notif_odoo='';
  //         AppCubit.school_image=listDetail1.schoolImage.toString();
  //         listFeatures1.clear();
  //         if(listDetail1.changeLocation=true)
  //         {
  //
  //           listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
  //
  //         }
  //
  //         listDetail1.features!.forEach((element) {
  //
  //
  //           listFeatures1.add(element); });
  //
  //         AppCubit.get(context).setDetalil(listDetail1.name, listDetail1.studentGrade??"", listDetail1.schoolName, listDetail1.avatar, listDetail1.id.toString(),  listDetail1.schoolLat, listDetail1.schoolId.toString(), listDetail1.schoolLng, listDetail1.pickupRequestDistance.toString(), listFeatures1);
  //
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => AllWeeklyPlans( std_id: listDetail1.id.toString(),),),
  //         );
  //       },
  //       child: Row(
  //
  //           children: [
  //
  //
  //             CircleAvatar(
  //               backgroundColor: Colors.transparent ,
  //               maxRadius: 5.w,
  //
  //
  //               backgroundImage: NetworkImage('${listDetail1.avatar}', ),
  //
  //             ),
  //             SizedBox(height: 10,width: 10,),
  //
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text("${listDetail1.fname}",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 9),),
  //                 Text("${AppCubit.grade}",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 9),),
  //               ],
  //             ),
  //           ]),
  //     ),
  //   );
  // }
}


class CustomBottomBar extends StatefulWidget {
  String imageGenr,imageHome,imagePick,imageSett,imageTrack;
  Color colorGenr,colorHome,colorPick,colorSett,colorTrack;

  CustomBottomBar(
      this.imageGenr,
      this.imageHome,
      this.imagePick,
      this.imageSett,
      this.imageTrack,
      this.colorGenr,
      this.colorHome,
      this.colorPick,
      this.colorSett,
      this.colorTrack);
  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();


}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool show=true;
  @override
  void initState() {
    //     CacheHelper.saveData(
    //                 key: 'full_system', value: login_info?.full_system);
    //             CacheHelper.saveData(
    //                 key: 'sms_system', value: login_info?.sms_system);
    //             CacheHelper.saveData(
    //                 key: 'tracking_system', value: login_info?.tracking_system);
    // TODO: implement initState
    try {
      if (CacheHelper.getBoolean(key: 'full_system')) {
        show = true;
      }
      else if (CacheHelper.getBoolean(key: 'tracking_system')) {
        show = true;
      }
      else {
        show = false;
      }
    }
    catch(e)
    {  show = true;

    }

    setState(() {

    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),


      notchMargin: 20,
      child: Container(
        height: 50,
        child: Row(
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
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setting(),
                          ));
                    },
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(widget.imageSett,color:widget.colorSett,height: 22,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: show,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tracking(),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(widget.imageTrack,color: widget.colorTrack,height: 22,)

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Hiome_Kids(),
                          ));
                    },
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(widget.imageHome,color: widget.colorHome,height: 22,)
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: show,
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PickUp_Request(),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(widget.imagePick,color:  widget.colorPick,height: 22,)

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => General_app(),
                          ));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(widget.imageGenr,color: widget.colorGenr,height: 22,)

                      ],
                    ),
                  ),
                )
              ],
            ),
          ],

        ),


      ),


    );
  }
}



class CustomEmpty extends StatefulWidget {
   String image;
  String text;
  // Widget button;
  CustomEmpty(this.image, this.text);
  // const CustomEmpty({Key? key}) : super(key: key);

  @override
  State<CustomEmpty> createState() => _CustomEmptyState();


}

class _CustomEmptyState extends State<CustomEmpty> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,

        child:Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(children: [
            // CustomLotte('assets/lang/seedRound_Cup.json'),
            Image(image: AssetImage(widget.image) ,width: 400,height: 239,),
            SizedBox(height: 8,),
            Text(widget.text,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
            SizedBox(height: 14,),
            InkWell(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => New_Detail()),
              );
            },

                child: Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xff3c92d0),width: .5))),
                    child: Text(AppLocalizations.of(context).translate('return_pro'),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0)))))
            // widget.buttons
            // InkWell(onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => New_Detail()),
            //   );
            // },
            //     child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
          ]),
        ) ,),
    );
  }
}


class FilterOdoo extends StatefulWidget {
   Function()? page;
  FilterOdoo({this.page});

  @override
  State<FilterOdoo> createState() => _FilterOdooState();


}

class _FilterOdooState extends State<FilterOdoo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          // color: Colors.red,
          child: Text(AppLocalizations.of(context).translate('Filter'), style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13,

              fontFamily: 'Nunito',
              color: Color(0xff222222))),
        ),
        IconButton(
          onPressed: widget.page,
          icon: SvgPicture.asset(
            "images/filter11.svg",
            color: Color(0xff98aac9),
            width: 20,
          ),
          color: Color(0xff98aac9),
        ),
      ],
    );
  }
}



