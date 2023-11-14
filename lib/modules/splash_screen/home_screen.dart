import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/login/now_login.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';

import '../home/new_home.dart';
class HomeScreen extends StatefulWidget
{

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool v=false;
  bool v1=false;
  bool v2=false;
  Color ?color_cube;
  @override
  void initState() {
    if(CacheHelper.getBoolean(key: 'authorization')!=null){
      AppCubit()..get_notif('', '');
    }
    Future.delayed(Duration(seconds: 2),() {
      setState(() {
        v=true;
        color_cube=Color(0xff3c92d0);
      });

    },);
    Future.delayed(Duration(seconds: 3),() {
      setState(() {
        color_cube=Color(0xfff9a200);
      });


    },);
    Future.delayed(Duration(seconds: 4),() {
      setState(() {
        color_cube=Color(0xffe84314);
      });


    },);
    Future.delayed(Duration(seconds: 5),() {
      setState(() {
        color_cube=Color(0xff7cb13b);
      });


    },);
    Future.delayed(Duration(seconds: 6),() {
      setState(() {
        v=false;
        v1=true;
      });


    },);
    Future.delayed(Duration(seconds: 7),() {
      setState(() {

        v1=false;
        v2=true;
      });


    },);
    Timer timer = new Timer(new Duration(seconds: 8), () {
      if(CacheHelper.getBoolean(key: 'authorization')==null ||CacheHelper.getBoolean(key: 'authorization').toString().isEmpty)
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Absence(std_id: AppCubit.std)),
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddNewTask()),
      );
      else
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => AllEvents(std_id: '2')),

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Hiome_Kids() ),
        );
    });
    super.initState();
  }
  // @override
  @override
  Widget build(BuildContext context) {
  return  BlocProvider(
    create: (context) {
      if(CacheHelper.getBoolean(key: 'authorization')==null||CacheHelper.getBoolean(key: 'authorization').toString().isEmpty) {
        return AppCubit()
          ..getschool();
      }

      return  AppCubit()..getChildren();
    },
    child: BlocConsumer<AppCubit,AppStates>(
      builder: (context, state) {
   
        return Scaffold(
          backgroundColor: Colors.white,
          body:Container(
            height: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            child: Stack(

                alignment: Alignment.bottomCenter,
                children: [

                  Container(
                    alignment: Alignment.center,
                    height:double.infinity,
                    child:Padding(
                      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomLotte('assets/lang/comp.json'),
                        // Visibility( child:SvgPicture.asset("images/cube_geometry_shape_figure_form_icon.svg",color: color_cube,width:MediaQuery.of(context).size.width/2 ,),visible: v,maintainAnimation: true, maintainState: true, ),
                        // Visibility(child:Image(image: AssetImage("images/logo_without.png") ,width: MediaQuery.of(context).size.width/1.2,height: MediaQuery.of(context).size.height/4,),visible: v1,maintainAnimation: true, maintainState: true, ),
                        // SizedBox(height: 20,),
                        // Visibility(child:
                        // Image(
                        //   image: AssetImage("images/ic_new_logo.png"),
                        //   width: MediaQuery.of(context).size.width/1.2,height: MediaQuery.of(context).size.height/4,
                        // ),visible: v2,maintainAnimation: true, maintainState: true, ),
                      ],),
                    )

                ),
                  Container(
                    height: MediaQuery.of(context).size.height/20,

                    child: Text('All copy right are reserved for Trackware' ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal,),),
                  ),]

            ),
          ),


        );
            // child:Lottie.asset('assets/lang/anm.json'),
        //   ),
        //
        //
        // );
      },
      listener: (context, state) {

      },
    ),

  );
  }
}