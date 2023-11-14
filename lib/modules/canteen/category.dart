
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/subCategory.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/shared/end_points.dart';

import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';


class Category_food extends StatefulWidget {
  const Category_food({Key? key}) : super(key: key);

  @override
  State<Category_food> createState() => _Category_foodState();
}


class _Category_foodState extends State<Category_food> {
bool isExpanded =false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit()..getCategory(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

          // shwoDialog();

        },
        builder: (context, state) {

          FirebaseMessaging.onMessageOpenedApp.listen((event) {
            setState(() {


            });

          });

          FirebaseMessaging.onMessage.listen((event) {

          });
          return
            WillPopScope(
                onWillPop: () async {
                  Navigator.pop(context);
                  return false;
                },
                child:
                Scaffold(
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton:   Container(
                    height: 50,
                    // color: Colors.red,
                    child: InkWell(
                      onTap: () async {
                       List canteen_banned=[];
for(int i=0;i<AppCubit.menu.length;i++)
  {
    if(AppCubit.menu[i].stutes==true)
      {
        canteen_banned.add(AppCubit.menu[i].id);
      }
  }


                        await DioHelper.postData(
                            url: Post_banned,
                            data: {
                              "student_id": AppCubit.std,
                              "canteen_banned": canteen_banned,
                            },
                            token: CacheHelper.getBoolean(key: 'authorization'))
                            .then(
                              (value) async {
                                   AppCubit()..getCanteen().then((value) { Navigator.push(
                                       context, MaterialPageRoute(builder: (context) => Create_Canteen()));});



                          },
                        ).catchError((onError) {
                          // print(onError);
                        });

                        //Allergies

                      },

                      child: Container(

                        margin: EdgeInsets.symmetric(horizontal:18),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Color(0xff3c92d0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)
                              .translate('Submit'),
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  appBar: AppBar(
                    // primary: false,
                    toolbarHeight: 75,

                    backgroundColor: Colors.white,
                    leadingWidth: MediaQuery.of(context).size.width/1,
                    leading: Container(
                        padding: EdgeInsets.only(left:  30,right: 30),
                        child: Row(
                          children: [
                            Text( AppLocalizations.of(context)
                                .translate('banned_food'),style: TextStyle(fontSize: 22,color:Color(0xff3c92d0)),),
                          ],
                        )),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 30,top: 10,right: 30),
                        child: IconButton(onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Create_Canteen()));
                        }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                      )
                    ],


                  ),
                  //navigation bar
                  backgroundColor:  Color(0xfff4f6fa),
                  //end navigation bar
                  body:   Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 80),
                    child: ListView.builder(
                      itemCount: AppCubit.menu.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _buildList(AppCubit.menu[index]),
                    ),
                  ),
                ));
        },
      ),

    );

  }



  Widget _buildList(Menu list) {

    return Padding(
      padding:  list.sub!?EdgeInsets.symmetric(horizontal: 20):EdgeInsets.only(right: 0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          trailing: SizedBox(),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: (bool expanding) =>
              setState(() => isExpanded = expanding),
          title: Container(
            transform: Matrix4.translationValues(list.sub!?35 : 15, 0, list.sub!?35 : 15),
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Container(

                width: double.infinity,
                child: Row(
                  children: [
                    Theme(data: ThemeData(unselectedWidgetColor:Color(0xff98aac9)),
                      child: Checkbox(value:list.stutes , onChanged: (value) {
                        setState(() {
                          list.stutes=value;
                        });

                      },),
                    ),
                    !list.sub!?Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Color(0xffd8e9f6),
                            borderRadius: BorderRadius.circular(50)),
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: SvgPicture.network(list.icon.toString(),height: 10,width: 10,color: Color(0xff5ba2d7),)),
                      ),
                    ):SizedBox(width: 1,),
                    Expanded(
                      child: Text(
                        list.name.toString(),
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    list.subMenu.length>0?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_circle_down_outlined),
                    ):SizedBox(),


                  ],
                ),
              ),
            ),
          ),
          children: list.subMenu.map(_buildList).toList(),
        ),
      ),
    );
  }

}