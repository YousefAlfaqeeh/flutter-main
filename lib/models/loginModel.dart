
class LoginModel {
  String? status;
  List<Null>? kids;
  List<NotificationsText>? notificationsText;
  int? uid;
  String? sessionId;
  String? webBaseUrl;
  String? authorization;

  LoginModel(
      {this.status,
        this.kids,
        this.notificationsText,
        this.uid,
        this.sessionId,
        this.webBaseUrl,
        this.authorization});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['kids'] != null) {
      kids = <Null>[];
      // json['kids'].forEach((v) {
      //   kids!.add(new Null.fromJson(v));
      // });
    }
    if (json['notifications_text'] != null) {
      notificationsText = <NotificationsText>[];
      json['notifications_text'].forEach((v) {
        notificationsText!.add(NotificationsText.fromJson(v));
      });
    }
    uid = json['uid'];
    sessionId = json['session_id'];
    webBaseUrl = json['web_base_url'];
    authorization = json['Authorization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (kids != null) {
      // data['kids'] = this.kids!.map((v) => v.toJson()).toList();
    }
    if (notificationsText != null) {
      data['notifications_text'] =
          notificationsText!.map((v) => v.toJson()).toList();
    }
    data['uid'] = uid;
    data['session_id'] = sessionId;
    data['web_base_url'] = webBaseUrl;
    data['Authorization'] = authorization;
    return data;
  }
}

class NotificationsText {
  String? type;
  List<Actions>? actions;

  NotificationsText({this.type, this.actions});

  NotificationsText.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actions {
  String? noShow;
  String? checkIn;
  String? checkOut;
  String? absent;
  String? nearBy;

  Actions({this.noShow, this.checkIn, this.checkOut, this.absent, this.nearBy});

  Actions.fromJson(Map<String, dynamic> json) {
    noShow = json['no-show'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    absent = json['absent'];
    nearBy = json['near_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['no-show'] = noShow;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['absent'] = absent;
    data['near_by'] = nearBy;
    return data;
  }
}
