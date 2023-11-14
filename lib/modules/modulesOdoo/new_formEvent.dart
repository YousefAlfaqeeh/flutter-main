import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:udemy_flutter/models/modelEvent.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allEvents.dart';
import 'package:udemy_flutter/modules/modulesOdoo/new_allEvent.dart';
import 'package:udemy_flutter/modules/studet_details/new_detail.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class FormEvents_new extends StatefulWidget {
  String std_id;

  FormEvents_new({required this.std_id});

  @override
  State<FormEvents_new> createState() => _FormEvents_newState();
}

class _FormEvents_newState extends State<FormEvents_new> {
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
        student.add(student_list(i, AppCubit.list_st[i]));
      });
    }
    return BlocProvider(
      create: (context) =>
          AppCubit()..getFormEvent(widget.std_id, AppCubit.std),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 20.w,
              backgroundColor: Colors.white,
              leadingWidth: double.infinity / 4,
              leading: Padding(
                padding:
                    EdgeInsets.only(left: 2, top: 20, bottom: 10, right: 0),
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
                            if (AppCubit.back_home) {
                              AppCubit.back_home = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hiome_Kids()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        New_AllEvents(std_id: AppCubit.std)),
                              );
                            }
                          },
                          icon: SvgPicture.asset("images/chevron_left_solid.svg",
                              color: Color(0xff98aac9)),
                        ),
                      ),
                      Container(
                        // child: Text("ufuufufufufufu"),
                        child: Text(
                            AppLocalizations.of(context).translate('events'),
                            style: TextStyle(
                                color: Color(0xff3c92d0),
                                fontSize: 26,
                                fontWeight: FontWeight.bold)),
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
                        maxRadius: 6.w,
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
                            size: 8.w, color: Color(0xff98aac9)),
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
                          formEvent(AppCubit.list_Event[index]),
                      itemCount: AppCubit.list_Event.length,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  //get design  form event
  Widget formEvent(ResultEvent ass) {
    DateTime dt1 = DateFormat('dd MMM yyyy').parse(ass.startDate.toString());
    var formatter = DateFormat.yMMMd('ar_SA');
    String formatted = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.startDate.toString();
    dt1 = DateFormat('dd MMM yyyy').parse(ass.registrationStartDate.toString());
    String registrationStartDate = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.registrationStartDate.toString();
    //  ass.registrationLastDate.toString()
    dt1 = DateFormat('dd MMM yyyy').parse(ass.registrationLastDate.toString());
    String registrationLastDate = CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?formatter.format(dt1):ass.registrationLastDate.toString();
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Card(
              child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 6, top: 12, right: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                    // side: BorderSide(width: .8,color: Color(0xffd4ddee)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(50.0))),
                                elevation: 0.0,
                                child: Container(
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Color(0xff3c92d0).withOpacity(.2),
                                    child: SvgPicture.network(
                                      'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Events.svg',
                                      color: Color(0xff3c92d0),
                                      width: 22,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(ass.state.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontFamily: 'Nunito',
                                                  fontSize: 12,
                                                  color: Color(0xff98aac9)))),
                                      Visibility(
                                        visible: ass.newAdded == 'True',
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          padding: EdgeInsets.only(right: 5),
                                          child: Container(
                                              width: 60,
                                              height: 5.w,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(3)),
                                                  color: Color(0xfff9a200)),
                                              child: Text(
                                                  AppLocalizations.of(context)
                                                      .translate('New'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Nunito',
                                                      fontSize: 14,
                                                      color: Colors.white))),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Container(
                                      // alignment: Alignment.topLeft,
                                      child: Text(ass.name.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Nunito',
                                              fontSize: 18,
                                              color: Color(0xff000000)))),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)
                                              .translate('Date'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                              color: Color(0xff000000))),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Expanded(
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Text(
                                                  formatted,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: 'Nunito',
                                                      fontSize: 16,
                                                      color:
                                                          Color(0xff4a4a4a))))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: ass.link.toString().isNotEmpty,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          // width: 150,
                          child: InkWell(
                              onTap: () {
                                if (ass.link.toString().isNotEmpty) {
                                  downloadFile(
                                      ass.link.toString(), ass.name.toString());
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border:
                                          Border.all(color: Color(0xffbbc7db))),

                                  // margin: EdgeInsets.all(30),

                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      Image(
                                          image:
                                              AssetImage("images/pdf123.png")),
                                      // SvgPicture.asset("images/pdf.svg"),
                                      // Icon(Icons.cloud_download,),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(ass.eventName.toString(),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Nunito',
                                                      fontSize: 16,
                                                      color: Colors.black))
                                            ]),
                                      ),
                                      SvgPicture.asset(
                                          "images/icons8_download_from_cloud.svg",
                                          color: Color(0xffbbc7db)),
                                    ],
                                  ))),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  )),
            ),
            //Registation
            InkWell(
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          // alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('registration'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                  color: Color(0xff3c92d0)))),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('Start_date'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Color(0xff000000)))),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15.0),
                          //   child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                          // ),

                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                      registrationStartDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Color(0xff4a4a4a))))),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('End_date'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Color(0xff000000)))),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 22.0),
                          //   child: Icon(Icons.calendar_today,color: Color(0xff3c92d0),size: 25,),
                          // ),

                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                      registrationLastDate,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Color(0xff4a4a4a))))),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //Participant
            InkWell(
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          // alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('participant'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                  color: Color(0xff3c92d0)))),
                      Row(
                        children: [
                          Container(
                              // margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('maximum_Participant'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Color(0xff000000)))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Text(
                                      ass.maximumParticipants.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Color(0xff4a4a4a))))),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              // margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('available_Seats'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Color(0xff000000)))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 10),
                                  child: Text(ass.availableSeats.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Color(0xff4a4a4a))))),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              // margin: EdgeInsets.only(left: 30),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate('participant_Cost'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Nunito',
                                      fontSize: 14,
                                      color: Colors.black))),
                          Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 45, vertical: 10),
                                  child: Text(ass.cost.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Colors.black)))),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //contact
            InkWell(
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          // color: Colors.red,
                          // alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                              AppLocalizations.of(context).translate('contact'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                  color: Color(0xff3c92d0)))),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              maxRadius: 20,
                              backgroundImage: NetworkImage(
                                '${ass.contactImage.toString()}',
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      // alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: Text(ass.contactName.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Nunito',
                                              fontSize: 14,
                                              color: Color(0xff000000)))),
                                  Container(
                                      // alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: Text(
                                          AppLocalizations.of(context)
                                              .translate('teacher'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontFamily: 'Nunito',
                                              fontSize: 12,
                                              color: Color(0xff98aac9)))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Attachments
            InkWell(
              child: Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3)),
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          // alignment: Alignment.centerLeft,
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate('Attachments'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito',
                                  fontSize: 20,
                                  color: Color(0xff3c92d0)))),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(left: 10, right: 20),
                          itemCount: file.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              //Display car block

                              child: Container(
                                margin: EdgeInsets.only(bottom: 10),
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
                                                if (file.length > 0) {
                                                  file.removeAt(index);

                                                  if (file.length > 0) {
                                                    flg = true;
                                                  } else {
                                                    flg = true;
                                                  }
                                                } else {
                                                  flg = true;
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
                          padding: EdgeInsets.only(left: 10, right: 20),
                          height: 60,
                          child: DottedBorder(
                            radius: Radius.circular(10),
                            color: Color(0xffbbc7db),
                            strokeWidth: 1,
                            dashPattern: [10, 2],
                            child: InkWell(
                              onTap: () async {
                                var status = await Permission.storage.request();
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
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            //CONFIRM
            Visibility(
              visible: ass.state == "draft",
              child: Container(
                alignment: Alignment.center,
                // width: 300,

                child: InkWell(
                    onTap: () async {
                      Map data = {};
                      try {
                        data['file'] = file;
                      } catch (e) {
                        data['file'] = [];
                      }
                      data['student_id'] = AppCubit.std;
                      data['wk_id'] = ass.eventId;
                      data['session'] =
                          CacheHelper.getBoolean(key: 'sessionId');
                      data['base_url'] =
                          CacheHelper.getBoolean(key: 'base_url');

                      var responseSettings = await DioHelper.uplodeData(
                              url: Post_Event,
                              data: data,
                              token:
                                  CacheHelper.getBoolean(key: 'authorization'))
                          .then(
                        (value) {
                          setState(() {
                            flg = false;
                            file = [];
                            AppCubit()
                              ..getFormEvent(widget.std_id, AppCubit.std);
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (_) => AlertDialog(
                                      elevation: 1,
                                      shadowColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      actions: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              alignment: Alignment.center,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FormEvents_new(
                                                                      std_id: ass
                                                                          .eventId
                                                                          .toString())),
                                                        );
                                                      },
                                                      icon: Container(
                                                          width: 13.58,
                                                          height: 22.37,
                                                          child: Icon(
                                                              Icons.dangerous,
                                                              color: Color(
                                                                  0xff98aac9)))),
                                                ],
                                              ),
                                            ),
                                            // SizedBox(height: 10,),
                                            Container(
                                                child: Image(
                                                    image: AssetImage(
                                                        "images/confirmed_the_event.png"))),
                                            Container(
                                              alignment: Alignment.center,
                                              // padding: EdgeInsets.only(left: 20),
                                              width: double.infinity,
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'SUCCESSFULLY_CONFIRMED'),textAlign:TextAlign.center,
                                                style: TextStyle(

                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff3c92d0)),
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              // padding: EdgeInsets.only(left: 20),
                                              width: double.infinity,
                                              child: Text(
                                                AppLocalizations.of(context)
                                                    .translate(
                                                        'confirmed_the_event'),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'Nunito',
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xff3c92d0)),
                                              ),
                                            ),

                                            SizedBox(
                                              height: 10,
                                            ),

                                            // Container(alignment: Alignment.center,
                                            //   width: double.infinity,
                                            //   child:  TextButton(onPressed: () {
                                            //     Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(builder: (context) => AllEvents(std_id:AppCubit.std)),);
                                            //   },child: Text("Back to event page",style: TextStyle(fontSize: 12,decoration: TextDecoration.underline,fontWeight: FontWeight.normal,color:Color(0xff3c92d0) ),)),),
                                          ],
                                        )
                                      ],
                                    ));
                          });
                        },
                      ).catchError((onError) {
                        // print(onError);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff3c92d0)),
                        height: 60,
                        margin:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //
                            //
                            //     padding: EdgeInsets.all(15),
                            //     child: Icon(Icons.check_circle,color: Colors.white,)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('CONFIRM'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Tajawal',
                                    fontSize: 15,
                                    color: Colors.white)),
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
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: Color(0xff3c92d0)),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        height: 60,
                        margin: EdgeInsets.only(
                            top: 5, left: 20, right: 20, bottom: 20),
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //
                            //
                            //     padding: EdgeInsets.all(15),
                            //     child: Icon(Icons.dangerous_outlined,color: Colors.black,)),
                            Text(
                                AppLocalizations.of(context)
                                    .translate('DECLINE'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Tajawal',
                                    fontSize: 15,
                                    color: Color(0xff3c92d0))),
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
  Future<bool> _requestWrritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

//  method download any file and save
  Future<void> downloadFile(String url, String fileName) async {
    var url1 = Uri.parse(url);

    if (Platform.isIOS) {
      if (await canLaunchUrl(url1)) {
        // print(CacheHelper.getBoolean(key: 'sessionId'));
        // await launchUrl(url);
        await launch(url.toString(), headers: {
          "X-Openerp-Session-Id": CacheHelper.getBoolean(key: 'sessionId')
        });
      }
      // FlutterDownloader.enqueue(url: url, savedDir: directory!.path ,showNotification: true,openFileFromNotification: true);
      // await launch(url);
    }
    bool hasPermission = await _requestWrritePermission();

    if (hasPermission) {
      Dio dio = Dio();
      //
      //   // String fileName=attachments[i].name.toString();
      //
      Directory? directory;
      try {
        if (Platform.isIOS) {
          directory = await getApplicationDocumentsDirectory();
        } else {
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
        url,
        directory.path + fileName,
        onReceiveProgress: (count, total) {
          // print(count / total * 100);
        },
      ).then((value) async {
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

        OpenFile.open(directory!.path + fileName)
            .then((value) {})
            .onError((error, stackTrace) {});
        // }
      }).catchError((onError) {});

      GallerySaver.saveImage("${directory.path}$fileName")
          .then((value) {})
          .onError((error, stackTrace) {
        GallerySaver.saveVideo("${directory!.path}$fileName")
            .then((value) {})
            .onError((error, stackTrace) => null);
      });
    }
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
                                                    "images/pdf123.png"))
                                            // SvgPicture.asset("images/pdf.svg")
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
                                                icon: SvgPicture.asset(
                                                    "images/icons8_delete12.svg",
                                                    color: Color(0xffbbc7db)))),
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
                                        Icon(Icons.cloud_upload,
                                            color: Colors.grey),
                                        Text(AppLocalizations.of(context)
                                            .translate('Upload_file_here')),
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
                                  AppLocalizations.of(context)
                                      .translate('CONFIRM'),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  setStateBu(() {
                                    setState(() {
                                      flg = true;
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
                },
              ),
            ));
  }

  void showDialodDelete(String eventId) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              content: StatefulBuilder(
                builder: (context, setStateBu) {
                  return Container(
                    child: SingleChildScrollView(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Event",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nunito',
                                          fontSize: 24,
                                          color: Color(0xff3c92d0)))),
                              // Expanded(
                              //   child: Container(alignment: Alignment.centerRight,
                              //     margin: EdgeInsets.only(right: 20),
                              //     padding: EdgeInsets.all(8),child: InkWell(onTap: () {
                              //       Navigator.pop(context);
                              //     },child: SvgPicture.asset("images/times_solid.svg")),),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              child:
                                  Image(image: AssetImage('images/dec.png'))),
                          Container(
                              // alignment: Alignment.center,
                              child: Text(
                                  AppLocalizations.of(context).translate(
                                      'Are_you_sure_you_want_to_decline_the_event'),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,

                                      fontFamily: 'Nunito',
                                      fontSize: 20,
                                      color: Colors.black))),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20,right: 20),

                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width / 2,
                            // color: Colors.orange,
                            child: MaterialButton(
                                child: Text(
                                  AppLocalizations.of(context).translate('yes'),
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () async {
                                  Map data = {};
                                  data['wk_id'] = eventId;
                                  var responseSettings =
                                      await DioHelper.uplodeData(
                                              url: Cancel_Event,
                                              data: data,
                                              token: CacheHelper.getBoolean(
                                                  key: 'authorization'))
                                          .then(
                                    (value) {
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18)),
                                                content: StatefulBuilder(
                                                  builder:
                                                      (context, setStateBu) {
                                                    return Container(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                // Container(alignment: Alignment.centerLeft,child:Text("Event",style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Nunito',fontSize: 24,color:Color(0xff3c92d0)))) ,
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerRight,
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            20),
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(8),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // Navigator.pop(context);
                                                                      },
                                                                      child: IconButton(
                                                                          onPressed: () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(builder: (context) => FormEvents_new(std_id: eventId)),
                                                                            );
                                                                          },
                                                                          icon: Container(width: 13.58, height: 22.37, child: Icon(Icons.dangerous, color: Color(0xff98aac9)))),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),

                                                            Container(
                                                                child: Image(
                                                                    image: AssetImage(
                                                                        'images/dec.png'))),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              width: double
                                                                  .infinity,
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)
                                                                    .translate(
                                                                        'You_have_successfully'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Color(
                                                                        0xff3c92d0)),
                                                              ),
                                                            ),
                                                            // Container(
                                                            //   alignment:
                                                            //       Alignment
                                                            //           .center,
                                                            //   padding: EdgeInsets
                                                            //       .only(
                                                            //           left: 20),
                                                            //   width: double
                                                            //       .infinity,
                                                            //   child: Text(
                                                            //     AppLocalizations.of(
                                                            //             context)
                                                            //         .translate(
                                                            //             'Declined_the_event'),
                                                            //     style: TextStyle(
                                                            //         fontSize:
                                                            //             16,
                                                            //         fontWeight:
                                                            //             FontWeight
                                                            //                 .bold,
                                                            //         color: Color(
                                                            //             0xff3c92d0)),
                                                            //   ),
                                                            // ),

                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            // Container(
                                                            //   alignment: Alignment.center,
                                                            //   margin: const EdgeInsets.only(left: 20),
                                                            //
                                                            //   decoration: BoxDecoration(
                                                            //       color: Colors.green,
                                                            //       borderRadius: BorderRadius.circular(20)),
                                                            //   width:MediaQuery.of(context).size.width/2,
                                                            //   // color: Colors.orange,
                                                            //   child: MaterialButton(
                                                            //       child: Text('Yes',style: TextStyle(color: Colors.white),),
                                                            //       onPressed: () async {
                                                            //         Map data={};
                                                            //         data['wk_id']=eventId;
                                                            //         var responseSettings = await DioHelper.uplodeData(
                                                            //             url: Cancel_Event,
                                                            //             data: data,
                                                            //             token: CacheHelper.getBoolean(key: 'authorization'))
                                                            //             .then((value) {
                                                            //
                                                            //           Navigator.push(
                                                            //             context,
                                                            //             MaterialPageRoute(builder: (context) => FormEvents_new(std_id: eventId)),);
                                                            //
                                                            //
                                                            //
                                                            //         },).catchError((onError) {
                                                            //
                                                            //         });
                                                            //
                                                            //
                                                            //
                                                            //       }
                                                            //     // },
                                                            //   ),
                                                            // ),
                                                            // Container(
                                                            //   alignment: Alignment.center,
                                                            //   margin: const EdgeInsets.only(left: 20),
                                                            //
                                                            //   decoration: BoxDecoration(
                                                            //       color: Colors.white,
                                                            //       borderRadius: BorderRadius.circular(20)),
                                                            //   width:MediaQuery.of(context).size.width/2,
                                                            //   // color: Colors.orange,
                                                            //   child: MaterialButton(
                                                            //       child: Text('No',style: TextStyle(color: Colors.black),),
                                                            //       onPressed: () async {
                                                            //
                                                            //
                                                            //         Navigator.pop(context);
                                                            //
                                                            //
                                                            //       }
                                                            //     // },
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ));
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => FormEvents_new(std_id: eventId)),);
                                    },
                                  ).catchError((onError) {});
                                }
                                // },
                                ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 20,right: 20),

                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            width: MediaQuery.of(context).size.width / 2,
                            // color: Colors.orange,
                            child: MaterialButton(
                                child: Text(
                                  AppLocalizations.of(context).translate('no'),
                                  style: TextStyle(color: Colors.black),
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

  Widget student_list(int ind, Students listDetail1) {
    List<Features> listFeatures1 = [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          AppCubit.stutes_notif_odoo = '';
          AppCubit.school_image = listDetail1.schoolImage.toString();
          listFeatures1.clear();
          // if(listDetail1.changeLocation=true)
          // {
          //
          //   listFeatures1.add( Features(name:  AppLocalizations.of(context).translate('chang_home_location'), icon: 'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Assignments.svg',nameAr: AppLocalizations.of(context).translate('chang_home_location')));
          //
          // }

          listDetail1.features!.forEach((element) {
            listFeatures1.add(element);
          });

          AppCubit.get(context).setDetalil(
              listDetail1.name,
              listDetail1.studentGrade ?? "",
              listDetail1.schoolName,
              listDetail1.avatar,
              listDetail1.id.toString(),
              listDetail1.schoolLat,
              listDetail1.schoolId.toString(),
              listDetail1.schoolLng,
              listDetail1.pickupRequestDistance.toString(),
              listFeatures1);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => New_AllEvents(
                std_id: listDetail1.id.toString(),
              ),
            ),
          );
        },
        child: Row(children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            maxRadius: 5.w,
            backgroundImage: NetworkImage(
              '${listDetail1.avatar}',
            ),
          ),
          SizedBox(
            height: 10,
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${listDetail1.fname}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    fontSize: 9),
              ),
              Text(
                "${AppCubit.grade}",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Nunito',
                    fontSize: 9),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
