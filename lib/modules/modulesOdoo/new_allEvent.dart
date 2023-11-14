import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelAllEvents.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_formEvent.dart';
import 'package:udemy_flutter/modules/notification/filter_odoo.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';





class New_AllEvents extends StatefulWidget {
  String std_id;
  New_AllEvents({required this.std_id});

  @override
  State<New_AllEvents> createState() => _New_AllEventsState();
}

class _New_AllEventsState extends State<New_AllEvents> {
  TextEditingController search = TextEditingController();
  List<ResultAllEvents> list_Ass_Search=[];
  List<Widget> student=[];
  bool flg=false;
  @override
  void initState() {
    // TODO: implement initState
    onSearchTextChanged();



    super.initState();
  }
  onSearchTextChanged()async
  {
    list_Ass_Search.clear();
    // print(AppCubit.stutes_notif_odoo);
    if(AppCubit.stutes_notif_odoo=='decline')
      {
        AppCubit.stutes_notif_odoo='cancel';
      }
    // if(AppCubit.stutes_notif_odoo.isNotEmpty){
    if(AppCubit.stutes_notif_odoo.isEmpty && AppCubit.fromDate_odoo.toString().isEmpty && AppCubit.fromTo_odoo.toString().isEmpty) {
      setState(() {

      });
      return;
    }
    else if(AppCubit.stutes_notif_odoo.isNotEmpty && AppCubit.fromDate_odoo.toString().isEmpty && AppCubit.fromTo_odoo.toString().isEmpty){
    AppCubit.list_allEvents.forEach((element) {
      if(element.participantState.toString().toLowerCase().contains(AppCubit.stutes_notif_odoo.toLowerCase()))
      {
        list_Ass_Search.add(element);
      }
    });}
    else if(AppCubit.stutes_notif_odoo.isEmpty && AppCubit.fromDate_odoo.toString().isNotEmpty && AppCubit.fromTo_odoo.toString().isEmpty){
      AppCubit.list_allEvents.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        if((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||dt1.isAfter(AppCubit.fromDate_odoo)))
        {
          list_Ass_Search.add(element);
        }
      });}
    else if(AppCubit.stutes_notif_odoo.isEmpty && AppCubit.fromDate_odoo.toString().isEmpty && AppCubit.fromTo_odoo.toString().isNotEmpty){
      AppCubit.list_allEvents.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        if((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo)))
        {
          list_Ass_Search.add(element);
        }
      });}
    else if(AppCubit.stutes_notif_odoo.isEmpty && AppCubit.fromDate_odoo.toString().isNotEmpty && AppCubit.fromTo_odoo.toString().isNotEmpty){
      AppCubit.list_allEvents.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        if(((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) || dt1.isAtSameMomentAs(AppCubit.fromTo_odoo))||((dt1.isBefore(AppCubit.fromTo_odoo) && dt1.isAfter(AppCubit.fromDate_odoo)))))
        {
          // print(element.name);
          list_Ass_Search.add(element);
        }
      });}
    else if(AppCubit.stutes_notif_odoo.isNotEmpty && AppCubit.fromDate_odoo.toString().isNotEmpty && AppCubit.fromTo_odoo.toString().isNotEmpty){
      AppCubit.list_allEvents.forEach((element) {
        // print("object"+element.participantState.toString());
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.startDate.toString());

        if(element.participantState.toString().toLowerCase().contains(AppCubit.stutes_notif_odoo.toLowerCase())&&((dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) || dt1.isAtSameMomentAs(AppCubit.fromTo_odoo))||((dt1.isBefore(AppCubit.fromTo_odoo) && dt1.isAfter(AppCubit.fromDate_odoo)))))
        {
          list_Ass_Search.add(element);
        }
      });}
    else if(AppCubit.stutes_notif_odoo.isNotEmpty && AppCubit.fromDate_odoo.toString().isNotEmpty && AppCubit.fromTo_odoo.toString().isEmpty){
      AppCubit.list_allEvents.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.startDate.toString());
        if(element.participantState.toString().toLowerCase().contains(AppCubit.stutes_notif_odoo.toLowerCase())&&(dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||dt1.isAfter(AppCubit.fromDate_odoo)))
        {
          list_Ass_Search.add(element);
        }
      });}
    else if(AppCubit.stutes_notif_odoo.isNotEmpty && AppCubit.fromDate_odoo.toString().isEmpty && AppCubit.fromTo_odoo.toString().isNotEmpty){
      AppCubit.list_allEvents.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.startDate.toString());

        // DateTime dt1=DateTime.parse(element.startDate.toString());
        // String x=DateFormat('yyyy-MM-dd').format(DateTime.parse(element.startDate.toString()))+" 00:00:00";
        // dt1=DateTime.parse(x.toString());
        if(element.participantState.toString().toLowerCase().contains(AppCubit.stutes_notif_odoo.toLowerCase())&&(dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo)))
        {
          list_Ass_Search.add(element);
        }
      });}
    if(list_Ass_Search.isEmpty)
    {
      flg=true;
    }
    else
    {
      flg=false;
    }
    // }

    setState(() {


    });
  }
  @override
  Widget build(BuildContext context) {
    student.clear();
    for(int i=0;i<AppCubit.list_st.length;i++)
    {
      //
      setState(() {
        student.add(student_list(i, AppCubit.list_st[i]));
      });

    }
    return BlocProvider(create: (context) => AppCubit()..getAllEvents(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return WillPopScope(
          onWillPop: ()async {
            Reset.clear_searhe();
            // AppCubit.stutes_notif_odoo='';
            // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
            // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
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
            appBar: CustomAppBar(student, AppLocalizations.of(context).translate('events')),
            bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9),  Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),

            // appBar: AppBar(
            //   toolbarHeight: 20.w,
            //   backgroundColor:Colors.white,
            //   leadingWidth: double.infinity/4,
            //   leading: Padding(
            //     padding:EdgeInsets.only(left: 20,top: 20,bottom: 10,right: 0),
            //     // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
            //     child: Container(
            //
            //       child: Row(
            //         // mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           IconButton(
            //             onPressed: () {
            //               Reset.clear_searhe();
            //               // AppCubit.stutes_notif_odoo='';
            //               // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
            //               // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
            //               // AppCubit.filter=false;
            //               if(AppCubit.back_home) {
            //                 AppCubit.back_home=false;
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(builder: (context) => Hiome_Kids()),
            //                 );
            //               }
            //               else {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(builder: (context) => New_Detail()),
            //                 );
            //               }
            //             },
            //             icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
            //           ),
            //           Container(
            //
            //             // child: Text("ufuufufufufufu"),
            //             child: Text('Events',style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),
            //
            //           ),
            //
            //         ],
            //       ),
            //     ),
            //   ),
            //   actions: [
            //     Padding(
            //       padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 20),
            //       child: Row(
            //         children: [
            //           CircleAvatar(
            //             backgroundColor: Colors.transparent ,
            //             maxRadius: 6.w,
            //             backgroundImage: NetworkImage('${AppCubit.image}', ),
            //           ),
            //           PopupMenuButton(offset: Offset(0,AppBar().preferredSize.height),
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            //             child:Icon(Icons.keyboard_arrow_down,size: 8.w,color: Color(0xff98aac9)) ,itemBuilder: (context) => [
            //
            //               PopupMenuItem(child:
            //               Container(
            //                 width:35.w,
            //                 child: Column(
            //                   children:student,
            //
            //                 ),
            //               ))
            //             ],)
            //         ],
            //       ),
            //     ),
            //   ],
            //
            //
            //
            //
            //
            //
            //
            //
            // ),
            body:SingleChildScrollView(
              child: Container(
                height:MediaQuery.of(context).size.height,
                color: Color(0xfff5f7fb),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.w),
                      alignment: Alignment.centerRight,
                      child:
                      FilterOdoo(page:() {
                        if(AppCubit.stutes_notif_odoo=='cancel')
                        {
                          //decline
                          AppCubit.stutes_notif_odoo='decline';
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Filter_odoo(),
                            ));

                      })
                    //   Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       Container(
                    //         // color: Colors.red,
                    //         child: Text('Filter', style: TextStyle(
                    //             fontWeight: FontWeight.normal,
                    //             fontSize: 13,
                    //
                    //             fontFamily: 'Nunito',
                    //             color: Color(0xff222222))),
                    //       ),
                    //       IconButton(onPressed: () {
                    //         if(AppCubit.stutes_notif_odoo=='cancel')
                    //         {
                    //           //decline
                    //           AppCubit.stutes_notif_odoo='decline';
                    //         }
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => Filter_odoo(),
                    //           ));
                    //
                    // }, icon:SvgPicture.asset("images/filter11.svg",color:  Color(0xff98aac9),width:6.w ,) ,color:  Color(0xff98aac9),),
                    //     ],
                    //   )
                      ,),
                    AppCubit.list_allEvents.length!=0
                        ? Expanded(
                      child:list_Ass_Search.length!=0&& AppCubit.filter==true ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(

                          itemBuilder: (context, index) => allWeekly(list_Ass_Search[index]),
                          itemCount: list_Ass_Search.length,
                          shrinkWrap: true,

                        ),
                      ):
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(

                          itemBuilder: (context, index) => allWeekly(AppCubit.list_allEvents[index]),
                          itemCount: AppCubit.list_allEvents.length,
                          shrinkWrap: true,

                        ),
                      ),
                    ):
                    Expanded(child:CustomEmpty("images/no_events.png", AppLocalizations.of(context).translate('no_Events')),
                    // emptyAss()
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      }, listener: (context, state) {

      },),

    );
  }
  Widget student_list(int ind,Students  listDetail1) {



    List<Features> listFeatures1=[];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(

        onTap: () {

          AppCubit.stutes_notif_odoo='';

          listFeatures1.clear();
          // if(listDetail1.changeLocation=true)
          // {
          //
          //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
          //
          // }

          listDetail1.features!.forEach((element) {


            listFeatures1.add(element); });

          AppCubit.get(context).setDetalil(listDetail1.name, listDetail1.studentGrade??"", listDetail1.schoolName, listDetail1.avatar, listDetail1.id.toString(),  listDetail1.schoolLat, listDetail1.schoolId.toString(), listDetail1.schoolLng, listDetail1.pickupRequestDistance.toString(), listFeatures1);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => New_AllEvents( std_id: listDetail1.id.toString(),),),
          );
        },
        child: Row(

            children: [


              CircleAvatar(
                backgroundColor: Colors.transparent ,
                maxRadius: 5.w,


                backgroundImage: NetworkImage('${listDetail1.avatar}', ),

              ),
              SizedBox(height: 10,width: 10,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${listDetail1.fname}",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 9),),
                  Text("${AppCubit.grade}",style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 9),),
                ],
              ),
            ]),
      ),
    );
  }
  Widget allWeekly(ResultAllEvents ass) {
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.startDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String formatted = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.startDate.toString();
    return  InkWell(
      onTap: () {
        Reset.clear_searhe();
        // AppCubit.stutes_notif_odoo='';
        // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
        // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormEvents_new(std_id: ass.eventId.toString())),);

      },


      child:Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)),
          margin: EdgeInsets.only(right: 10,bottom: 4.w,left: 10),
          child:
          Padding(
            padding:  EdgeInsets.only(left: 20,top: 8.w,bottom: 5.w),
            child: Row(

              children: [

                Card(
                  shape: const RoundedRectangleBorder(
                      // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  elevation: 0.0,
                  child: Container(

                    child: CircleAvatar(
                      backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                      child:  SvgPicture.network(
                        'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Events.svg',color:Color(0xff3c92d0) ,width:22,),



                    ),
                  ),
                ),
                SizedBox(width: 2.w,),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    Row(
                      children: [
                        Expanded(child: Text(ass.participantState.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 12,color:Color(0xff98aac9)))),
                        Visibility(
                          visible: ass.newAdded =='True',
                          child: Container(
                            // color: Colors.red,
                            // alignment: Alignment.centerRight,
                            padding:EdgeInsets.only(right: 20),
                            child: Container(
                                width: 60,
                                height: 5.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color:Color(0xfff9a200)),
                                child:Text(  AppLocalizations.of(context).translate('New'),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color: Colors.white)) ),),
                        )
                      ],
                    ),
                    SizedBox(width: 1.w,),
                    Container(

                        // alignment: Alignment.topLeft,
                        child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color:Color(0xff000000)))),
                    SizedBox(width: 1.w,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context).translate('Date'),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff000000))),
                        SizedBox(width: 1.w,),
                        Expanded(
                            child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( formatted,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color:Color(0xff4a4a4a))))),

                      ],
                    )

                  ],),
                ),

              ],),
          )

      ),
    );

  }

  // Widget emptyAss()
  // {
  //   return Container(
  //     alignment: Alignment.center,
  //
  //     child:Padding(
  //       padding: EdgeInsets.symmetric(vertical: 50),
  //       child: Column(children: [
  //          Image(image: AssetImage("images/no_events.png") ,width: 65.w,height: 30.h,),
  //         // SizedBox(height: 10,),
  //         // Text("No Event added",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0).withOpacity(.51)))
  //         Text("No Events ",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Colors.black)),
  //         SizedBox(height: 10,),
  //         InkWell(onTap: () {
  //           Reset.clear_searhe();
  //           // AppCubit.stutes_notif_odoo='';
  //           // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
  //           // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => New_Detail()),
  //           );
  //         },
  //             child: Text("Return to profile",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Color(0xff3c92d0),decoration: TextDecoration.underline)))
  //       ]),
  //     ) ,);
  // }
}
