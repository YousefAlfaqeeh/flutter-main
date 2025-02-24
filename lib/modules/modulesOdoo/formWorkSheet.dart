import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWorksheets.dart';
import 'package:udemy_flutter/modules/webview/webview_login.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/models/modelFormWorkSheet.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udemy_flutter/shared/shareWid.dart';

class FormWorksheets extends StatefulWidget {
  String std_id;

  FormWorksheets({required this.std_id});

  @override
  State<FormWorksheets> createState() => _FormWorksheetsState();
}

class _FormWorksheetsState extends State<FormWorksheets> {
  List file = [];
  final list_uplode = GlobalKey();
  bool flg = false;
  List<Widget> student = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    student.clear();
    for (int i = 0; i < AppCubit.list_st.length; i++) {
      //
      setState(() {
        MaterialPageRoute navigator=  MaterialPageRoute(
          builder: (context) =>         AllWorksheets(
            std_id: AppCubit.list_st[i].id.toString(),
          ),
        );
        student.add(student_list(i,  AppCubit.list_st[i],widget.std_id , navigator,context));
      });
    }
    return BlocProvider(
      create: (context) =>
          AppCubit()..getFormWorkSheet(widget.std_id, AppCubit.std),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: ()async {
              Reset.clear_searhe();
              if (AppCubit.back_home) {
                AppCubit.back_home = false;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Hiome_Kids()),
                );
              } else {

                Navigator.of(context).pop();

              }
              return false;
            },
            child: Scaffold(
              appBar: AppBar(
                toolbarHeight: 75,
                backgroundColor: Colors.white,
                leadingWidth: double.infinity / 4,
                leading: Padding(
                  padding:
                      EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 0),
                  // padding:  EdgeInsets.symmetric(vertical: 20,horizontal: 40),
                  child: Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: CacheHelper.getBoolean(key: 'lang')
                                  .toString()
                                  .contains('ar')
                              ? 9.5
                              : 0,
                          child: IconButton(
                            onPressed: () async {
                              Reset.clear_searhe();
                              if (AppCubit.back_home) {
                                AppCubit.back_home = false;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Hiome_Kids()),
                                );
                              } else {
                               await AppCubit()..getAllWorksheets(widget.std_id);
                                Navigator.of(context).pop();
                              }
                            },
                            icon: SvgPicture.asset(
                                "images/chevron_left_solid.svg",
                                color: Color(0xff98aac9)),
                          ),
                        ),
                        Container(
                          child: Text(
                              AppLocalizations.of(context).translate('Homework'),
                              style: TextStyle(color:Color(0xff3c92d0),fontSize: 28,fontWeight: FontWeight.bold, fontFamily: 'Nunito'   )),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10, top: 20, bottom: 10, right: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          maxRadius: 26,
                          backgroundImage: NetworkImage(
                            '${AppCubit.image}',
                          ),
                        ),
                        PopupMenuButton(
                          offset: Offset(0, AppBar().preferredSize.height),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Icon(Icons.keyboard_arrow_down,
                              size: 28, color: Color(0xff98aac9)),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: Container(
                              width: 35.w,
                              child: Column(
                                children: student,
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: CustomBottomBar(
                  "images/icons8_four_squares.svg",
                  "images/icons8_home.svg",
                  "images/picup_empty.svg",
                  "images/icon_feather_search.svg",
                  "images/bus.svg",
                  Color(0xff98aac9),
                  Color(0xff98aac9),
                  Color(0xff98aac9),
                  Color(0xff98aac9),
                  Color(0xff98aac9)),
              body: Container(
                color: Color(0xfff6f8fb),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            formWorkSheet(AppCubit.list_WorkSheet[index]),
                        itemCount: AppCubit.list_WorkSheet.length,
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  //get design  form work sheet
  Widget formWorkSheet(ResultFormWorkSheet ass) {
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.date.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String date = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
        ? formatter.format(dt1)
        : ass.date.toString();

    String deadline = '';
    if (ass.deadline.toString().isNotEmpty) {
      DateTime d = DateFormat('dd MMM yyyy').parse(ass.deadline.toString());
      deadline = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
          ? formatter.format(d)
          : ass.deadline.toString();
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 15, bottom: 10),
                    elevation: 0,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 100,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    width: .8, color: Color(0xffd4ddee)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50.0))),
                            elevation: 0.0,
                            child: Container(
                              child: CircleAvatar(
                                backgroundColor:
                                    Color(0xff3c92d0).withOpacity(.2),
                                child: SvgPicture.network(
                                  'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Worksheets.svg',
                                  color: Color(0xff3c92d0),
                                  width: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(ass.name.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Nunito',
                                              fontSize: 18,
                                              color: Colors.black))),
                                  Expanded(
                                    child: Container(
                                      alignment:
                                          CacheHelper.getBoolean(key: 'lang')
                                                  .toString()
                                                  .contains('ar')
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                      child: Container(
                                          width: 45,
                                          height: 20,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(3)),
                                              color: Color(0xfff9a200)),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  .translate('New'),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 12,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('Published_Date'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Text(date,
                                            style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                                color: Colors.black))),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 12,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('Deadline'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(deadline,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  color: Colors.black)))),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      AppLocalizations.of(context)
                                          .translate('teacher'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          color: Colors.black)),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Expanded(
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(ass.teacherName.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 16,
                                                  color: Colors.black)))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            getBox(AppLocalizations.of(context).translate('Details'), '',ass.subject.toString() ,ass.description.toString(), context,true),
            Visibility(
              visible: ass.howmorkList!.length>0,
              child:getAtthmint(ass.homeworkName.toString(), ass.link.toString(),ass.howmorkList!),
            ),
            Visibility(visible:ass.externalLink.toString().isNotEmpty ,
                child: getBox(AppLocalizations.of(context).translate('external'), ass.externalLink.toString(),ass.subject.toString() ,'', context,false)),


            Visibility(visible:ass.teacherNote.toString().isNotEmpty ,
                child: getBox(AppLocalizations.of(context).translate('Note'), ass.teacherNote.toString(),'' ,'', context,false)),
            // getBoxTeacher(ass.teacherName.toString() ,ass.teacherPosition.toString(), ass.teacherImage.toString(), context),

            //  ListView.builder(itemBuilder: (context, index) => getAtthmint(ass.homeworkName.toString()  ,ass.link.toString()),itemCount: ass.howmorkList!.length)
            InkWell(
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('Attachments_student'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 22,
                                  color: Color(0xff3c92d0)))),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10, right: 15),
                          itemCount: file.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              //Display car block

                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border:
                                        Border.all(color: Color(0xffbbc7db))),
                                child: Row(
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(15),
                                        child: Image(
                                            image:
                                                AssetImage("images/pdf123.png"))
                                        // SvgPicture.asset("images/pdf.svg")
                                        ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              // alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(file[index]['name'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Nunito',
                                                      fontSize: 16,
                                                      color: Colors.black))),
                                          Container(
                                              // alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                  file[index]['size']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Nunito',
                                                      fontSize: 13,
                                                      color:
                                                          Color(0xff8e8c8c)))),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: EdgeInsets.all(15),
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                // print(flg);
                                                if (file.length > 0) {
                                                  file.removeAt(index);

                                                  if (file.length > 0) {
                                                    flg = true;
                                                  } else {
                                                    flg = false;
                                                  }
                                                } else {
                                                  flg = false;
                                                }
                                              });
                                            },
                                            icon: SvgPicture.asset(
                                                "images/icons8_delete12.svg",
                                                color: Color(0xffbbc7db)))),
                                  ],
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {},
                        child: Container(
                          // margin: EdgeInsets.only(left: 20,right: 10),
                          padding: EdgeInsets.only(left: 10, right: 15),
                          height: 60,
                          child: DottedBorder(
                            radius: Radius.circular(10),
                            color: Colors.grey,
                            strokeWidth: 1,
                            dashPattern: [10, 2],
                            child: InkWell(
                              onTap: () async {
                                if (ass.end.toString().isEmpty ||
                                    ass.end != 'True') {

                                  if(!Platform.isAndroid)
                                    {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
                                      if (result == null) return;
                                      Map<String, dynamic> data = {};

                                      for (int i = 0; i < result.count; i++) {
                                        data['name'] = result.files[i].name;
                                        data['size'] = result.files[i].size;
                                        data['file'] = base64Encode(
                                            File(result.files[i].path!)
                                                .readAsBytesSync());
                                        data['base_url'] =
                                            CacheHelper.getBoolean(key: 'base_url');
                                        // setStateBu((){
                                        setState(() {
                                          file.add(data);

                                          if (file.length > 0)
                                            flg = true;
                                          else
                                            flg = false;
                                        });
                                        // });
                                      }
                                    }
else {
                                    final deviceInfo = await DeviceInfoPlugin().androidInfo;
                                    if (deviceInfo.version.sdkInt! > 32) {
                                      // var  permissionaudio = await Permission.storage.request().isGranted;
                                      // print(permissionaudio);
                                      // print("--------------");
                                      FilePickerResult? result = await FilePicker
                                          .platform.pickFiles(
                                          allowMultiple: true);
                                      if (result == null) return;
                                      Map<String, dynamic> data = {};

                                      for (int i = 0; i < result.count; i++) {
                                        data['name'] = result.files[i].name;
                                        data['size'] = result.files[i].size;
                                        data['file'] = base64Encode(
                                            File(result.files[i].path!)
                                                .readAsBytesSync());
                                        data['base_url'] =
                                            CacheHelper.getBoolean(
                                                key: 'base_url');
                                        // setStateBu((){
                                        setState(() {
                                          file.add(data);

                                          if (file.length > 0)
                                            flg = true;
                                          else
                                            flg = false;
                                        });
                                        // });
                                      }
                                    } else {
                                      var status =
                                      await Permission.storage.request();
                                      if (status.isGranted) {
                                        final result = await FilePicker.platform
                                            .pickFiles(allowMultiple: true);
                                        if (result == null) return;
                                        Map<String, dynamic> data = {};

                                        for (int i = 0; i < result.count; i++) {
                                          data['name'] = result.files[i].name;
                                          data['size'] = result.files[i].size;
                                          data['file'] = base64Encode(
                                              File(result.files[i].path!)
                                                  .readAsBytesSync());
                                          data['base_url'] =
                                              CacheHelper.getBoolean(
                                                  key: 'base_url');
                                          // setStateBu((){
                                          setState(() {
                                            file.add(data);

                                            if (file.length > 0)
                                              flg = true;
                                            else
                                              flg = false;
                                          });
                                          // });
                                        }
                                      }
                                    }
                                  }




                                }
                              },
                              child: Container(
                                width: double.infinity,
                                // margin: EdgeInsets.only(top: 20),
                                color: Color(0xfff5f7fb),
                                alignment: Alignment.center,

                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "images/group8555.svg",
                                        color: Color(0xff98aac9),
                                      ),
                                      // Icon(Icons.cloud_upload,color:  Color(0xff98aac9)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('Upload_File'),
                                          style: TextStyle(
                                              color: Color(0xff98aac9))),
                                    ]),
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xff3c92d0)),
                          // height: 60,

                          margin: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: MaterialButton(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('Submit'),
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                //
                                Map data = {};
                                try {
                                  data['file'] = file;
                                } catch (e) {
                                  data['file'] = [];
                                }
                                data['student_id'] = AppCubit.std;
                                data['wk_id'] = widget.std_id;
                                data['session'] =
                                    CacheHelper.getBoolean(key: 'sessionId');
                                data['base_url'] =
                                    CacheHelper.getBoolean(key: 'base_url');
                                if (file.length > 0) {
                                  var responseSettings =
                                      await DioHelper.uplodeData(
                                              url: Post_worksheet,
                                              data: data,
                                              token: CacheHelper.getBoolean(
                                                  key: 'authorization'))
                                          .then(
                                    (value) {
                                      setState(() {
                                        flg = false;
                                        file = [];
                                        AppCubit()
                                          ..getFormWorkSheet(
                                              widget.std_id, AppCubit.std);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FormWorksheets(
                                                      std_id: widget.std_id)),
                                        );
                                      });
                                    },
                                  ).catchError((onError) {});
                                }
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
Widget getAtthmint(String name  ,link, List<HowmorkList> howmorkList)
{
  return InkWell(
    child: Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),

            Container(
                child: Text(
                    AppLocalizations.of(context)
                        .translate('Homework_Attachment'),
                    style: TextStyle(
                        fontSize: 22,
                        color: Color(0xff3c92d0),
                        fontFamily: 'Nunito',
                        fontWeight: FontWeight.w500))),
            SizedBox(
              height: 10,
            ),


            Container(
              height: 15.h,
              child: ListView.builder(itemBuilder: (context, index) =>  InkWell(
                onTap: () {
                  if(!howmorkList[index].type.toString().toLowerCase().contains('link'))
                    {
                      downloadFile(howmorkList[index].link.toString(),
                          howmorkList[index]. name.toString());
                    }
                  else
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebView_Login1(howmorkList[index].link.toString()),
                          ));
                    }

                },
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Color(0xffbbc7db))),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    margin:  EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Image(image: AssetImage("images/pdf123.png")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(howmorkList[index].name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Nunito',
                                        fontSize: 16,
                                        color: Colors.black))
                              ]),
                        ),
                        SvgPicture.asset(
                            "images/icons8_download_from_cloud.svg",
                            color: Color(0xffbbc7db)),
                      ],
                    )),
              ),itemCount: howmorkList.length),
            )

          ,
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ),
  );
}

//  method download any file and save
  Future<void> downloadFile(String url, String fileName) async {
      var splitted = fileName.split('.');
      if(splitted.length>=2)
      fileName =splitted[0].toString().split(' ')[0].toString()+'.'+splitted[1].toString();
    openAtta(url, context, fileName);


  }

  void showDialodUplod() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              content: StatefulBuilder(
                builder: (context, setStateBu) {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              // padding: new EdgeInsets.all(8.0),
                              itemCount: file.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  //Display car block

                                  child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(15),
                                          child: Image(
                                              image: AssetImage(
                                                  "images/pdf123.png")),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Text(
                                                      file[index]['name'],
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily: 'Nunito',
                                                          fontSize: 16,
                                                          color:
                                                              Colors.black))),
                                              Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Text(
                                                      file[index]['size']
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily: 'Nunito',
                                                          fontSize: 13,
                                                          color: Color(
                                                              0xff8e8c8c)))),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(15),
                                            child: IconButton(
                                                onPressed: () {
                                                  setStateBu(() {
                                                    setState(() {
                                                      file.removeAt(index);
                                                    });
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ))),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          InkWell(
                            onTap: () async {},
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 10),
                              padding: EdgeInsets.only(left: 10),
                              height: 100,
                              child: DottedBorder(
                                color: Colors.grey,
                                strokeWidth: 3,
                                dashPattern: [10, 6],
                                child: InkWell(
                                  onTap: () async {
                                    var status =
                                        await Permission.storage.request();
                                    if (status.isGranted) {
                                      final result = await FilePicker.platform
                                          .pickFiles(allowMultiple: true);
                                      if (result == null) return;
                                      Map<String, dynamic> data = {};

                                      for (int i = 0; i < result.count; i++) {
                                        data['name'] = result.files[i].name;
                                        data['size'] = result.files[i].size;
                                        data['file'] = base64Encode(
                                            File(result.files[i].path!)
                                                .readAsBytesSync());
                                        data['base_url'] =
                                            CacheHelper.getBoolean(
                                                key: 'base_url');
                                        setStateBu(() {
                                          setState(() {
                                            file.add(data);
                                            if (file.length > 0)
                                              flg = true;
                                            else
                                              flg = false;
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
                                        SvgPicture.asset(
                                          "images/group8555.svg",
                                          color: Color(0xff98aac9),
                                        ),
                                        Text('Upload file here'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20),

                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width / 2,
                            // color: Colors.orange,
                            child: MaterialButton(
                                child: Text(
                                  'CONFIRM',
                                  style: TextStyle(color: Colors.white),
                                ),
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
                },
              ),
            ));
  }
}
