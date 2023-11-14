import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/modules/canteen/create_canteen.dart';
import 'package:udemy_flutter/modules/canteen/daily_spending.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';


class Allergies extends StatefulWidget {
  const Allergies({Key? key}) : super(key: key);

  @override
  State<Allergies> createState() => _AllergiesState();
}


class _AllergiesState extends State<Allergies> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit()..getAllAllergies(AppCubit.std),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state) {

        },
        builder: (context, state) {

          FirebaseMessaging.onMessageOpenedApp.listen((event) {


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

                    child: InkWell(
                      onTap: () async {

                        List list_al=[];
                        for(int i=0 ;i<AppCubit.result_Allergies.length;i++)
                          {
                            if(AppCubit.result_Allergies[i].st.toString() !='null'){
                            if(AppCubit.result_Allergies[i].st!)
                              {
                                list_al.add(AppCubit.result_Allergies[i].id);
                              }
                          }}

                        await DioHelper.postData(
                            url: Get_All_Allergies+'/'+ AppCubit.std,
                            data: {
                              "student_id": AppCubit.std,
                              "list_al": list_al,

                            },
                            token: CacheHelper.getBoolean(key: 'authorization'))
                            .then(
                              (value) async {
                                if( AppCubit.show_ecan){
                                  await   AppCubit()..getCanteen().then((value) {

                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => Create_Canteen()));
                                  },);

                                }else{
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (context) => Spending_day()));}
                          },
                        ).catchError((onError) {
                          // print(onError);
                        });

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
                              .translate('next'),
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
                    leadingWidth: 200,
                    leading: Container(
                        padding: EdgeInsets.only(left:  28),
                        child: Row(
                          children: [
                            Container(
                              // color: Colors.red,
                              height: 40,
                              width: 40,
                              child: CircleAvatar(
                                // radius: 30,
                                  backgroundImage: NetworkImage("${AppCubit.image}")),
                            ),
                            SizedBox(width: 10,),
                            Text("${AppCubit.student_name}",style: TextStyle(fontSize: 16,color:Colors.black),),
                          ],
                        )),
                    actions: [
                      Padding(
                        padding: EdgeInsets.only(left: 20,top: 10,right: 20),
                        child: IconButton(onPressed: () {
                          Navigator.pop(context);
                        }, icon:  SvgPicture.asset("images/close.svg",color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,)),
                      )
                    ],


                  ),
                  backgroundColor:  Color(0xfff5f7fb),
                  body:   SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Container(
                          // alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 19,top: 20,right: 19),
                          color:  Color(0xfff5f7fb),
                          // height: 70,
                          child: RichText(text:TextSpan(text: "Choose ",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Color(0xff3c92d0))
                          ,children: [
                                TextSpan(text: '\'${AppCubit.student_name}\'',style: TextStyle(fontWeight:FontWeight.normal,fontSize: 20,color: Color(0xff3c92d0)),),
                                TextSpan(text: " Food Allergies types",style: TextStyle(fontWeight:FontWeight.w600,fontSize: 20,color: Color(0xff3c92d0)),)

                              ]

                          ) ),

                        ),
                        Container(

                          height: MediaQuery.of(context).size.height/1.1,
                          child: ListView.builder(

                            scrollDirection: Axis.vertical,
                            itemCount:AppCubit.result_Allergies.length ,
                            itemBuilder: (context, index) {

                              return food_all(index);
                            },
                          ),
                        ),





                      ],
                    ),
                  ),
                ));
        },
      ),

    );

  }

Widget food_all(int index)
{

  return  Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),child: Container(
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(data: ThemeData(unselectedWidgetColor:Color(0xff98aac9)),
          child: Checkbox(
            checkColor: Colors.white,

            value: AppCubit.result_Allergies[index].st.toString()=='null'?false:AppCubit.result_Allergies[index].st,

            onChanged: (bool? value) {
              setState(() {
                AppCubit.result_Allergies[index].st = value!;
              });
            },
          ),
        ),
        SizedBox(width: 10,),
        SvgPicture.network(AppCubit.result_Allergies[index].icon.toString(),color:  Color(0xff98aac9),width:MediaQuery.of(context).size.width/20 ,),
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            alignment:
            AlignmentDirectional.centerStart,
            child: RichText(
                text: TextSpan(
                  text:AppCubit.result_Allergies[index].name.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito' ,
                      color: Colors.black, fontSize: 16),

                )),
          ),
        ),
        IconButton(onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(20))),
            context: context,
            builder: (context) => DraggableScrollableSheet(
              initialChildSize: .3,
              minChildSize: .2,
              maxChildSize: .97,
              expand: false,
              builder: (context, scrollController) => Scaffold(

                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                    controller: scrollController,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(width: double.infinity,
                          alignment: Alignment.center,
                          child: Card(
                              color: Color(0xffeaeaea),
                              elevation: 0,
                              child: Container(
                                height: 6,
                                width: 50,
                              )),
                        ),
                        Container(width: double.infinity,
                          padding: EdgeInsets.all(20),
                          // alignment: Alignment.,
                          child: Text(AppCubit.result_Allergies[index].name.toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
                        ),
                        Container(width: double.infinity,
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Text(AppCubit.result_Allergies[index].des.toString()),
                        ),

                      ],
                    )),
              ),
            ),
          );
        }, icon: Icon(Icons.info_outline,color: Color(0xff98aac9),))
      ],
    ),
  ),) ;
}


}
