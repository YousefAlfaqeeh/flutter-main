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
import 'package:udemy_flutter/shared/shareWid.dart';

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

    if(AppCubit.stutes_notif_odoo=='decline')
      {
        AppCubit.stutes_notif_odoo='cancel';
      }
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
          list_Ass_Search.add(element);
        }
      });}
    else if(AppCubit.stutes_notif_odoo.isNotEmpty && AppCubit.fromDate_odoo.toString().isNotEmpty && AppCubit.fromTo_odoo.toString().isNotEmpty){
      AppCubit.list_allEvents.forEach((element) {

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
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) =>         New_AllEvents( std_id: AppCubit.list_st[i].id.toString(),),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));

      });

    }
    return BlocProvider(create: (context) => AppCubit()..getAllEvents(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return WillPopScope(
          onWillPop: ()async {
            Reset.clear_searhe();
            AppCubit.filter=false;
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
                      ,),
                    AppCubit.list_allEvents.length!=0
                        ? Expanded(
                      child:list_Ass_Search.length!=0|| AppCubit.filter==true ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(

                          itemBuilder: (context, index) => index<list_Ass_Search.length?allWeekly(list_Ass_Search[index]):SizedBox(height: 200,),
                          itemCount: list_Ass_Search.length+1,
                          shrinkWrap: true,

                        ),
                      ):
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListView.builder(

                          itemBuilder: (context, index) => index<AppCubit.list_allEvents.length?allWeekly(AppCubit.list_allEvents[index]):SizedBox(height: 200,),
                          itemCount: AppCubit.list_allEvents.length+1,
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
  Widget allWeekly(ResultAllEvents ass) {
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.startDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String formatted = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.startDate.toString();


    String p='';
    if(ass.participantState.toString().toLowerCase()=="confirm")
      {
        p=AppLocalizations.of(context).translate('CONFIRM_ev');
      }
    else if(ass.participantState.toString().toLowerCase()=="draft")
    {
      p=AppLocalizations.of(context).translate('Draft');
    }
    else if(ass.participantState.toString().toLowerCase()=="cancel")
    {
      p=AppLocalizations.of(context).translate('reject');
    }
    else
      {
        p=AppLocalizations.of(context).translate('reject');
      }
    return  InkWell(
      onTap: () {
        Reset.clear_searhe();
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
                        Expanded(child: Text(p,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 12,color:Color(0xff98aac9)))),
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

}
