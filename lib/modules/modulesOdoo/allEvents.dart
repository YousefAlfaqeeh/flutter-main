import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:udemy_flutter/models/modelAllEvents.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/modulesOdoo/formEvent.dart';
import 'package:udemy_flutter/modules/studet_details/detail.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';





class AllEvents extends StatefulWidget {
  String std_id;
  AllEvents({required this.std_id});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  TextEditingController search = TextEditingController();
  List<ResultAllEvents> list_Ass_Search=[];
  bool flg=false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  onSearchTextChanged(String text)async
  {
    list_Ass_Search.clear();
    if(text.isEmpty)
    {
      setState(() {

      });
      return;
    }
    AppCubit.list_allEvents.forEach((element) {
      if(element.name.toString().contains(text))
      {
        list_Ass_Search.add(element);
      }
    });
    if(list_Ass_Search.isEmpty)
    {
      flg=true;
    }
    else
    {
      flg=false;
    }
    setState(() {


    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..getAllEvents(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return Scaffold(
          body:Container(
            color: Color(0xfff6f8fb),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.blue[700],
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50,left: 20),

                        child: Row(children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => New_Detail()),
                              // );
                            },
                            icon: Container(
                                width: 13.58,
                                height: 22.37,
                                padding: EdgeInsetsDirectional.only(end: 2),
                                child: SvgPicture.asset("images/chevron_left_solid.svg")),
                          ),
                          Container(padding: EdgeInsets.all(3),child: SvgPicture.asset("images/calendar_day_solid.svg"),),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft, child: Text("Events",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 25,color: Colors.white),)),
                        ],),
                      ),

                      Container(
                          padding: EdgeInsets.only(top: 20,bottom: 20),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 30),
                          child: Row(
                            children: [

                              Expanded(
                                child: SizedBox(
                                  width: 284,
                                  child: TextFormField(
                                    controller: search,
                                    onChanged:  onSearchTextChanged,
                                    decoration: InputDecoration(

                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Icon(Icons.search,size: 35),

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


                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                  height: 57,
                                  width: 57,
                                  decoration: BoxDecoration(

                                      gradient: LinearGradient(begin: Alignment.topRight,end: Alignment.topLeft,colors: [
                                        Colors.white,
                                        Colors.white

                                      ]),


                                      borderRadius: BorderRadius.circular(10)),
                                  child: InkWell(onTap: () {

                                  },child:
                                  Container(

                                      padding: EdgeInsets.all(15),
                                      child: SvgPicture.asset("images/filter_solid.svg")) ,))
                            ],
                          )),

                    ],
                  ),
                ),
                // ),
                AppCubit.list_allEvents.length!=0 && !flg
                    ? Expanded(
                  child:list_Ass_Search.length!=0 ? ListView.builder(

                    itemBuilder: (context, index) => allWeekly(list_Ass_Search[index]),
                    itemCount: list_Ass_Search.length,
                    shrinkWrap: true,

                  ):
                  ListView.builder(

                    itemBuilder: (context, index) => allWeekly(AppCubit.list_allEvents[index]),
                    itemCount: AppCubit.list_allEvents.length,
                    shrinkWrap: true,

                  ),
                ):Expanded(child: emptyAss()),

              ],
            ),
          ),
        );
      }, listener: (context, state) {

      },),

    );
  }

  Widget allWeekly(ResultAllEvents ass) {

    if (ass.newAdded =='True')
    {
      return  InkWell(
        onTap: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormEvents(std_id: ass.eventId.toString())),);

        },


        child:Card(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              Row(
                children: [

                  Expanded(child: Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 35),child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)))),
                  Container(alignment: Alignment.centerRight, padding:EdgeInsets.only(right: 30),
                    child: Container(
                      width: 60,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color:Color(0xff7cb13b)),
                      child:Text( 'New',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.white)) ),)
                ],
              ),


              Row(
                children: [



                  Container( margin: EdgeInsets.only(left: 30),
                      padding: EdgeInsets.all(8), child: Text("Date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                  ),



                  Expanded(
                      child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff3c92d0))))),


                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [



                  Container( margin: EdgeInsets.only(left: 30),
                      padding: EdgeInsets.all(8), child: Text("Participant Status",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),




                  Expanded(
                      child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.participantState.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff7cb13b)
                      )))),


                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );

    }
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormEvents(std_id: ass.eventId.toString())),);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => WeeklyPlans(plan_id: ass.id.toString(),plan_name: ass.planName.toString(),std_id: AppCubit.std)),
        // );
      },


      child:Card(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [

                Expanded(child: Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 35),child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)))),
                // Container(alignment: Alignment.centerRight, padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                //   child: Container(
                //       width: 60,
                //       height: 30,
                //       alignment: Alignment.center,
                //       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color:Color(0xff7cb13b)),
                //       child:Text( 'New',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.white)) ),)
              ],
            ),


            Row(
              children: [



                Container( margin: EdgeInsets.only(left: 30),
                    padding: EdgeInsets.all(8), child: Text("Date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                ),



                Expanded(
                    child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff3c92d0))))),


              ],
            ),
            SizedBox(
              width: 20,
            ),
            Row(
              children: [



                Container( margin: EdgeInsets.only(left: 30),
                    padding: EdgeInsets.all(8), child: Text("Participant Status",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),




                Expanded(
                    child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.participantState.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff7cb13b)
                    )))),


              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );

  }

  Widget emptyAss()
  {
    return Container(
      alignment: Alignment.center,

      child:Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Column(children: [
          Expanded(child: Image(image: AssetImage("images/no_events.png") ,width: 293,height: 239,)),
          SizedBox(height: 10,),
          // Text("No Event added",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0).withOpacity(.51)))
          Text("No Events ",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
          SizedBox(height: 10,),
          InkWell(onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => New_Detail()),
            );
          },
              child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
        ]),
      ) ,);
  }
}
