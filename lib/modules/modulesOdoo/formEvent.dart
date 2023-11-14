import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:udemy_flutter/models/modelEvent.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allEvents.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:url_launcher/url_launcher.dart';





class FormEvents extends StatefulWidget {
  String std_id;
  FormEvents({required this.std_id});

  @override
  State<FormEvents> createState() => _FormEventsState();
}

class _FormEventsState extends State<FormEvents> {
  List file=[];
  final list_uplode =GlobalKey();
  bool flg=false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AppCubit()..getFormEvent(widget.std_id,AppCubit.std),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return Scaffold(
          bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9),  Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),

          body:Container(
            color: Color(0xfff6f8fb),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height:
                  135,
                  color: Colors.blue[700],
                  child:
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50,left: 20),

                        child: Row(children: [
                          IconButton(
                            onPressed: () {
                              // Navigator.pop(context);
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
                    MaterialPageRoute(builder: (context) => AllEvents(std_id:AppCubit.std)),);
                  Navigator.pop(context);
                }
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


                    ],
                  ),
                ),
                // ),

                Expanded(
                  child:
                  ListView.builder(
                    itemBuilder: (context, index) => formEvent(AppCubit.list_Event[index]),
                    itemCount: AppCubit.list_Event.length,
                    shrinkWrap: true,

                  ),
                ),

              ],
            ),
          ),
        );
      }, listener: (context, state) {

      },),

    );
  }
  //get design  form event
  Widget formEvent(ResultEvent ass) {


    return SingleChildScrollView(
      child: Container(


        child: Column(

          children: [
            Container(

                color: Colors.white,

                padding: EdgeInsets.only(left: 20),

                child:Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  children: [

                    Container(
                      alignment: Alignment.centerLeft,
                      width: 150,
                      child: InkWell(
                          onTap: () {

                            if(ass.link.toString().isNotEmpty){
                              downloadFile(ass.link.toString(),ass.name.toString());}
                          },
                          child: Container(

                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff7cb13b)),

                              margin: EdgeInsets.all(30),

                              alignment: Alignment.center,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child:Icon(Icons.cloud_download,color: Colors.white,))),
                    ),
                    Container(padding: EdgeInsets.only(left: 38),
                      alignment: Alignment.centerLeft, child: Text(ass.name.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 20,color: Colors.black)),),
                    Row(
                      children: [



                        Container( margin: EdgeInsets.only(left: 30),
                            padding: EdgeInsets.all(8), child: Text("Published date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                        ),



                        Expanded(
                            child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.startDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Color(0xff3c92d0))))),


                      ],
                    ),
                    Row(
                      children: [



                        Container( margin: EdgeInsets.only(left: 30),
                            padding: EdgeInsets.all(8), child: Text("Deadline",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),
                        Padding(
                          padding: const EdgeInsets.only(left: 53.0),
                          child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                        ),



                        Expanded(
                            child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.endDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Color(0xff3c92d0))))),


                      ],
                    ),



                  ],)

            ),
            //Registation
            InkWell(
              child:Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( 'Registration',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Color(0xff3c92d0)))),
                      Row(
                        children: [



                          Container( margin: EdgeInsets.only(left: 10),
                              child: Text("Start date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                          ),



                          Expanded(
                              child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.registrationStartDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Color(0xff3c92d0))))),


                        ],
                      ),
                      Row(
                        children: [



                          Container( margin: EdgeInsets.only(left: 10),
                              child: Text("End date",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),
                          Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                          ),



                          Expanded(
                              child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text(ass.registrationLastDate.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Color(0xff3c92d0))))),


                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
            //Participant
            InkWell(
              child:Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( 'Participant',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Color(0xff3c92d0)))),
                      Row(
                        children: [



                          Container
                            (
                            // margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10), child: Text("Maximum Participant",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),

                          Expanded(
                              child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( ass.maximumParticipants.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Color(0xff3c92d0))))),


                        ],
                      ),
                      Row(
                        children: [



                          Container(
                            // margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10), child: Text("Available Seats",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),


                          Expanded(
                              child:Container(padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),child: Text( ass.availableSeats.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Colors.red)))),


                        ],
                      ),
                      Row(
                        children: [



                          Container(
                            // margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10), child: Text("Participant Cost",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),


                          Expanded(
                              child:Container(padding: EdgeInsets.symmetric(horizontal: 45,vertical: 10),child: Text( ass.cost.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 14,color:Color(0xff3c92d0))))),


                        ],
                      ),


                    ],
                  ),
                ),
              ),
            ),
            //contact
            InkWell(
              child:Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( 'Contact',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Color(0xff3c92d0)))),

                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent ,
                            maxRadius: MediaQuery.of(context).size.width/15,


                            backgroundImage: NetworkImage('${ass.contactImage.toString()}', ),

                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( ass.contactName.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),

                                Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( 'Teacher',style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Color(0xff3c92d0)))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent ,
                            maxRadius: MediaQuery.of(context).size.width/15,


                            backgroundImage: NetworkImage('${ass.supervisorImage}', ),

                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( ass.supervisorName.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 18,color: Colors.black))),

                                Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( 'Supervisor',style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 18,color: Color(0xff3c92d0)))),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Attachments
            InkWell(
              child:Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( 'Attachments',style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Color(0xff3c92d0)))),
                      ListView.builder(

                          shrinkWrap: true,
                          itemCount:ass.studentSolution!.length,
                          itemBuilder: (context, index) {
                            return InkWell(



                              child:  Container(



                                child: Row(
                                  children: [
                                    Container(

                                        padding: EdgeInsets.all(15),
                                        child: SvgPicture.asset("images/pdf.svg")),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(ass.studentSolution![index].name.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),

                                          Container(
                                              alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(ass.studentSolution![index].fileSize.toString().toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color:Color(0xff8e8c8c)))),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),         );
                          }),

                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: flg,
              child: InkWell(
                child:Card(

                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),


                      ListView.builder(

                          shrinkWrap: true,
                          // padding: new EdgeInsets.all(8.0),
                          itemCount:file.length,
                          itemBuilder: (context, index) {
                            return InkWell(

                              //Display car block

                              child:  Container(


                                child: Row(
                                  children: [
                                    Container(

                                        padding: EdgeInsets.all(15),
                                        child: SvgPicture.asset("images/pdf.svg")),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(file[index]['name'],style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),

                                          Container(
                                              alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(  file[index]['size'].toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color:Color(0xff8e8c8c)))),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        padding: EdgeInsets.all(15),
                                        child: IconButton(onPressed: () {
                                          setState(() {

                                            if(file.length>0)
                                            {
                                              file.removeAt(index);

                                              if(file.length>0) {
                                                flg = true;
                                              }
                                              else{
                                                flg = true;
                                              }
                                            }
                                            else{
                                              flg = true;
                                            }


                                          });

                                        }, icon: Icon(Icons.delete,color: Colors.red,))),

                                  ],
                                ),
                              ),         );
                          }),
                      Visibility( visible: flg,child: SizedBox(height: 10,)),
                      Visibility(
                        visible: flg,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 20),

                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          width:MediaQuery.of(context).size.width/2,
                          child: MaterialButton(
                              child: Text('SUBMIT',style: TextStyle(color: Colors.white),),
                              onPressed: () async {
                                Map data={};
                                try{


                                  data['file'] =file;}
                                catch(e){
                                  data['file']=[];
                                }
                                data['student_id'] = AppCubit.std;
                                data['wk_id']=ass.eventId;
                                data['session']=CacheHelper.getBoolean(key: 'sessionId');
                                data['base_url']=CacheHelper.getBoolean(key: 'base_url');

                                var responseSettings = await DioHelper.uplodeData(
                                    url: Post_Event,
                                    data: data,
                                    token: CacheHelper.getBoolean(key: 'authorization'))
                                    .then((value) {

                                  setState(() {
                                    flg=false;
                                    file=[];
                                    AppCubit()..getFormEvent(widget.std_id,AppCubit.std);
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,

                                        builder: (_) =>
                                            AlertDialog(

                                              actions: [
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,

                                                      alignment: Alignment.center,
                                                      child: Row(
                                                        children: [

                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets.only(left: 20),
                                                              child: Text(
                                                                "Event",style: TextStyle(fontSize: 18,fontFamily: 'Nunito',fontWeight: FontWeight.bold,color:Color(0xff3c92d0)),),
                                                            ),
                                                          ),

                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(builder: (context) => FormEvents(std_id: ass.eventId.toString())),);

                                                              },
                                                              icon: Container(

                                                                  width: 13.58,
                                                                  height: 22.37,


                                                                  child: SvgPicture.asset("images/times_solid.svg"))),


                                                        ],
                                                      ),

                                                    ),
                                                    SizedBox(height: 10,),
                                                    Container(alignment: Alignment.center,
                                                      padding: EdgeInsets.only(left: 20),
                                                      width: double.infinity,
                                                      child:  Text('YOU HAVE SUCCESSFULLY CONFIRMED THE EVENT',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color:Color(0xff3c92d0) ),),),
                                                    // Container(alignment: Alignment.center,
                                                    //   padding: EdgeInsets.only(left: 20),
                                                    //   width: double.infinity,
                                                    //   child:  Text("CONFIRMED THE EVENT",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900,color:Color(0xff3c92d0) ),),),

                                                    SizedBox(height: 10,),

                                                    Container(
                                                        child:Image(image: AssetImage("images/calendar_Monochromatic.png")) ),
                                                    Container(alignment: Alignment.center,
                                                      width: double.infinity,
                                                      child:  TextButton(onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(builder: (context) => AllEvents(std_id:AppCubit.std)),);
                                                      },child: Text("Back to event page",style: TextStyle(fontSize: 12,decoration: TextDecoration.underline,fontWeight: FontWeight.normal,color:Color(0xff3c92d0) ),)),),

                                                  ],)


                                              ],

                                            ));

                                  });


                                },).catchError((onError) {
                                  // print(onError);
                                });


                              }

                          ),
                        ),

                      ),
                      Visibility( visible: flg,child: SizedBox(height: 10,)),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            //CONFIRM
            Visibility(
              visible: ass.state == "draft",
              child: Container(
                alignment: Alignment.center,
                width: 300,

                child: InkWell(
                    onTap: showDialodUplod,
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Color(0xff7cb13b)),



                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(


                                padding: EdgeInsets.all(15),
                                child: Icon(Icons.check_circle,color: Colors.white,)),
                            Text( 'CONFIRM',style: TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Nunito',fontSize: 15,color:Colors.white)),

                          ],
                        ))),

              ),
            ),
            //DECLINE
            Visibility(
              visible: ass.state == "draft",
              child: Container(


                child: InkWell(
                    onTap: () => showDialodDelete(ass.eventId.toString()),
                    child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Color(0xfff1f1f1)),

                        margin: EdgeInsets.all(30),

                        alignment: Alignment.center,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(


                                padding: EdgeInsets.all(15),
                                child: Icon(Icons.dangerous_outlined,color: Colors.black,)),
                            Text( 'DECLINE',style: TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Nunito',fontSize: 15,color:Colors.black)),

                          ],
                        ))),

              ),
            ),

          ],
        ),
      ),
    );

  }
  // method get  Permission save  any file
  Future<bool> _requestWrritePermission()
  async { await Permission.storage.request();
  return await Permission.storage.request().isGranted;
  }
//  method download any file and save
  Future<void> downloadFile(String url,String fileName)
  async {

    var url1=Uri.parse(url);

    if(Platform.isIOS )
    {
      if(await canLaunchUrl(url1))
      {
        // print(CacheHelper.getBoolean(key: 'sessionId'));
        // await launchUrl(url);
        await launch(url.toString(), headers: {
          "X-Openerp-Session-Id":
          CacheHelper.getBoolean(key: 'sessionId')
        } );
      }
      // FlutterDownloader.enqueue(url: url, savedDir: directory!.path ,showNotification: true,openFileFromNotification: true);
      // await launch(url);
    }
    bool hasPermission = await _requestWrritePermission();

    if(hasPermission){


      Dio dio = Dio();
      //
      //   // String fileName=attachments[i].name.toString();
      //
      Directory? directory;
      try {
        if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();

        }
        else {
          directory = Directory('/storage/emulated/0/Download/');
          // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
          // ignore: avoid_slow_async_io
          if (!await directory.exists())
            directory = await getExternalStorageDirectory();
        }
      } catch (err, stack) {
        // print("Cannot get download folder path");
      }
      //
      directory!.create();
      await dio.download(
        url, directory.path + fileName, onReceiveProgress: (count, total) {
        // print(count/total*100);

      },).then((value) async {

        // var url1=Uri.parse(url);
        // var url1=Uri.parse(url);

        // if(Platform.isIOS &&  await canLaunchUrl(url1))
        // {
        //   if(await canLaunchUrl(url1))
        //   {
        //     print(CacheHelper.getBoolean(key: 'sessionId'));
        //     // await launchUrl(url);
        //     await launch(url.toString(), headers: {
        //       "X-Openerp-Session-Id":
        //       CacheHelper.getBoolean(key: 'sessionId')
        //     } );
        //   }
        //   // FlutterDownloader.enqueue(url: url, savedDir: directory!.path ,showNotification: true,openFileFromNotification: true);
        //   await launch(url);
        // }
        // else {

          OpenFile.open(directory!.path + fileName).then((value) {

            
          }).onError((
              error, stackTrace) {
          });
        // }
      }).catchError((onError){


      });

      GallerySaver.saveImage("${directory.path}$fileName")
          .then((value) {

      })
          .onError((error, stackTrace) {
        GallerySaver.saveVideo("${directory!.path}$fileName")
            .then((value) {})
            .onError((error, stackTrace) => null);
      });
    }
  }
  void showDialodUplod()
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>  AlertDialog(
          content: StatefulBuilder(builder: (context, setStateBu) {
            return  Container(

              child: SingleChildScrollView(
                child: Column(
                  children: [

                    ListView.builder(

                        shrinkWrap: true,
                        // padding: new EdgeInsets.all(8.0),
                        itemCount:file.length,
                        itemBuilder: (context, index) {
                          return InkWell(

                            //Display car block

                            child:  Container(


                              child: Row(
                                children: [
                                  Container(

                                      padding: EdgeInsets.all(15),
                                      child: SvgPicture.asset("images/pdf.svg")),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(file[index]['name'],style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),

                                        Container(
                                            alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(  file[index]['size'].toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color:Color(0xff8e8c8c)))),
                                      ],
                                    ),
                                  ),
                                  Container(

                                      padding: EdgeInsets.all(15),
                                      child: IconButton(onPressed: () {
                                        setStateBu(() {
                                          setState(() {
                                            file.removeAt(index);

                                          });
                                        });


                                      }, icon: Icon(Icons.delete,color: Colors.red,))),

                                ],
                              ),
                            ),         );
                        }),


                    InkWell(
                      onTap: () async {

                      },

                      child: Container(

                        margin: EdgeInsets.only(left: 20,right: 10),
                        padding: EdgeInsets.only(left: 10),
                        height: 100,
                        child: DottedBorder(
                          color: Colors.grey,
                          strokeWidth: 3,
                          dashPattern: [10,6],
                          child: InkWell(
                            onTap:
                                () async {
                              var status = await Permission.storage.request();
                              if (status.isGranted) {
                                final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                                if (result == null) return;
                                Map<String,dynamic> data={};

                                for(int i=0;i<result.count;i++)
                                {
                                  data['name']=result.files[i].name;
                                  data['size']=result.files[i].size;
                                  data['file'] = base64Encode(File(result.files[i].path!).readAsBytesSync());
                                  data['base_url']=CacheHelper.getBoolean(key: 'base_url');
                                  setStateBu((){
                                    setState(() {

                                      file.add(data);

                                      if(file.length>0)
                                        flg=true;
                                      else
                                        flg=false;


                                    });
                                  });


                                }


                              }

                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 20),

                              alignment: Alignment.center,

                              child: Column(
                                children: [
                                  Icon(Icons.cloud_upload,color: Colors.grey),
                                  Text('Upload file here'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ),
                    SizedBox(height: 20,),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20),

                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      width:MediaQuery.of(context).size.width/2,
                      // color: Colors.orange,
                      child: MaterialButton(
                          child: Text('CONFIRM',style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            setStateBu((){
                              setState(() {

                                flg=true;

                              });
                            });

                            Navigator.pop(context);


                          }
                        // },
                      ),
                    ),

                  ],
                ),
              ),
            );
          },),


        ));

  }

  void showDialodDelete(String eventId )
  {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) =>  AlertDialog(
          content: StatefulBuilder(builder: (context, setStateBu) {
            return  Container(

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(children: [
                      Container(alignment: Alignment.centerLeft,child:Text("Event",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 24,color:Color(0xff3c92d0)))) ,
                      Expanded(
                        child: Container(alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: 20),
                          padding: EdgeInsets.all(8),child: InkWell(onTap: () {
                            Navigator.pop(context);
                          },child: SvgPicture.asset("images/times_solid.svg")),),
                      ),
                    ],),
                    SizedBox(height: 10,),

                    Container(
                        child:Image(image: AssetImage('images/decline.png')) ),
                    Container(
                        alignment: Alignment.center,child:Text("Are you sure you want to decline the event",style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 20,color:Colors.black)) ),

                    SizedBox(height: 10,),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20),

                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      width:MediaQuery.of(context).size.width/2,
                      // color: Colors.orange,
                      child: MaterialButton(
                          child: Text('Yes',style: TextStyle(color: Colors.white),),
                          onPressed: () async {
                            Map data={};
                            data['wk_id']=eventId;
                            var responseSettings = await DioHelper.uplodeData(
                                url: Cancel_Event,
                                data: data,
                                token: CacheHelper.getBoolean(key: 'authorization'))
                                .then((value) {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FormEvents(std_id: eventId)),);



                            },).catchError((onError) {

                            });



                          }
                        // },
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 20),

                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width:MediaQuery.of(context).size.width/2,
                      // color: Colors.orange,
                      child: MaterialButton(
                          child: Text('No',style: TextStyle(color: Colors.black),),
                          onPressed: () async {


                            Navigator.pop(context);


                          }
                        // },
                      ),
                    ),

                  ],
                ),
              ),
            );
          },),


        ));

  }

}
