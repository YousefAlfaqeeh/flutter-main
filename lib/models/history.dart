// import 'package:flutter/material.dart';
// class History {
//   String massege;
//   String tit;
//   String image;
//   String date;
//   String time;
//   History({ required this.massege, required this.tit, required this.image, required this.date, required this.time});
// }
//
// class Notification_api {
//   List<Notifications> notifications=[];
//
//   Notification_api({this.notifications=const[]});
//
//   Notification_api.fromJson(Map<String, dynamic> json) {
//     // print(json);
//     notifications = <Notifications>[];
//     if (json['notifications'] != null) {
//       json['notifications'].forEach((v) {
//         notifications.add(new Notifications.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.notifications != null) {
//       data['notifications'] =
//           this.notifications.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Notifications {
//   String? avatar;
//   String? dateTime;
//   String? notificationsTitle;
//   String? notificationsText;
//   String? studentName;
//   String? notificationsType;
//   String? studentId;
//
//   Notifications(
//       {this.avatar,
//         this.dateTime,
//         this.notificationsTitle,
//         this.notificationsText,this.studentName,this.notificationsType,this.studentId});
//
//   Notifications.fromJson(Map<String, dynamic> json) {
//     avatar = json['avatar'];
//     dateTime = json['date_time'];
//     notificationsTitle = json['notifications_title'];
//     notificationsText = json['notifications_text'];
//     studentName=json['student_name'];
//     notificationsType=json['notificationsType'];
//     studentId=json['student_id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['avatar'] = this.avatar;
//     data['date_time'] = this.dateTime;
//     data['notifications_title'] = this.notificationsTitle;
//     data['notifications_text'] = this.notificationsText;
//     data['student_name']=this.studentName;
//     data['notificationsType']=this.notificationsType;
//     data['student_id']=this.studentId;
//     return data;
//   }
// }
import 'package:flutter/material.dart';
class History {
  String massege;
  String tit;
  String image;
  String date;
  String time;
  History({ required this.massege, required this.tit, required this.image, required this.date, required this.time});
}

class Notification_api {
  List<Notifications> notifications=[];

  Notification_api({this.notifications=const[]});

  Notification_api.fromJson(Map<String, dynamic> json) {
    // print(json);
    notifications = <Notifications>[];
    if (json['notifications'] != null) {
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  String? avatar;
  String? dateTime;
  String? notificationsTitle;
  String? notificationsText;
  String? notificationsTitleAr;
  String? notificationsTextAr;
  String? studentName;
  String? notificationsType;
  String? studentId;
  String? studentImage;
  String? iconTracking;
  String? notificationsId;
  String? notificationsRead;
  String? notificationsShow;
  String? actionId;
  String? createdateTime;
  String? imageLink;
  String? plan_name;
  List<Attachments>? attachments;

  Notifications(
      {this.avatar,
        this.dateTime,
        this.notificationsTitle,
        this.notificationsText,this.studentName,this.notificationsType,this.studentId,this.iconTracking,this.notificationsId
        ,this.notificationsRead,this.notificationsShow,this.actionId,this.notificationsTitleAr,this.notificationsTextAr,this.studentImage,this.createdateTime,this.imageLink,this.plan_name,this.attachments});

  Notifications.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    dateTime = json['date_time'];
    notificationsTitle = json['notifications_title'];
    notificationsText = json['notifications_text'];
    studentName=json['student_name'];
    notificationsType=json['notificationsType'];
    studentId=json['student_id'].toString();
    iconTracking=json['icon_tracking'];
    notificationsId=json['id'].toString();
    notificationsRead=json['stutes'];
    notificationsShow=json['show'];
    actionId=json['action_id'].toString();
    notificationsTitleAr = json['notifications_title_ar'];
    notificationsTextAr = json['notifications_text_ar'];
    studentImage = json['student_image'];
    createdateTime=json['create_date'];
    imageLink=json['imageLink'];
    plan_name=json['plan_name'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    else
      {
        attachments=[];
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['date_time'] = this.dateTime;
    data['notifications_title'] = this.notificationsTitle;
    data['notifications_text'] = this.notificationsText;
    data['student_name']=this.studentName;
    data['notificationsType']=this.notificationsType;
    data['student_id']=this.studentId;
    data['icon_tracking']=this.iconTracking;
    data['id']=this.notificationsId;
    data['stutes']=this.notificationsRead;
    data['show']=this.notificationsShow;
    data['action_id']=this.actionId;
    data['notifications_title_ar']=this.notificationsTitleAr;
    data['notifications_text_ar']=this.notificationsTextAr ;
   data['student_image']=this.studentImage;
    data['create_date']=this.createdateTime;
    data['imageLink']=imageLink;
    data['plan_name']=plan_name;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    //plan_name
    return data;
  }
}



class Attachments {
  int? id;
  String? name;
  String? datas;

  Attachments({this.id, this.name, this.datas});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    datas = json['datas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['datas'] = this.datas;
    return data;
  }
}
