import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:udemy_flutter/localizations.dart';
import 'package:udemy_flutter/models/innerWeeklyPlans.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/method.dart';
import 'package:udemy_flutter/modules/cubit/cubit.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:dio/dio.dart';
import 'package:udemy_flutter/modules/home/new_home.dart';
import 'package:udemy_flutter/modules/modulesOdoo/allWeekPlans.dart';
import 'package:udemy_flutter/modules/notification/filter_subject.dart';
import 'package:udemy_flutter/shared/components/customWidget.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class WeeklyPlans extends StatefulWidget {
  String std_id;
  String plan_id;
  String plan_name;

  WeeklyPlans(
      {required this.std_id, required this.plan_name, required this.plan_id});

  @override
  State<WeeklyPlans> createState() => _WeeklyPlansState();
}

class _WeeklyPlansState extends State<WeeklyPlans>
    with SingleTickerProviderStateMixin {
  // List colors=[Color(0xff3c92d0),Color(0xffe84314),Color(0xff7cb13b)];
  List colors = [Color(0xfff9a200), Color(0xfff9a200), Color(0xfff9a200)];
  Random random = new Random();
  ReceivePort _port = ReceivePort();
  List<Widget> student = [];
  static List<Tab> myTabs = <Tab>[];
  static List day_week = [];
  static List day_week_color = [];
  TextEditingController search = TextEditingController();
  List<Lines> list_Ass_Search = [];
  static List day_name = [];
  static List day_num = [];
  bool flg = false;

  @override
  void initState() {
    // TODO: implement initState
    myTabs.clear();
    day_week.clear();
    myTabs = AppCubit.day;
    day_week = AppCubit.day_week;
    day_name = AppCubit.day_name;
    day_num = AppCubit.day_num;
    onSearchTextChanged();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    day_week_color.clear();
    day_week_color = AppCubit.day_week_color;

    _port.listen((dynamic data) {
      String id = data[0];

      setState(() {});
    });

    // FlutterDownloader.registerCallback(downloadCallback);
    super.initState();
  }

  onSearchTextChanged() async {
    list_Ass_Search.clear();

    setState(() {
      day_week = AppCubit.day_week;
    });
    if (AppCubit.filter_subject.length <= 0) {
      setState(() {});
      return;
    }
    AppCubit.list_innerWeekly.forEach((element) {
      if (AppCubit.filter_subject.contains(element.subjectName.toString())) {
        list_Ass_Search.add(element);
      }
    });
    if (list_Ass_Search.isEmpty) {
      flg = true;
    } else {
      flg = false;
    }
    setState(() {});
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
    setState(() {
      day_name = AppCubit.day_name;
      day_num = AppCubit.day_num;
      // AppCubit. day_name=day_name;
      // AppCubit.day_num=day_num;
    });
    return BlocProvider(
      create: (context) => AppCubit()
        ..getWeeklePlan(widget.std_id, widget.plan_id, widget.plan_name),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (context, state) {
          return DefaultTabController(
            length: myTabs.length,
            // The Builder widget is used to have a different BuildContext to access
            // closest DefaultTabController.
            child: Builder(builder: (BuildContext context) {
              final TabController? tabController =
                  DefaultTabController.of(context);
              tabController?.addListener(() {
                if (!tabController.indexIsChanging) {
                  // Your code goes here.
                  // To get index of current tab use tabController.index
                }
              });
              return Scaffold(
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
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 100,
                  backgroundColor: Color(0xff3c92d0),
                  leadingWidth: double.infinity / 4,
                  leading: Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 20, bottom: 10, right: 0),
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
                                          AllWeeklyPlans(std_id: AppCubit.std),
                                    ),
                                  );
                                }
                              },
                              icon: SvgPicture.asset(
                                  "images/chevron_left_solid.svg",
                                  color: Colors.white),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // child: Text("ufuufufufufufu"),
                              child: Text(widget.plan_name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 20, bottom: 10, right: 20),
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
                                size: 8.w, color: Colors.white),
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
                body: SingleChildScrollView(
                  child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xff3c92d0),
                          Color(0xff3c92d0),
                        ],
                      )),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              // alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(15)),
                              // color: Colors.white10,
                              width: double.infinity,
                              height: 70,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // day_week_color.clear();

                                      for (int i = 0;
                                          i < day_week.length;
                                          i++) {
                                        setState(() {
                                          if (i == index) {
                                            setState(() {
                                              day_name.clear();
                                              day_num.clear();
                                              day_num.add(index);

                                              day_name.add(
                                                  day_week[index].toString());
                                              day_week_color[i] = ({
                                                'color': Color(0xfff9a200),
                                                'sta': true
                                              });
                                            });
                                          } else {
                                            day_week_color[i] = ({
                                              'color': Colors.transparent,
                                              'sta': false
                                            });
                                          }
                                        });
                                        // print("ddddd");
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,

                                      // color: Colors.yellowAccent,
                                      decoration: BoxDecoration(
                                          color: day_week_color[index]['color'],
                                          borderRadius:
                                              BorderRadius.circular(36)),
                                      width: 40,
                                      // height: 100,
                                      margin: EdgeInsets.only(
                                          left: CacheHelper.getBoolean(
                                                      key: 'lang')
                                                  .toString()
                                                  .contains('ar')
                                              ? 0
                                              : 20,
                                          top: 16,
                                          bottom: 10,
                                          right: CacheHelper.getBoolean(
                                                      key: 'lang')
                                                  .toString()
                                                  .contains('ar')
                                              ? 20
                                              : 0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 15),
                                          Text(AppLocalizations.of(context).translate(day_week[index].toString().toLowerCase()),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize:  CacheHelper.getBoolean(key: 'lang').toString().contains('ar')
                                                  ? 10
                                                  : 12,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Nunito',
                                              )),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: day_week.length,
                                shrinkWrap: true,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            7.2),
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.width /
                                            7.2),
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 5.w, right: 5.w, top: 15),
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Filter_odoo_subject(
                                                      page: 'week'),
                                            ));
                                      },
                                      icon: SvgPicture.asset(
                                        "images/filter11.svg",
                                        color: Color(0xff98aac9),
                                        width: 6.w,
                                      ),
                                      color: Color(0xff98aac9),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 15, right: 15),
                                      child: AppCubit.list_innerWeekly.length >
                                              0
                                          ? list_Ass_Search.length > 0
                                              ? ListView.builder(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          allWeekly(
                                                              index,
                                                              day_name[0],
                                                              list_Ass_Search[
                                                                  index]),
                                                  itemCount:
                                                      list_Ass_Search.length,
                                                  shrinkWrap: true,
                                                )
                                              : ListView.builder(
                                                  itemBuilder: (context,
                                                          index) =>
                                                      allWeekly(
                                                          index,
                                                          day_name[0],
                                                          AppCubit.list_innerWeekly[
                                                              index]),
                                                  itemCount: AppCubit
                                                      .list_innerWeekly.length,
                                                  shrinkWrap: true,
                                                )
                                          : emptyAss(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              );
            }),
          );
        },
        listener: (context, state) {},
      ),
    );
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
              builder: (context) => AllWeeklyPlans(
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

  Widget allWeekly(int index, String day, Lines ass) {
    int index = 0;
    index = random.nextInt(3);
    AppCubit.subject_odoo.add(ass.subjectName.toString());
    AppCubit.subject_odoo = AppCubit.subject_odoo.toSet().toList();
    if (ass.attachments!.length != 0) {
      if ((day.toLowerCase() == 'sunday' || day.toLowerCase() == 'sun') &&
          ass.sunday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(), ass.sunday.toString(),
            ass.notes.toString(), ass.attachments!);
      }
      if ((day.toLowerCase() == 'saturday' || day.toLowerCase() == 'sat') &&
          ass.saturday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(),
            ass.saturday.toString(), ass.notes.toString(), ass.attachments!);
      }
      if ((day.toLowerCase() == 'monday' || day.toLowerCase() == 'mon') &&
          ass.monday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(), ass.monday.toString(),
            ass.notes.toString(), ass.attachments!);
      }
      if ((day.toLowerCase() == 'thursday' || day.toLowerCase() == 'thu') &&
          ass.thursday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(),
            ass.thursday.toString(), ass.notes.toString(), ass.attachments!);
      }
      if ((day.toLowerCase() == 'wednesday' || day.toLowerCase() == 'wed') &&
          ass.wednesday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(),
            ass.wednesday.toString(), ass.notes.toString(), ass.attachments!);
      }
      if ((day.toLowerCase() == 'friday' || day.toLowerCase() == 'fri') &&
          ass.friday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(), ass.friday.toString(),
            ass.notes.toString(), ass.attachments!);
      }
      if ((day.toLowerCase() == 'tuesday' || day.toLowerCase() == 'tue') &&
          ass.tuesday.toString().isNotEmpty) {
        return getCard(index, ass.subjectName.toString(),
            ass.tuesday.toString(), ass.notes.toString(), ass.attachments!);
      }
    } else {
      if ((day.toLowerCase() == 'sunday' || day.toLowerCase() == 'sun') &&
          ass.sunday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.sunday.toString(), ass.notes.toString());
      }
      if ((day.toLowerCase() == 'saturday' || day.toLowerCase() == 'sat') &&
          ass.saturday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.saturday.toString(), ass.notes.toString());
      }
      if ((day.toLowerCase() == 'monday' || day.toLowerCase() == 'mon') &&
          ass.monday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.monday.toString(), ass.notes.toString());
      }
      if ((day.toLowerCase() == 'thursday' || day.toLowerCase() == 'thu') &&
          ass.thursday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.thursday.toString(), ass.notes.toString());
      }
      if ((day.toLowerCase() == 'wednesday' || day.toLowerCase() == 'wed') &&
          ass.wednesday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.wednesday.toString(), ass.notes.toString());
      }
      if ((day.toLowerCase() == 'friday' || day.toLowerCase() == 'fri') &&
          ass.friday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.friday.toString(), ass.notes.toString());
      }
      if ((day.toLowerCase() == 'tuesday' || day.toLowerCase() == 'tue') &&
          ass.tuesday.toString().isNotEmpty) {
        return getCard_notAtt(index, ass.subjectName.toString(),
            ass.tuesday.toString(), ass.notes.toString());
      }
    }
    return Visibility(visible: false, child: Text(''));
  }

  //get design Weekly plan with attachments
  Widget getCard(int index_color, String subjectName, String subject_note,
      String notes, List<Attachments> attachments) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: colors[(index_color / 3).floor().toInt()]
                        .withOpacity(.1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: .8,
                              color: colors[(index_color / 3).floor().toInt()]
                                  .withOpacity(.4)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor:
                              colors[(index_color / 3).floor().toInt()]
                                  .withOpacity(.4),
                          child: SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Weekly+Plans.svg',
                            color: colors[(index_color / 3).floor().toInt()],
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                    Text(subjectName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontSize: 22,
                            color: colors[(index_color / 3).floor().toInt()])),
                    // SizedBox(width: 40,),
                    Expanded(
                      child: Container(
                        alignment:CacheHelper.getBoolean(key: 'lang').toString().contains('ar')?Alignment.centerLeft: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () async {
                              // Dio dio =Dio();
                              for (int i = 0; i < attachments.length; i++) {
                                String fileName =
                                    attachments[i].name.toString();
                                String url = attachments[i].datas.toString();
                                downloadFile(url, fileName);
                                // Directory? directory;
                                // try {
                                // if (Platform.isIOS) {
                                // directory = await getApplicationDocumentsDirectory();
                                // } else {
                                //
                                // directory = Directory('/storage/emulated/0/Download/');
                                // // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
                                // // ignore: avoid_slow_async_io
                                // if (!await directory.exists()) directory = await getExternalStorageDirectory();
                                // }
                                // } catch (err, stack) {
                                // print("Cannot get download folder path");
                                // }
                                // print("-------");
                                // print(directory!.path);
                                // directory.create();
                                // await dio.download(url,directory.path+fileName ,onReceiveProgress: (count, total) {
                                // print(((count/total)*100).toStringAsFixed(0)+"%");
                                // },).then((value){
                                //
                                // print("pppppppppppswwww");
                                // });
                                // GallerySaver.saveImage("${directory.path}$fileName");
                              }
//
// final path=await _getFilePath(fileName);
// Dio dio =Dio();
// var status = await Permission.storage.request();
// if (status.isGranted) {
//   // We didn't ask for permission yet or the permission has been denied before but not permanently.
//   final appDocDir = await getExternalStorageDirectory();
//   String appDocPath = appDocDir!.path;
//   String p='';
//   // var e=await getApplicationDocumentsDirectory();
//   // print(e.path+Platform.pathSeparator+'Download');
//   // // print(e);
//   // var ee=Directory(e.path+Platform.pathSeparator+'Download');
//   if(Platform.isAndroid){
//
//
//   final  downloadsDirectory = await DownloadsPathProvider.downloadsDirectory ;
//
//   print(downloadsDirectory!.path);
//
//  if(downloadsDirectory.path.toString().isNotEmpty)
//    {
//      p=downloadsDirectory.path;
//    }
//  else
//    {
//      p=appDocPath;
//    }
//
//   }
//   else{
//     p=(await getApplicationDocumentsDirectory()).absolute.path;
//   }
//
//   final taskId = await FlutterDownloader.enqueue(
//     url:url,
//     fileName:fileName ,// 'your download link',
//      savedDir:p,// 'the path of directory where you want to save downloaded files',
//     showNotification: true, // show download progress in status bar (for Android)
//     openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//   );
//   await dio.download(url, e.path+Platform.pathSeparator+'Download',onReceiveProgress: (count, total) {
//     print(((count/total)*100).toStringAsFixed(0)+"%");
//   },).then((value){
//     print("pppppppppppswwww");
//   });
// }
//
//
//
//
//
//                             }
                            },
                            icon: SvgPicture.asset(
                              "images/group8555.svg",
                              color: Color(0xff98aac9),
                              width: 20,
                            )),
                      ),
                    )
                  ],
                )),
            // Container
            //   (
            //     margin: EdgeInsets.symmetric(horizontal: 18),
            //     alignment: Alignment.centerLeft,
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     child: Text('Subject note', style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontFamily: 'Nunito',
            //         fontSize: 18,
            //         color: Colors.black))),

            Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(subject_note,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        color: Colors.black))),
            Divider(color: Colors.black.withOpacity(.2), thickness: 1),
            Container(
                width: double.infinity,
                // decoration: BoxDecoration(color: Colors.grey[100],
                //     borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(20),
                //         bottomRight: Radius.circular(20))),
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(notes,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        color: Colors.black))),
          ],
        ),
      ),
    );
  }

  //get design Weekly plan without attachments
  Widget getCard_notAtt(
      int index_color, String subjectName, String subject_note, String notes) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: colors[(index_color / 3).floor().toInt()]
                        .withOpacity(.1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                // alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: .8,
                              color: colors[(index_color / 3).floor().toInt()]
                                  .withOpacity(.4)),
                          borderRadius:
                              BorderRadius.all(Radius.circular(50.0))),
                      elevation: 0.0,
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor:
                              colors[(index_color / 3).floor().toInt()]
                                  .withOpacity(.4),
                          child: SvgPicture.network(
                            'https://trackware-schools.s3.eu-central-1.amazonaws.com/flutter_app/Weekly+Plans.svg',
                            color: colors[(index_color / 3).floor().toInt()],
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(subjectName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Nunito',
                            fontSize: 22,
                            color: colors[(index_color / 3).floor().toInt()])),
                    // Text(subjectName, style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontFamily: 'Nunito',
                    //     fontSize: 22,
                    //     color: Colors.white)),
                  ],
                )),
            // Container
            //   (
            //     margin: EdgeInsets.symmetric(horizontal: 18),
            //     alignment: Alignment.centerLeft,
            //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     child: Text('Subject note', style: TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontFamily: 'Nunito',
            //         fontSize: 18,
            //         color: Colors.black))),

            Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(subject_note,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        color: Colors.black))),
            Divider(color: Colors.black.withOpacity(.2), thickness: 1),
            Container(
                width: double.infinity,

                // decoration: BoxDecoration(color: Colors.grey[100],
                //     borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(20),
                //         bottomRight: Radius.circular(20))),
                // alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(notes,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        color: Colors.black))),
          ],
        ),
      ),
    );
  }

  Future<bool> _requestWrritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<void> downloadFile(String url, String fileName) async {
    var url1 = Uri.parse(url);
    print(url1);


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

      // String fileName=attachments[i].name.toString();

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
        print("Cannot get download folder path");
      }

      directory!.create();
      await dio
          .download(
        url,
        directory.path + fileName,
        onReceiveProgress: (count, total) {},
      )
          .then((value) async {
        var url1 = Uri.parse(url);

        if (Platform.isIOS && await canLaunchUrl(url1)) {
          await launch(url);
        } else {
          OpenFile.open(directory!.path + fileName)
              .then((value) {})
              .onError((error, stackTrace) {});
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

  Widget emptyAss() {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 40),
              child: Image(
                image: AssetImage("images/no_weekly_plans_1.png"),
                width: 293,
                height: 239,
              ),
            ),
          ),
          Expanded(
              child: Text("No Weekly Plan added",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                      color: Color(0xff3c92d0))))
        ]),
      ),
    );
  }
}
