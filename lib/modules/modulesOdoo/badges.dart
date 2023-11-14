import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:udemy_flutter/models/modelClinic.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/badgesModel.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';


class Badges extends StatefulWidget {
  String std_id;
  String std_name;
  Badges({required this.std_id,required this.std_name});

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..getBadges(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return WillPopScope(
          onWillPop: () async{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => New_Detail()),
            );
            return false;
          },
          child: Scaffold(
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),


              notchMargin: 20,
              child: Container(
                height: 60,
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Setting(),
                                  ));
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/icon_feather_search.svg",color: Colors.grey,)
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Tracking(),
                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/bus.svg",color: Colors.grey,)

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Hiome_Kids(),
                                  ));
                            },
                            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/icons8_home.svg",color:  Colors.grey,)
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PickUp_Request(),
                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/pick_up_by_parent.svg",color: Colors.grey,)

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => General_app(),
                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset("images/icons8_four_squares.svg",color: Colors.grey,)

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],

                ),


              ),


            ),
            body:Container(

              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.blue[700],

                    child:
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50,left: 20,bottom: 20),

                          child: Row(children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => New_Detail()),
                                );
                                // Navigator.pop(context);
                              },
                              icon: Container(
                                  width: 13.58,
                                  height: 22.37,
                                  padding: EdgeInsetsDirectional.only(end: 3),
                                  child: SvgPicture.asset("images/chevron_left_solid.svg")),
                            ),
                            Container(padding: EdgeInsets.all(3),child: SvgPicture.asset("images/award_solid.svg"),),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.centerLeft, child: Text("Badges",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
                          ],),
                        ),



                      ],
                    ),
                  ),
                  // ),
                  AppCubit.list_Badges.length!=0
                      ? Expanded(
                    child:
                    ListView.separated(
                      itemBuilder: (context, index) => badges(index,AppCubit.list_Badges[index]),
                      itemCount: AppCubit.list_Badges.length,
                      separatorBuilder: (context, index) {
                        if(index==0){
                          return Container(

                              child: Divider(
                                color: Colors.grey,
                              ));}
                        return SizedBox(height: 1,);
                      },
                    ),
                  ):Expanded(child: emptyBadges()),

                ],
              ),
            ),
          ),
        );
      }, listener: (context, state) {

      },),

    );
  }

  Widget badges(int index,ResultBadges result) => InkWell(
    onTap: () {
      if(result.disable==true){
        showDialog(
            context: context,
            builder: (_) =>Dialog_badges(image: result.image.toString(), name:  result.name.toString(), date:  result.date.toString(), description:  result.description.toString()));}

    },

    child: result.disable==true?index==0 ?
    Column(
      children: [

        SizedBox(
          width: 20,
        ),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 40),
            padding: EdgeInsets.all(8),
            child: Text("Congratulation!",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 28,color: Color(0xff3c92d0)))),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text('Good job '+widget.std_name+" earned a new badge",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),

        result.image.toString().isNotEmpty?
        Container(alignment: Alignment.centerLeft
            ,  margin: EdgeInsets.only(left: 30), width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height/4,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(image:NetworkImage(result.image.toString())))):
        Container(alignment: Alignment.centerLeft
          ,  margin: EdgeInsets.only(left: 30),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        ),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.date.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Color(0xff3c92d0)))),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black))),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.description.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 20,color: Colors.black))),



      ],
    ):
    Column(
      children: [

        SizedBox(
          width: 20,
        ),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.date.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Color(0xff3c92d0)))),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black))),
        // Container(alignment: Alignment.centerLeft
        //     ,  margin: EdgeInsets.only(left: 30),
        //     padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.circular(20),
        //         child: Image(image:NetworkImage(result.image.toString())))),
        result.image.toString().isNotEmpty? Container(
            width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height/4,
            alignment: Alignment.centerLeft
            ,  margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(image:NetworkImage(result.image.toString())))):
        Container(alignment: Alignment.centerLeft
          ,  margin: EdgeInsets.only(left: 30),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

        ),




      ],
    ):
    Column(
      children: [

        SizedBox(
          width: 20,
        ),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.date.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Color(0xff3c92d0).withOpacity(.5)))),
        Container(alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text(result.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black.withOpacity(.5)))),
        result.image.toString().isNotEmpty? Container(
            width: MediaQuery.of(context).size.width,
            height:  MediaQuery.of(context).size.height/4,
            alignment: Alignment.centerLeft

            ,  margin: EdgeInsets.only(left: 30),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: ClipRRect(

                borderRadius: BorderRadius.circular(20),
                child: Image(image:NetworkImage(result.image.toString(),)))): Container(alignment: Alignment.centerLeft
          ,  margin: EdgeInsets.only(left: 30),
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        ),





      ],
    ),
  );
  Widget emptyBadges()
  {
    return Container(
      alignment: Alignment.center,

      child:Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(children: [
          // CustomLotte('assets/lang/chris_Progress.json'),
          // Lottie.asset("Chris_Progress")
          Image(image: AssetImage("images/Image321_11zon.png") ,width: 293,height: 239,),
          SizedBox(height: 34,),
          Text("No Badges added",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 24,color: Color(0xff3c92d0).withOpacity(.51)))
        ]),
      ) ,);
  }
}
