import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';


class Spending_day extends StatefulWidget {
  const Spending_day({Key? key}) : super(key: key);

  @override
  State<Spending_day> createState() => _Spending_dayState();
}


class _Spending_dayState extends State<Spending_day> {

final mySpending=TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit(),
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
                        double canteen_spending=0;
                        if (mySpending.text.isEmpty){
                          mySpending.text='0';
                        }


                        if (mySpending.text.isNotEmpty)
                          {
                            try{
                            canteen_spending=double.parse(mySpending.text);

                            await DioHelper.postData(
                                url: Post_Spending,
                                data: {
                                  "student_id": AppCubit.std,
                                  "canteen_spending": canteen_spending,
                                },
                                token: CacheHelper.getBoolean(key: 'authorization'))
                                .then(
                                  (value) async {


                                    await   AppCubit()..getCanteen().then((value) {
                                      AppCubit.show_ecan=true;
                                      Navigator.push(
                                          context, MaterialPageRoute(builder: (context) => Create_Canteen()));
                                    },);
                              },
                            ).catchError((onError) {
                              print(onError);
                            });

                            }
                                catch(e){

                                }
                          }

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
                        padding: EdgeInsets.only(left:  10),
                        child: Row(
                          children: [
                            Transform.rotate(angle:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?9.5:0 ,
                              child:  IconButton(
                                onPressed: () {
                                  Reset.clear_searhe();
                                  Navigator.pop(context);
                                },
                                icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
                              ),),
                            Container(
                              // color: Colors.red,
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                // radius: 30,
                                  backgroundImage: NetworkImage("${AppCubit.image}")),
                            ),
                            SizedBox(width: 10,),
                            Text("${AppCubit.student_name}",style: TextStyle(fontSize: 16,color: Colors.black),),
                          ],
                        )),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 20,top: 10,right: 20),
                        child: IconButton(onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => Create_Canteen()));
                        }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                      )
                    ],


                  ),
                  //navigation bar
                  backgroundColor:  Color(0xfff5f7fb),
                  //end navigation bar
                  body:   SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          // alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 19,top: 20,right: 19),
                          color:  Color(0xfff5f7fb),
                          // height: 70,
                          child: Text(   AppLocalizations.of(context)
                              .translate('spending'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Color(0xff3c92d0)),),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(elevation: 1,
                          color: Colors.white,
                          child: Container(
                            height: 100,
                             width:double.infinity,
                              alignment: Alignment.center,
                              child:Column(crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                Container(
                                  // alignment: Alignment.topLeft,

                                  // height: 70,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child:
                                  Text(   AppLocalizations.of(context)
                                      .translate('spending_money'),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 12,color: Color(0xff98aac9)),),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 40,),
                                    Container(width: 115,height:56 ,
                                alignment: Alignment.center,
                                decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10)),border: Border.all(width: 2,color:  Color(0xffededed))),

                                    child: TextField(
                                      controller: mySpending,
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))],
                                      decoration: InputDecoration(hintText: '00', border: InputBorder.none,hintStyle: TextStyle(color: Colors.black)),)),
                                    SizedBox(width: 10,),
                                    Text( "JOD",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Color(0xff98aac9)),)
                                  ],)


                              ],)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),),
                        )






                      ],
                    ),
                  ),
                ));
        },
      ),

    );

  }




}
