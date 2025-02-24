
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/models/modelLibrary.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/general/general_app.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/notification/filter_libary.dart';
import 'package:udemy_flutter/modules/pickUp/pickup.dart';
import 'package:udemy_flutter/modules/settings/setting.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/modules/tracking/tracking.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/components/dialog.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';


class Library extends StatefulWidget {
  String std_id,std_name;

  Library({required this.std_id,required this.std_name});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> with SingleTickerProviderStateMixin {
  List colors=[Colors.red,Colors.orange,Colors.blueAccent];
  Random random =new Random();
  List<Widget> student=[];
  Color color_co_Daily=Colors.red;
  Color color_text_Daily=Colors.white;
  var st_text_Daily=FontWeight.bold;
  var st_text_Absence=FontWeight.normal;
  Color color_co_Absence=Colors.transparent;
  Color color_text_Absence=Color(0xffbbc7db);
   List<BookRequest> requestBook=[];
   List<BookBorrowed> borrowedBook=[];

  String type="Request";
  TextEditingController search = TextEditingController();

  bool flg=false;
  @override
  void initState() {
    // TODO: implement initState
    onSearchDayl();
    // onSearchTextChanged();
    super.initState();
  }

  onSearchDayl()async
  {


    requestBook.clear();
    if(!AppCubit.filter)
    {

      setState(() {

      });
      return;
    }
    if(AppCubit.stutes_notif_odoo.isNotEmpty){

      AppCubit.requestBook.forEach((element) {

        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.requestedDate.toString());
        // print(element.status.toString());
        if(element.status.toString().contains(AppCubit.stutes_notif_odoo.toLowerCase())&&(dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo))&&(dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||dt1.isAfter(AppCubit.fromDate_odoo)))
        {

          requestBook.add(element);

        }
      });
    }
    else
    {

      AppCubit.requestBook.forEach((element) {

        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.requestedDate.toString());
        // if((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo)))
        // {
        if((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo))&&(dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||dt1.isAfter(AppCubit.fromDate_odoo)))
        {

          requestBook.add(element);

        }
      });
    }

    setState(() {


    });







  }
  onSearchTextChanged()async
  {


    borrowedBook.clear();
    if(!AppCubit.filter)
    {

      setState(() {

      });
      return;
    }
    if(AppCubit.stutes_notif_odoo.isNotEmpty){

      AppCubit.borrowedBook.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.dateDelivered.toString());

        if(element.status.toString().toLowerCase().contains(AppCubit.stutes_notif_odoo.toLowerCase())&&(dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo))&&(dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||dt1.isAfter(AppCubit.fromDate_odoo)))
        {

          borrowedBook.add(element);

        }
      });
    }
    else
    {

      AppCubit.borrowedBook.forEach((element) {
        DateTime dt1=DateFormat('dd MMM yyyy').parse(element.dateDelivered.toString());

        if((dt1.isAtSameMomentAs(AppCubit.fromTo_odoo) ||dt1.isBefore(AppCubit.fromTo_odoo))&&(dt1.isAtSameMomentAs(AppCubit.fromDate_odoo) ||dt1.isAfter(AppCubit.fromDate_odoo)))
        {

          borrowedBook.add(element);

        }
      });
    }
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
          builder: (context) =>        Library(std_id: AppCubit.std,std_name: widget.std_name),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));

      });

    }
    return BlocProvider(create: (context) => AppCubit()..getLibrary(widget.std_id),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return  DefaultTabController(
          length:2,
          // The Builder widget is used to have a different BuildContext to access
          // closest DefaultTabController.
          child: Builder(builder: (BuildContext context) {
            final TabController? tabController = DefaultTabController.of(context);
            tabController?.addListener(() {
              if (!tabController.indexIsChanging) {
                // Your code goes here.
                // To get index of current tab use tabController.index
              }
            });
            return WillPopScope(
              onWillPop: ()async {
                Reset.clear_searhe();
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
                return false;
              },
              child: Scaffold(
                bottomNavigationBar:
                BottomAppBar(
                  shape: CircularNotchedRectangle(),


                  notchMargin: 20,
                  child: Container(
                    height: 140,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                      Container(
                      alignment: Alignment.center,
                      // width: 300,

                      child: InkWell(
                          onTap: _down,
                          child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xfff9a200)),
                              height: 60,

                              margin: EdgeInsets.symmetric(vertical: 3,horizontal: 20),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Text( AppLocalizations.of(context).translate('book_Request'),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Tajawal',fontSize: 15,color:Colors.white)),

                                ],
                              ))),

                    ),
                        Row(
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
                                        SvgPicture.asset("images/picup_empty.svg",color: Colors.grey,)

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
                      ],
                    ),


                  ),


                ),
                appBar: CustomAppBar(student,AppLocalizations.of(context).translate('library') ),
                body: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.18,
                    color: Color(0xfff6f8fb),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),boxShadow: [BoxShadow(color: Colors.grey),BoxShadow(color: Colors.white,spreadRadius: -.5,blurRadius: 2.0)]),

                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                          child:
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      color_co_Daily=Colors.red;
                                      color_text_Daily=Colors.white;
                                      color_co_Absence=Colors.transparent;
                                      color_text_Absence=Color(0xffbbc7db);
                                      st_text_Daily=FontWeight.bold;
                                      st_text_Absence=FontWeight.normal;
                                      type='Request';
                                      AppCubit.isBorrowd = false;
                                      // print(AppCubit.dailyAttendance.length);
                                    });

                                  },
                                  child: Container(
                                    // margin: EdgeInsets.symmetric(vertical: 20),
                                      decoration: BoxDecoration(color: color_co_Daily,borderRadius: BorderRadius.circular(8)),
                                      height:40,
                                      alignment: Alignment.center,
                                      child: Text(AppLocalizations.of(context).translate('requested_books'),style: TextStyle(fontWeight: st_text_Daily,fontSize: 15,fontFamily: 'Nunito',color:color_text_Daily ),)),)),
                                Expanded(child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      color_co_Absence=Colors.red;
                                      color_text_Absence=Colors.white;
                                      color_co_Daily =Colors.transparent;
                                      color_text_Daily=Color(0xffbbc7db);
                                      st_text_Absence=FontWeight.normal;
                                      st_text_Daily =FontWeight.bold;
                                      type='borrowed';
                                      AppCubit.isBorrowd = true;
                                    });

                                  },
                                  child: Container(

                                      decoration: BoxDecoration(color: color_co_Absence,borderRadius: BorderRadius.circular(8)),
                                      alignment: Alignment.center,
                                      height:40,
                                      child: Text(AppLocalizations.of(context).translate('borrowed'),style: TextStyle(fontWeight: st_text_Absence,fontSize: 15,fontFamily: 'Nunito',color:color_text_Absence ))),))


                              ],
                            ),
                          )
                          ,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.w),
                          alignment: Alignment.centerRight,
                          child:
                          FilterOdoo(page: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Filter_odoo_Libaray(),
                                ));})
                          ,),
                        //emptyLibrary
                        type=="Request"?AppCubit.requestBook.length>0? Expanded(

                          child: ListView.builder(

                            itemBuilder: (context, index) => getContainerDaily(requestBook.length==0 || !AppCubit.filter?AppCubit.requestBook[index]:requestBook[index]),
                            itemCount:requestBook.length==0 || !AppCubit.filter?AppCubit.requestBook.length:requestBook.length,

                            shrinkWrap: true,

                          ),
                        ):Expanded(child:
                        CustomEmpty("images/library.png",
                            AppLocalizations.of(context).translate('no_book'))
                        // emptyLibrary()
                        ):AppCubit.borrowedBook.length>0?
                        Expanded(child: ListView.builder(

                          itemBuilder: (context, index) => getContainerAbsence( AppCubit.borrowedBook[index]),
                          itemCount:  AppCubit.borrowedBook.length,
                          shrinkWrap: true,

                        )):Expanded(child:
                        CustomEmpty("images/library.png", AppLocalizations.of(context).translate('no_book'))
                        // emptyLibrary()
                        ),




                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );

      }, listener: (context, state) {

      },),

    );
  }


  //get design Requested BOOK
  Widget getContainerDaily(BookRequest dailyAttendance)
  {
    String status=AppLocalizations.of(context).translate('approved');
    Color color=Color(0xff6d9c34);
    double w=80;

    if(dailyAttendance.status.toString()=='under_approval')
    {status=AppLocalizations.of(context).translate('waiting_Approved');
    color=Color(0xfffab92f);
    w=110;
    }
    else if(dailyAttendance.status.toString()=='cancel')
    {status= AppLocalizations.of(context).translate('rejected');
    color=Colors.red;
    }
    else
    {
      status= AppLocalizations.of(context).translate('approved');
    }
    String day= AppLocalizations.of(context).translate('day');
    // day=dailyAttendance.requestedDate.toString();
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(dailyAttendance.requestedDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
     day = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):dailyAttendance.requestedDate.toString();

    return   InkWell(


      child:Card(

        // padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 12,right: 20,top: 15,bottom: 10),
              elevation: 0,
              child: Row(
                children: [

                  Container(
                    // alignment: Alignment.topLeft,
                    // color: Colors.red,
                    height: 60,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                          borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(

                        child: CircleAvatar(
                          backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                          child:  SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/book-app.svg',color:Color(0xff3c92d0) ,width: 20,),



                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6,),

                  Expanded(
                    child: Column(children: [

                      Row(
                        children: [
                          Expanded(child: Text( dailyAttendance.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),
                          Expanded(
                            child: Container(
                              alignment: CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                              // padding:EdgeInsets.only(right: 4),
                              child: Container(
                                  width: w,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color:color),
                                  child:Text(status,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 12,color: Colors.white)) ),),
                          ),
                        ],
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [

                          Container(
                              child: Text(AppLocalizations.of(context).translate('requested_Date'),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),
                          SizedBox(width: 10,),
                          Expanded(child: Container(child: Text(day,style:  TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black.withOpacity(.5))))),

                        ],
                      ),


                    ],),
                  ),

                ],),
            ),



          ],
        ),
      ),
    );
  }
  //get design Borrowed book
  Widget getContainerAbsence(BookBorrowed absenceRequest)
  {

    String day='';
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(absenceRequest.dateDelivered.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    day = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):absenceRequest.dateDelivered.toString();
    dt1=DateFormat('dd MMM yyyy').parse(absenceRequest.dateReturnedOn.toString());
    String dateReturnedOn= CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):absenceRequest.dateReturnedOn.toString();
    dt1=DateFormat('dd MMM yyyy').parse(absenceRequest.dateReturned.toString());
    String dateReturned= CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):absenceRequest.dateReturned.toString();
    return   InkWell(


      child:Card(

        // padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.only(left: 12,right: 20,top: 15,bottom: 10),
              elevation: 0,
              child: Row(
                children: [

                  Container(
                    // alignment: Alignment.topLeft,
                    // color: Colors.red,
                    height: 100,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                          borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(

                        child: CircleAvatar(
                          backgroundColor: Color(0xff3c92d0).withOpacity(.2),
                          child:  SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/book-app.svg',color:Color(0xff3c92d0) ,width: 20,),



                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 6,),

                  Expanded(
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(child: Text( absenceRequest.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: absenceRequest.status.toString()=='done'?Colors.black.withOpacity(.2):Colors.black ))),
                        ],
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          Expanded(child: Text( absenceRequest.bookAuthor.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 12,color:Color(0xff98aac9)))),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [

                          Container(
                              // alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context).translate('delivered_Date'),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color:  absenceRequest.status.toString()=='done'?Colors.black.withOpacity(.2):Colors.black))),
                          SizedBox(width: 10,),
                          Expanded(child: Container(
                              // alignment: Alignment.topLeft,
                              child: Text(day,style:  TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color:Colors.black.withOpacity(.5))))),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [

                          Container(
                              // alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context).translate('due_Date') ,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: absenceRequest.status.toString()=='done'?Colors.black.withOpacity(.2):Colors.black))),
                          SizedBox(width: 50,),
                          Expanded(child: Container(
                              // alignment: Alignment.topLeft,
                              child: Text(dateReturned,style:  TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color:Colors.black.withOpacity(.5))))),

                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [

                          Container(
                              // alignment: Alignment.topLeft,
                              child: Text(AppLocalizations.of(context).translate('returuned_on') ,style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: absenceRequest.status.toString()=='done'?Colors.black.withOpacity(.2):Colors.black))),
                          SizedBox(width: 15,),
                          Expanded(child: Container(
                              // alignment: Alignment.topLeft,
                              child: Text(dateReturnedOn,style:  TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 16,color:Colors.black.withOpacity(.5))))),

                        ],
                      )
                    ],),
                  ),

                ],),
            ),


          ],
        ),
      ),
    );
  }


  Future<void> _down() async {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RequestBookDialog(stu_name: widget.std_name)));

  }


}
