import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:udemy_flutter/models/Allergies.dart';
import 'package:udemy_flutter/models/absenceRequest.dart';
import 'package:udemy_flutter/models/assModel.dart';
import 'package:udemy_flutter/models/banned_student.dart';
import 'package:udemy_flutter/models/canteen_student.dart';
import 'package:udemy_flutter/models/food_student.dart';
import 'package:udemy_flutter/models/getAllWeeklyPlans.dart';
import 'package:udemy_flutter/models/getAllWorksheet.dart';
import 'package:udemy_flutter/models/history.dart';
import 'package:udemy_flutter/models/innerWeeklyPlans.dart';
import 'package:udemy_flutter/models/item_m.dart';
import 'package:udemy_flutter/models/kidsList.dart';
import 'package:udemy_flutter/models/loginModel.dart';
import 'package:udemy_flutter/models/modelAllEvents.dart';
import 'package:udemy_flutter/models/modelCalendar.dart';
import 'package:udemy_flutter/models/modelClinic.dart';
import 'package:udemy_flutter/models/modelEvent.dart';
import 'package:udemy_flutter/models/modelExam.dart';
import 'package:udemy_flutter/models/modelLibrary.dart';
import 'package:udemy_flutter/models/product.dart';
import 'package:udemy_flutter/models/school_moudle.dart';
import 'package:udemy_flutter/models/settingModels.dart';
import 'package:udemy_flutter/models/subCategory.dart';
import 'package:udemy_flutter/models/timeTable.dart';
import 'package:udemy_flutter/modules/cubit/states.dart';
import 'package:udemy_flutter/modules/modulesOdoo/calendar.dart';

import 'package:udemy_flutter/shared/badgesModel.dart';
import 'package:http/http.dart' as http;
import 'package:udemy_flutter/shared/end_points.dart';
import 'package:udemy_flutter/shared/local/cache_helper.dart';
import 'package:udemy_flutter/models/modelFormWorkSheet.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  static List<Students> list_st = [];
  static late DateTime fromDate;
  static late DateTime fromTo;
  static late MeetingDataSource allMeetings = MeetingDataSource([
    Meeting(
      from: DateTime.now(),
      to: DateTime.now().add(const Duration(hours: 1)),
      eventName: 'No event',
      background: Colors.white,
      isAllDay: true,
    )
  ]);
  static DateTime fromDate_odoo = DateTime.parse("2016-01-01 00:00:00");
  static DateTime fromTo_odoo = DateTime.parse("2035-01-01 00:00:00");
  static late String selectedValue;
  static String student_name = '';
  static bool read = false;
  static bool back_home = false;
  static bool unread = false;
  static bool show_st = true;
  static bool show_ecan = false;
  static String stutes_notif_odoo = '';
  static String stutes_notif_da_odoo = '';
  static String stutes_notif = '';
  static bool filter = false;
  static bool flag_req = false;
  static List file = [];
  static List subject_odoo = [];
  static List filter_subject = [];
  static List<ResultAllWorksheet> list_allWorkSheet = [];
  static List<ResultFormWorkSheet> list_WorkSheet = [];
  static List<ResultEvent> list_Event = [];
  static List<Result> list_clinic = [];
  static List<ResultAss> list_Ass = [];
  static List<ResultProduct> list_Product = [];
  static List<Result_Allergies> result_Allergies = [];
  static List<Spending> spending = [];
  static List<SchduleMeals> schduleMeals = [];
  static List<FoodAllegies> foodAllegies = [];
  static List<ResultAllEvents> list_allEvents = [];
  static List<ResultExam> list_Exam = [];
  static List<ResultBadges> list_Badges = [];
  static List<ResultCalendar> list_calendar = [];
  static List<ResultAllWeeklyPlan> list_allWeekly = [];
  static List<Lines> list_innerWeekly = [];
  static List<AbsenceRequest> absenceRequest = [];
  static List<DailyAttendance> dailyAttendance = [];
  static List<BookRequest> requestBook = [];
  static List<BookBorrowed> borrowedBook = [];
  static List<Menu> menu = [];
  static List<Category> category = [];
  static List<Product> product = [];
  //Menu

  // static List<Result_Allergies> Result_Allergies = [];
  // static List<BookBorrowed> borrowedBook = [];


  //bannedFood
  static String bannedFood = '';
  static String url_3 = '';
  static String url = '';
  static String date = '';
  static String date_odoo = '';
  static String sessionId = '';

  //sessionId
  bool isObscur1 = true;
  static bool isBorrowd = false;
  static Locale? locale;
  String status = '';
  List<School> school_list = [];
  static List<dynamic> school_list1 = [];
  static List<Book> book_list = [];
  static List<DateIte> dateIte = [];
  static List<DataCat> dataCat = [];
  static List<DateItem> dateItem = [];
  //DateIte

  //book_list
  Food_student?food_student;
  Item_model?item_model;
  Kids_list? student;
  ModelExam? modelExam;
  static ModelBadges? modelBadges;
  AllEvent? allEvent;
  Allergies? allergies;
  static Banned_student? banned_student;
  Canteen_Student?canteen_Student;
  Menu_Cat?menu_Cat;
  AllWorksheet? allWorksheet;
  ModelClinic? clinic;
  ModelAss? modelAss;
  AbsenceRequestD? absenceRequestD;
  ModelLibrary? modelLibrary;
  ModelCalendar? modelCalendar;
  AllWeeklyPlan? allWeeklyPlan;
  WorkSheet? workSheet;
  ModelEvents? modelEvents;
  InnerWeeklyPlan? innerWeeklyPlan;
  static List<Lines_time_table> list_tableTime = [];
  TableTime?tableTime;
  SettingModel? settingModel;
  LoginModel? login_info;
  School? data_base, s;
  String db_name = '';
  String start_date = '2022-01-01 01:12:12';
  String end_date = DateTime.now().toString();
  static List<Notifications> list_notif = [];
  static Notification_api? notification;
  static List<Tab> day = <Tab>[
    Tab(text: 'LEFT1'),
  ];
  static List day_week_color = [];
  static List day_name = [];
  static List day_num = [];
  static List day_week = [];
  static String plan_id = '';
  static String plan_name = '';
  static String name = '';
  static String grade = '';
  static String school = '';
  static String image = '';
  static String school_image = '';
  static String std = '';
  static String? school_lat = '';
  static String? school_lng = '';
  static String? distance = '';
  static String? school_id = '';
  static String title_firbase = '';
  static String message_firbase = '';
  static bool flag_firbase = false;
  String std_id = '';
  static List<Features> listdetail = [];
  List data = ["English", "عربي"];
  bool swtBusCheckIn = true, swtBusCheckOut = true, swtBusNear = true;
  var lang, lang1;

  getSettingLocal() async {
    try {
      swtBusCheckOut = CacheHelper.getBoolean(key: 'swtBusCheckOut');
      swtBusCheckIn = CacheHelper.getBoolean(key: 'swtBusCheckIn');
      swtBusNear = CacheHelper.getBoolean(key: 'swtBusNear');

      if (CacheHelper.getBoolean(key: 'lang') == 'ar') {
        lang1 = "عربي";
      } else {
        lang1 = "English";
      }
      emit(AppGetSettingState());
    } catch (e) {}
  }

  getschool() async {
    var responseKids = await DioHelper1.getData(url: '').then(
      (value) {
        school_list1 = value.data.map((e) => School.fromJson(e)).toList();
      },
    ).catchError((onError) {
      print(onError);
    });
  }

  void isObscur() {
    isObscur1 = !isObscur1;
    emit(AppObscurState());
  }

  Future<bool> internetConnectionChecker() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      return true;
    } else {
      return false;
    }
  }

  Future Login(String name, String pass, String schoolName) async {
    db_name = schoolName;

    if (await internetConnectionChecker()) {
      await FirebaseMessaging.instance.getToken().then((token) async {
        var response = await DioHelper.postData(data: {
          'user_name': name,
          'password': pass,
          'platform': Platform.isAndroid ? 'android' : 'ios',
          'mobile_token': token,
          'school_name': schoolName
        }, url: Login1)
            .then((value) async {
          var d = {
            'user_name': name,
            'password': pass,
            'platform': Platform.isAndroid ? 'android' : 'ios',
            'mobile_token': token,
            'school_name': schoolName
          };
          print(value.data);
          login_info = LoginModel.fromJson(value.data);

          if (login_info?.status == 'ok') {
            CacheHelper.saveData(key: 'school_name', value: db_name);
            CacheHelper.saveData(
                key: 'base_url', value: login_info?.webBaseUrl);
            CacheHelper.saveData(
                key: 'authorization', value: login_info?.authorization);
            CacheHelper.saveData(
                key: 'sessionId', value: login_info?.sessionId);
            CacheHelper.saveData(key: 'uid', value: login_info?.uid);
            await DioHelper.postData(
                    url: Kids_history,
                    data: {
                      "start_date": '',
                      "end_date": '',
                    },
                    token: CacheHelper.getBoolean(key: 'authorization'))
                .then(
              (value) async {
                notification = Notification_api.fromJson(value.data);
                list_notif = await notification!.notifications;
                status = 'OK';
              },
            ).catchError((onError) async {
              status = 'OK';
            });
            // getChildren();
          } else {
            status = 'Wrong';
          }
          emit(AppLoginState());
        }).catchError((onError) {
          status = 'Connection';
        });
      }).catchError(
        (error) {
          status = 'Connection';
        },
      );
    } else {
      status = 'Connection';
    }
  }

  Future<void> getStudent() async {
    getChildren();
    // Timer.periodic(new Duration(seconds: 30), (timer) async {
    //   getChildren();
    //
    // });
  }

  Future<void> getChildren() async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responseKids =
        await DioHelper.postData(url: Kids_List, data: {}, token: token).then(
      (value) async {
// print(value.data);
        student = Kids_list.fromJson(value.data);
        // print(value.data);
        list_st = student!.students!;
        // print(list_st);

        if (student!.students!.length > 0) {
          status = 'ok';
          if (t) {
            CacheHelper.saveData(key: 'school_name', value: db_name);
            CacheHelper.saveData(
                key: 'base_url', value: login_info?.webBaseUrl);
            CacheHelper.saveData(
                key: 'authorization', value: login_info?.authorization);
            CacheHelper.saveData(
                key: 'sessionId', value: login_info?.sessionId);
            CacheHelper.saveData(key: 'uid', value: login_info?.uid);
          }

          get_notif('', '');
        } else {
          status = 'No Children';
        }

        emit(AppKidsState());
      },
    ).catchError((onError) {
      status = 'Connection';
    });
  }

  void get_notif(dynamic fromDate, dynamic fromTo) async {
    if (fromDate.toString().isNotEmpty && fromTo.toString().isNotEmpty) {
      start_date = fromDate.toString();
      end_date = fromTo.toString();
    } else if (fromDate.toString().isNotEmpty && fromTo.toString().isEmpty) {
      start_date = fromDate.toString();
    } else if (fromDate.toString().isEmpty && fromTo.toString().isNotEmpty) {
      end_date = fromTo.toString();
    }

    var responseKids = await DioHelper.postData(
            url: Kids_history,
            data: {
              "start_date": start_date,
              "end_date": end_date,
            },
            token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
      (value) {
        notification = Notification_api.fromJson(value.data);
        list_notif = notification!.notifications;
        print(list_notif);
      },
    ).catchError((onError) {
      print(onError);
    });
  }

  Future<void> getSetting() async {
    var responseGetS = await DioHelper.getData(
            url: Settings,
            token: CacheHelper.getBoolean(key: 'authorization').toString())
        .then((value) {
      if (value.data.toString().isNotEmpty) {
        var notifications = value.data['notifications'];
        settingModel = SettingModel.fromJson(notifications);
        bool? n = settingModel?.nearby;
        bool? chIn = settingModel?.checkIn;
        bool? chOut = settingModel?.checkOut;

        try {
          swtBusCheckOut = chOut!;
          swtBusCheckIn = chIn!;
          swtBusNear = n!;
          if (settingModel?.locale.toString() == 'ar') {
            lang1 = "عربي";
          } else {
            lang1 = "English";
          }
          CacheHelper.saveData(key: 'swtBusCheckOut', value: chOut);
          CacheHelper.saveData(key: 'swtBusNear', value: n);
          CacheHelper.saveData(key: 'swtBusCheckIn', value: chIn);
          CacheHelper.saveData(
              key: 'lang', value: settingModel?.locale.toString());

          emit(AppGetSettingState());
        } catch (e) {}
      } else {
        setting();
      }
    }).catchError((onError) {});

    // }
  }

  Future<void> setting() async {
    // var data = {
    //   "notifications": {
    //     "\"nearby\"": CacheHelper.getBoolean(key: 'swtBusNear').toString().isNotEmpty?
    //     CacheHelper.getBoolean(key: 'swtBusNear').toString(): 'true',
    //     "\"check_in\"":CacheHelper.getBoolean(key: 'swtBusCheckIn').toString().isNotEmpty?
    //     CacheHelper.getBoolean(key: 'swtBusCheckOut').toString():'true' ,
    //     "\"check_out\"": CacheHelper.getBoolean(key: 'swtBusCheckIn').toString().isNotEmpty?
    //     CacheHelper.getBoolean(key: 'swtBusCheckOut').toString():'true',
    //     "\"locale\"":CacheHelper.getBoolean(key: 'lang').toString().isNotEmpty?
    //     CacheHelper.getBoolean(key: 'lang').toString(): "en",
    //   }.toString()
    // };
    // print(data);
    // if(CacheHelper.getBoolean(key: 'swtBusCheckOut').toString().isEmpty)
    // {
    var data = {
      "notifications": {
        "\"nearby\"":
            CacheHelper.getBoolean(key: 'swtBusNear').toString().isNotEmpty
                ? CacheHelper.getBoolean(key: 'swtBusNear').toString()
                : 'true',
        "\"check_in\"":
            CacheHelper.getBoolean(key: 'swtBusCheckIn').toString().isNotEmpty
                ? CacheHelper.getBoolean(key: 'swtBusCheckIn').toString()
                : 'true',
        "\"check_out\"":
            CacheHelper.getBoolean(key: 'swtBusCheckOut').toString().isNotEmpty
                ? CacheHelper.getBoolean(key: 'swtBusCheckOut').toString()
                : 'true',
        "\"locale\"": CacheHelper.getBoolean(key: 'lang').toString().isNotEmpty
            ? CacheHelper.getBoolean(key: 'lang').toString()
            : "en",
      }.toString()
    };

    var responseSettings = await DioHelper.postData(
            url: Settings,
            data: data,
            token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
      (value) {
        CacheHelper.saveData(
            key: 'swtBusCheckOut',
            value: CacheHelper.getBoolean(key: 'swtBusCheckOut')
                    .toString()
                    .isNotEmpty
                ? CacheHelper.getBoolean(key: 'swtBusCheckOut')
                : true);
        CacheHelper.saveData(
            key: 'swtBusNear',
            value:
                CacheHelper.getBoolean(key: 'swtBusNear').toString().isNotEmpty
                    ? CacheHelper.getBoolean(key: 'swtBusNear')
                    : true);
        CacheHelper.saveData(
            key: 'lang',
            value: CacheHelper.getBoolean(key: 'lang').toString().isNotEmpty
                ? CacheHelper.getBoolean(key: 'lang')
                : 'en');
        CacheHelper.saveData(
            key: 'swtBusCheckIn',
            value: CacheHelper.getBoolean(key: 'swtBusCheckIn')
                    .toString()
                    .isNotEmpty
                ? CacheHelper.getBoolean(key: 'swtBusCheckIn')
                : true);
        emit(AppSettingState());
      },
    ).catchError((onError) {
      status = 'Connection';
    });
  }

  void setLang() {
    locale = Locale(CacheHelper.getBoolean(key: 'lang').toString());
    emit(ApplangState());
  }

  void setDetalil(nameD, gradeD, schoolD, imageD, stdD, schoolLatD, schoolIdD,
      schoolLngD, distanceD, List<Features> listdetailD) {
    name = nameD;
    grade = gradeD;
    school = schoolD;
    image = imageD;
    std = stdD;
    school_lat = schoolLatD;
    school_lng = schoolLngD;
    school_id = schoolIdD;
    distance = distanceD;
    listdetail = listdetailD;

    // school_image=school_imaged;
    emit(AppDetailState());
  }

  void setUrl(String url) {
    url_3 = url;
    emit(AppUrlState());
  }

  void setUrl1(String url1) {
    url = url1;
    emit(AppUrlState());
  }

  void setStd(String title, String message, bool flag) {
    title_firbase = title;
    message_firbase = message;
    flag_firbase = flag;

    emit(AppNotState());
  }

  Future<void> getClinic(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responseKClinic =
        await DioHelper.getData(url: Get_Clinic + student_id, token: token)
            .then(
      (value) async {
        clinic = ModelClinic.fromJson(value.data);
        list_clinic = clinic!.result!;

        emit(AppClinicState());
      },
    ).catchError((onError) {});
  }

  Future<void> getAss(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responseAss =
        await DioHelper.getData(url: Get_Ass + student_id, token: token).then(
      (value) async {
        modelAss = ModelAss.fromJson(value.data);
        list_Ass = modelAss!.result!;

        emit(AppAssState());
      },
    ).catchError((onError) {});
  }

  Future<void> getExam(String student_id) async {
    // print('jdjjdjdjdjdjdjsssassdsad');
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responseExam =
        await DioHelper.getData(url: Get_Exam + student_id, token: token).then(
      (value) async {
        // print(value.data);
        modelExam = ModelExam.fromJson(value.data);
        list_Exam = modelExam!.result!;
        emit(AppExamState());
      },
    ).catchError((onError) {
      // print(onError);
    });
  }

  Future<void> getBadges(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    // print(Get_Badges + student_id);
    // print(token);
    var responseBadges =
        await DioHelper.getData(url: Get_Badges + student_id, token: token)
            .then(
      (value) async {
        modelBadges = ModelBadges.fromJson(value.data);
        list_Badges = modelBadges!.result!;
        emit(AppBadgesState());
      },
    ).catchError((onError) {
      // print("-----");
      // print(onError);

        });
  }

  Future<void> getCalendar(String student_id) async {
    // print("----------");
    // print(allMeetings.appointments.length);
    // for(int i=0;i<list_calendar.length;i++)
    // {
    if (allMeetings.appointments.length > 0)
      allMeetings.appointments.removeLast();
    // }
    // print(allMeetings.appointments.length);
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responseCalendar =
        await DioHelper.getData(url: Get_Calendar + student_id, token: token)
            .then(
      (value) async {
        modelCalendar = ModelCalendar.fromJson(value.data);
        list_calendar = modelCalendar!.result!;

        final List<Meeting> meetings = <Meeting>[];
        for (int i = 0; i < list_calendar.length; i++) {
          DateTime today = DateFormat('dd MMM yyyy')
              .parse(list_calendar[i].startDate.toString());
          // print(today);
          // final DateTime today = DateTime.now();
          final DateTime startTime =
              DateTime(today.year, today.month, today.day, 9);
          final DateTime endTime = startTime.add(const Duration(hours: 2));
          meetings.add(Meeting(
            from: startTime,
            to: endTime,
            eventName: list_calendar[i].name.toString(),
            background: Color(0xff3c92d0),
            isAllDay: true,
          ));
        }

        allMeetings = MeetingDataSource(meetings);

        emit(AppCalendarState());
      },
    ).catchError((onError) {});
  }

  Future<void> getAllWeeklePlan(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselWeeklePlan =
        await DioHelper.getData(url: Get_All_Weekly + student_id, token: token)
            .then(
      (value) async {
        allWeeklyPlan = AllWeeklyPlan.fromJson(value.data);
        list_allWeekly = allWeeklyPlan!.result!;
        emit(AppAllWeeklyPlansState());
      },
    ).catchError((onError) {});
  }

  Future<void> getWeeklePlan(String student_id, plan_id, plan_name) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselWeeklePlan = await DioHelper.getData(
            url: Get_Weekly + student_id + "/" + plan_id + "/" + plan_name,
            token: token)
        .then(
      (value) async {
        day.clear();
        day_week.clear();
        day_num.clear();
        // plan_id=plan_id;
        // plan_name=plan_name;
        innerWeeklyPlan = InnerWeeklyPlan.fromJson(value.data);

        for (int i = 0; i < innerWeeklyPlan!.result!.columns!.length; i++) {




          day.add(
            Tab(
                text: innerWeeklyPlan!.result!.columns![i].day.toString()[0] +
                    innerWeeklyPlan!.result!.columns![i].day.toString()[1] +
                    innerWeeklyPlan!.result!.columns![i].day.toString()[2]),
          );
          day_week.add(innerWeeklyPlan!.result!.columns![i].day.toString()[0] +
              innerWeeklyPlan!.result!.columns![i].day.toString()[1] +
              innerWeeklyPlan!.result!.columns![i].day.toString()[2]);
          // print("fffff"+day_num);
          if (i == 0) {

            day_name.add(innerWeeklyPlan!.result!.columns![i].day.toString());
            // print(day_name);
            day_num.add(i);
            day_week_color.add({'color': Colors.orange, 'sta': true});
          } else {
            day_week_color.add({'color': Colors.transparent, 'sta': false});
          }
        }

        list_innerWeekly = innerWeeklyPlan!.result!.lines!;

        emit(AppAllWeeklyPlansState());
      },
    ).catchError((onError) {});
  }

  Future<void> getAbsence(String student_id) async {
    // print(student_id);
    // print(Get_Absence + student_id);
    //
    // print("------------------1");
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    // print(token);
    var responsAbsence =
        await DioHelper.getData(url: Get_Absence + student_id, token: token)
            .then(
      (value) async {
        absenceRequestD = AbsenceRequestD.fromJson(value.data);
        // print(absenceRequestD!.absenceRequest!);
        // print(absenceRequestD);
        // print(student_id);
        // print(Get_Absence + student_id);
        //
        // print("------------------1");
        absenceRequest = absenceRequestD!.absenceRequest!;

        dailyAttendance = absenceRequestD!.dailyAttendance!;
        emit(AppAbsenceRequesState());
      },
    ).catchError((onError) {
      // print(onError);
    });
  }

  Future<void> getLibrary(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responsAbsence =
        await DioHelper.getData(url: Get_Library + student_id, token: token)
            .then(
      (value) async {
        modelLibrary = ModelLibrary.fromJson(value.data);

        borrowedBook = modelLibrary!.bookBorrowed!;

        requestBook = modelLibrary!.bookRequest!;

        book_list = modelLibrary!.book!;

        emit(AppAbsenceRequesState());
      },
    ).catchError((onError) {});
  }

  Future<void> getAllWorksheets(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselAllWorkSheet = await DioHelper.getData(
            url: Get_All_Worksheets + student_id, token: token)
        .then(
      (value) async {
        allWorksheet = AllWorksheet.fromJson(value.data);
        list_allWorkSheet = allWorksheet!.result!;
        emit(AppAllWorkSheetState());
      },
    ).catchError((onError) {});
  }

  Future<void> getAllEvents(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselAllEvents =
        await DioHelper.getData(url: Get_All_Events + student_id, token: token)
            .then(
      (value) async {
        allEvent = AllEvent.fromJson(value.data);

        list_allEvents = allEvent!.result!;

        emit(AppAllEventsState());
      },
    ).catchError((onError) {
      // print(onError);
    });
  }

  Future<void> getFormWorkSheet(String wsheet, String std) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselformWorkSheet = await DioHelper.getData(
            url: Get_WorkSheet + wsheet + "/" + std, token: token)
        .then(
      (value) async {
        workSheet = WorkSheet.fromJson(value.data);

        list_WorkSheet = workSheet!.result!;

        emit(AppFormWorkState());
      },
    ).catchError((onError) {});
  }

  Future<void> getFormEvent(String event, String std) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }

    var responselformEvent = await DioHelper.getData(
            url: Get_Event + event + "/" + std, token: token)
        .then(
      (value) async {
        modelEvents = ModelEvents.fromJson(value.data);

        list_Event = modelEvents!.result!;

        emit(AppFormEventState());
      },
    ).catchError((onError) {});
  }




  Future<void> logout() async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }

    var responseBadges =
    await DioHelper.postData(url: Logout ,data: {}, token: token)
        .then(
          (value) async {
        emit(AppLogoutState());
      },
    ).catchError((onError) {

    });
  }


  Future<void> getAllAllergies(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselAllEvents =
    await DioHelper.getData(url: Get_All_Allergies +'/'+ student_id , token: token)
        .then(
          (value) async {
            allergies = Allergies.fromJson(value.data);

            result_Allergies = allergies!.result!;
        print(result_Allergies[0].name);

        emit(AppProductState());
      },
    ).catchError((onError) {
      // print(onError);
    });
  }

  Future<void> getCanteen() async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
// print("kfkkfkfkfkfkffkfk");
    if(std.isNotEmpty){
    await DioHelper.postData(
        url: Get_canteen,
        data: {
          "student_id": AppCubit.std,

        },
        token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
          (value) async {
            canteen_Student = Canteen_Student.fromJson(value.data);

            bannedFood = canteen_Student!.bannedFood!.toString();
            spending = canteen_Student!.spending!;
            schduleMeals = canteen_Student!.schduleMeals!;
            foodAllegies = canteen_Student!.foodAllegies!;
            // print("0000000");
            // print(canteen_Student!.spending!);

        emit(AppProductState());
      },
    ).catchError((onError) {
      print(onError);
    });}
  }

  Future<void> getTimeTable(String student_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }
    var responselWeeklePlan = await DioHelper.getData(
        url: Get_Time_Table + student_id ,
        token: token)
        .then(
          (value) async {
        day.clear();
        day_week.clear();
        day_num.clear();
        // plan_id=plan_id;
        // plan_name=plan_name;
        tableTime = TableTime.fromJson(value.data);

        for (int i = 0; i < tableTime!.result!.columns!.length; i++) {




          day.add(
            Tab(
                text: tableTime!.result!.columns![i].day.toString()[0] +
                    tableTime!.result!.columns![i].day.toString()[1] +
                    tableTime!.result!.columns![i].day.toString()[2]),
          );
          day_week.add(tableTime!.result!.columns![i].day.toString()[0] +
              tableTime!.result!.columns![i].day.toString()[1] +
              tableTime!.result!.columns![i].day.toString()[2]);
          // print("fffff"+day_num);
          if (i == 0) {

            day_name.add(tableTime!.result!.columns![i].day.toString());
            // print(day_name);
            day_num.add(i);
            day_week_color.add({'color': Colors.orange, 'sta': true});
          } else {
            day_week_color.add({'color': Colors.transparent, 'sta': false});
          }
        }

        list_tableTime = tableTime!.result!.lines!;

        emit(AppTimeTableState());
      },
    ).catchError((onError) {});
  }


  Future<void> getCategory() async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }

    await DioHelper.getData(url: Get_Category , token: token)
        .then(
          (value) async {
            menu_Cat = Menu_Cat.fromJson(value.data);
            menu = menu_Cat!.result!;


        emit(AppProductState());
      },
    ).catchError((onError) {
    });
  }



  Future<void> getItem() async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }

    await DioHelper.getData(url: Get_Item , token: token)
        .then(
          (value) async {
            item_model = Item_model.fromJson(value.data);
            category = item_model!.category!;
            product= item_model!.product!;

        emit(AppProductState());
      },
    ).catchError((onError) {
    });
  }

  Future<void> getBanned() async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }

    await DioHelper.postData(
        url: Get_banned_student,
        data: {
          "student_id": AppCubit.std,

        },
        token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
          (value) async {
        //      static List<Banned_student> DateIte = [];
            //   static List<Banned_student> DataCat = [];
        banned_student = Banned_student.fromJson(value.data);
        //
        dateIte = banned_student!.dateIte!;
        dataCat = banned_student!.dataCat!;
        // spending = canteen_Student!.spending!;
        // schduleMeals = canteen_Student!.schduleMeals!;
        // foodAllegies = canteen_Student!.foodAllegies!;
        // print(spending);

        emit(AppProductState());
      },
    ).catchError((onError) {
      // print(onError);
    });
  }
  Future<void> getFood(int day_id) async {
    String? token;
    bool t;
    if (login_info?.authorization != null) {
      t = true;
      token = login_info?.authorization.toString();
    } else {
      t = false;
      token = CacheHelper.getBoolean(key: 'authorization');
    }

    await DioHelper.postData(
        url: Get_food_student,
        data: {
          "student_id": AppCubit.std,
          "day_id": day_id,
        },
        token: CacheHelper.getBoolean(key: 'authorization'))
        .then(
          (value) async {

        food_student = Food_student.fromJson(value.data);
        dateItem = food_student!.dateItem!;



        emit(AppProductState());
      },
    ).catchError((onError) {
      print(onError);
    });
  }

//  dateItem

}
