import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWorksheets.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/models/modelFormWorkSheet.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:url_launcher/url_launcher.dart';





class FormWorksheets extends StatefulWidget {
  String std_id;
  FormWorksheets({required this.std_id});

  @override
  State<FormWorksheets> createState() => _FormWorksheetsState();
}

class _FormWorksheetsState extends State<FormWorksheets> {
  List file=[];
  final list_uplode =GlobalKey();
  bool flg=false;
  List<Widget> student=[];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
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
    return BlocProvider(create: (context) => AppCubit()..getFormWorkSheet(widget.std_id,AppCubit.std),
      child: BlocConsumer<AppCubit,AppStates>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 75,
            backgroundColor:Colors.white,
            leadingWidth: double.infinity/4,
            leading: Padding(
              padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 0),
              // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
              child: Container(

                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(angle:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?9.5:0 ,
                      child: IconButton(
                        onPressed: () {
                          Reset.clear_searhe();
                          // AppCubit.stutes_notif_odoo='';
                          // AppCubit. fromDate_odoo=DateTime.parse("2016-01-01 00:00:00");
                          // AppCubit. fromTo_odoo=DateTime.parse("2035-01-01 00:00:00");
                          // AppCubit.filter_subject=[];
                          // AppCubit.subject_odoo=[];
                          if(AppCubit.back_home) {
                            AppCubit.back_home=false;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Hiome_Kids()),
                            );
                          }
                          else {
                        Navigator.pop(context);
                          }
                        },
                        icon:SvgPicture.asset("images/chevron_left_solid.svg",color:Color(0xff98aac9) ),
                      ),
                    ),
                    Container(

                      child: Text(AppLocalizations.of(context).translate('Homework'),style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold  )),

                    ),

                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding:EdgeInsets.only(left: 10,top: 20,bottom: 10,right: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent ,
                      maxRadius:26,

                      backgroundImage: NetworkImage('${AppCubit.image}', ),
                    ),
                    PopupMenuButton(offset: Offset(0,AppBar().preferredSize.height),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:Icon(Icons.keyboard_arrow_down,size: 28,color: Color(0xff98aac9)) ,itemBuilder: (context) => [

                        PopupMenuItem(child:
                        Container(
                          width:35.w,
                          child: Column(
                            children:student,

                          ),
                        ))
                      ],)
                  ],
                ),
              ),
            ],








          ),
          bottomNavigationBar:CustomBottomBar("images/icons8_four_squares.svg", "images/icons8_home.svg", "images/picup_empty.svg", "images/icon_feather_search.svg","images/bus.svg", Color(0xff98aac9),  Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9), Color(0xff98aac9)),

          body:Container(
            color: Color(0xfff6f8fb),
            child: Column(
              children: [


                Expanded(
                  child:
                  ListView.builder(

                    itemBuilder: (context, index) => formWorkSheet(AppCubit.list_WorkSheet[index]),
                    itemCount: AppCubit.list_WorkSheet.length,
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
  //get design  form work sheet
  Widget formWorkSheet(ResultFormWorkSheet ass) {

    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.date.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String date = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.date.toString();

    String deadline='';
    if(ass.deadline.toString().isNotEmpty){
      DateTime d = DateFormat('dd MMM yyyy').parse(ass.deadline.toString());
      deadline= CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(d):ass.deadline.toString();


    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              // color: Colors.white.withOpacity(.9),
              // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              margin: EdgeInsets.only(bottom: 5),
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(left: 20,right: 20,top: 15,bottom: 10),
                    elevation: 0,
                    child: Row(
                      children: [

                        Container(
                          alignment: Alignment.topLeft,
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
                                  'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Worksheets.svg',color:Color(0xff3c92d0) ,width: 24,),



                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),

                        Expanded(
                          child: Column(children: [

                            Row(
                              children: [
                                Expanded(child: Text( ass.name.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 18,color:Colors.black))),
                                Expanded(
                                  child: Container(alignment:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft:Alignment.centerRight,
                                    // padding:EdgeInsets.only(right: 4),
                                    child: Container(
                                        width: 45,
                                        height: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(3)),color: Color(0xfff9a200)),
                                        child:Text(AppLocalizations.of(context).translate('New'),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 12,color: Colors.white)) ),),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text(AppLocalizations.of(context).translate('Published_Date'),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Container(
                                      child: Text(date,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),
                                ),
                              ],
                            ),
                            // SizedBox(height: 12,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context).translate('Deadline'),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black)),
                                SizedBox(width: 1.w,),
                                Expanded(
                                    child:Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text( deadline,style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color:Colors.black)))),

                              ],
                            )

                          ],),
                        ),

                      ],),
                  ),


                ],
              ),
            ),

            Card(
              // width: double.infinity,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context).translate('Details')
                    ,style: TextStyle(fontSize: 22,color: Color(0xff3c92d0), fontFamily: 'Nunito',fontWeight: FontWeight.w500)),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        Text(AppLocalizations.of(context).translate('Subject')
                            ,style: TextStyle(fontSize: 16,color: Colors.black, fontFamily: 'Nunito',fontWeight: FontWeight.w500)),
                        SizedBox(width: 15,),
                        Expanded(
                          child: Text(ass.subject.toString()
                              ,style: TextStyle(fontSize: 16,color: Colors.black, fontFamily: 'Nunito',fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    Visibility(visible:ass.description.toString().isNotEmpty ,
                        child: SizedBox(height: 10,)),
                    Visibility(
                        visible:ass.description.toString().isNotEmpty,
                        child: Html(data: """${ass.description}""")),
                  ],
                ),
              ),),
            InkWell(
              child:Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                  // margin: EdgeInsets.only(left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),

                      Container(
                          // alignment: Alignment.centerLeft,
                          child: Text(AppLocalizations.of(context).translate('teacher'),style: TextStyle(fontSize: 22,color: Color(0xff3c92d0), fontFamily: 'Nunito',fontWeight: FontWeight.w500))),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent ,
                            maxRadius: 20,


                            backgroundImage: NetworkImage('${ass.teacherImage}', ),

                          ),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    // alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text( ass.teacherName.toString(),style: TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Nunito',fontSize: 14,color: Colors.black))),

                                Container(
                                    // alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: 10),child: Text( ass.teacherPosition.toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 12,color: Color(0xff98aac9)))),
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
            Visibility(
              visible: ass.link.toString().isNotEmpty,
              child: InkWell(
                child:Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5,
                        ),

                        Container(
                            // alignment: Alignment.centerLeft,
                            child: Text( AppLocalizations.of(context).translate('Homework_Attachment'),style: TextStyle(fontSize: 22,color: Color(0xff3c92d0), fontFamily: 'Nunito',fontWeight: FontWeight.w500))),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            // print(ass.link.toString().isEmpty);
                            downloadFile(ass.link.toString(),ass.homeworkName.toString());
                          },
                          child:  Container(
                              // margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                              decoration: BoxDecoration(borderRadius:  BorderRadius.circular(3),
                                  border:Border.all(color:Color(0xffbbc7db) )),

                              // margin: EdgeInsets.all(30),

                              alignment: Alignment.center,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child:Row(
                                children: [
                                  Image(image:AssetImage("images/pdf123.png")),
                                  // SvgPicture.asset("images/pdf.svg"),
                                  // Icon(Icons.cloud_download,),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                      Text(ass.homeworkName.toString(),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))
                                    ]),
                                  ),
                                  SvgPicture.asset("images/icons8_download_from_cloud.svg",color:  Color(0xffbbc7db)),

                                ],
                              )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Container(
                        //
                        //   child: InkWell(
                        //       onTap: () {
                        //         downloadFile(ass.link.toString(),ass.homeworkName.toString());
                        //       },
                        //       child: Container(
                        //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Color(0xff3c92d0)),
                        //
                        //           margin: EdgeInsets.all(30),
                        //
                        //           alignment: Alignment.centerLeft,padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        //           child: Row(
                        //             children: [
                        //
                        //
                        //               Container(
                        //
                        //
                        //                   padding: EdgeInsets.all(15),
                        //                   child: SvgPicture.asset("images/cloud_upload_alt_solid.svg",color: Colors.white,)),
                        //               Text( 'DOWNLOAD HOMEWORK',style: TextStyle(fontWeight: FontWeight.w800, fontFamily: 'Nunito',fontSize: 15,color:Colors.white)),
                        //             ],
                        //           ))),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child:Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  margin: EdgeInsets.only(left: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          // alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 9,vertical: 5),child: Text( AppLocalizations.of(context).translate('Attachments'),style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 22,color: Color(0xff3c92d0)))),

                      ListView.builder(

                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10,right: 15),
                          itemCount:file.length,
                          itemBuilder: (context, index) {
                            return InkWell(

                              //Display car block

                              child:  Container(

                                decoration: BoxDecoration(borderRadius:  BorderRadius.circular(3),
                                    border:Border.all(color:Color(0xffbbc7db) )),

                                child: Row(
                                  children: [
                                    Container(

                                        padding: EdgeInsets.all(15),
                                        child:Image(image:AssetImage("images/pdf123.png"))
                                        // SvgPicture.asset("images/pdf.svg")
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              // alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(file[index]['name'],style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 16,color: Colors.black))),

                                          Container(
                                              // alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),child: Text(  file[index]['size'].toString(),style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Nunito',fontSize: 13,color:Color(0xff8e8c8c)))),
                                        ],
                                      ),
                                    ),
                                    Container(

                                        padding: EdgeInsets.all(15),
                                        child: IconButton(onPressed: () {
                                          setState(() {
                                            // print(flg);
                                            if(file.length>0)
                                            {
                                              file.removeAt(index);

                                              if(file.length>0) {

                                                flg = true;
                                              }
                                              else{

                                                flg = false;
                                              }
                                            }
                                            else{

                                              flg = false;
                                            }


                                          });

                                        }, icon: SvgPicture.asset("images/icons8_delete12.svg",color: Color(0xffbbc7db)))),

                                  ],
                                ),
                              ),         );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {

                        },

                        child: Container(


                          // margin: EdgeInsets.only(left: 20,right: 10),
                          padding: EdgeInsets.only(left: 10,right: 15),
                          height: 60,
                          child: DottedBorder(
                            radius: Radius.circular(10),
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashPattern: [10,2],
                            child: InkWell(
                              onTap:
                                  () async {
                                if(ass.end.toString().isEmpty || ass.end!='True' ){
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
                                    // setStateBu((){
                                    setState(() {

                                      file.add(data);

                                      if(file.length>0)
                                        flg=true;
                                      else
                                        flg=false;


                                    });
                                    // });


                                  }


                                }}

                              },
                              child: Container(
                                width: double.infinity,
                                // margin: EdgeInsets.only(top: 20),
                                color: Color(0xfff5f7fb) ,
                                alignment: Alignment.center,

                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("images/group8555.svg",color:  Color(0xff98aac9),),
                                      // Icon(Icons.cloud_upload,color:  Color(0xff98aac9)),
                                      SizedBox(width: 10,),
                                      Text( AppLocalizations.of(context).translate('Upload_File'),style: TextStyle(color: Color(0xff98aac9))),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: flg,
                        child: Container(
                          // alignment: Alignment.center,
                          // margin: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xff3c92d0)),
                          // height: 60,

                          margin: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: MaterialButton(
                              child: Text(AppLocalizations.of(context).translate('Submits'),style: TextStyle(color: Colors.white),),
                              onPressed: () async {
                                //
                                Map data={};
                                try{


                                  data['file'] =file;}
                                catch(e){
                                  data['file']=[];
                                }
                                data['student_id'] = AppCubit.std;
                                data['wk_id']=widget.std_id;
                                data['session']=CacheHelper.getBoolean(key: 'sessionId');
                                data['base_url']=CacheHelper.getBoolean(key: 'base_url');
                                if(file.length>0){
                                  var responseSettings = await DioHelper.uplodeData(
                                      url: Post_worksheet,
                                      data: data,
                                      token: CacheHelper.getBoolean(key: 'authorization'))
                                      .then((value) {
                                    setState(() {
                                      flg=false;
                                      file=[];
                                      AppCubit()..getFormWorkSheet(widget.std_id,AppCubit.std);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FormWorksheets(std_id: widget.std_id)),);
                                    });


                                  },).catchError((onError) {

                                  });}

                              }
                            // },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
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

      // String fileName=attachments[i].name.toString();

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

      directory!.create();
      await dio.download(
        url, directory.path + fileName, onReceiveProgress: (count, total) {

      },).then((value) async {


        if(Platform.isIOS &&  await canLaunchUrl(url1))
        {
          await launch(url);
        }
        else {
          OpenFile.open(directory!.path + fileName).then((value) {}).onError((
              error, stackTrace) {
          });
        }
        // OpenFile.open(directory!.path + fileName).then((value){}).onError((error, stackTrace) {
        //
        // });
      });
      GallerySaver.saveImage("${directory.path}$fileName")
          .then((value) {})
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
                                      child:  Image(image:AssetImage("images/pdf123.png")),
                                  ),
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
                                  SvgPicture.asset("images/group8555.svg",color:  Color(0xff98aac9),),
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

  Widget student_list(int ind,Students  listDetail1) {
    List<Features> listFeatures1=[];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(

        onTap: () {
          AppCubit.school_image=listDetail1.schoolImage.toString();
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
            MaterialPageRoute(builder: (context) => AllWorksheets( std_id: listDetail1.id.toString(),),),
          );
        },
        child: Row(

            children: [



              CircleAvatar(
                backgroundColor: Colors.transparent ,
                maxRadius: 20,


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

}
