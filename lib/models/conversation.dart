class Conversation {
  String? jsonrpc;
  Null? id;
  ResultCu? result;

  Conversation({this.jsonrpc, this.id, this.result});

  Conversation.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
    json['result'] != null ? new ResultCu.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ResultCu {
  List<Teachers>? teachers;

  ResultCu({this.teachers});

  ResultCu.fromJson(Map<String, dynamic> json) {
    if (json['teachers'] != null) {
      teachers = <Teachers>[];
      json['teachers'].forEach((v) {
        teachers!.add(new Teachers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.teachers != null) {
      data['teachers'] = this.teachers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Teachers {
  int? teacherId;
  String? teacherName;
  String? image;
  String? text;
  String? date;
  bool? isMessageRead;

  Teachers(
      {this.teacherId, this.teacherName, this.image, this.text, this.date,this.isMessageRead});

  Teachers.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
    image = json['image'];
    text = json['text'];
    date = json['date'];
    isMessageRead = json['isMessageRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['teacher_id'] = this.teacherId;
    data['teacher_name'] = this.teacherName;
    data['image'] = this.image;
    data['text'] = this.text;
    data['date'] = this.date;
    data['isMessageRead']=this.isMessageRead ;
    return data;
  }
}
