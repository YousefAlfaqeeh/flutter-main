class InnerWeeklyPlan {
  ResultInnerWeekly? result;

  InnerWeeklyPlan({this.result});

  InnerWeeklyPlan.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new ResultInnerWeekly.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class ResultInnerWeekly {
  String? planName;
  List<Columns>? columns;
  List<Lines>? lines;
  String? notes;

  ResultInnerWeekly({this.planName, this.columns, this.lines, this.notes});

  ResultInnerWeekly.fromJson(Map<String, dynamic> json) {
    planName = json['plan_name'];
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(new Columns.fromJson(v));
      });
    }
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_name'] = this.planName;
    if (this.columns != null) {
      data['columns'] = this.columns!.map((v) => v.toJson()).toList();
    }
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    data['notes'] = this.notes;
    return data;
  }
}

class Columns {
  int? id;
  String? day;

  Columns({this.id, this.day});

  Columns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    return data;
  }
}

class Lines {
  String? thursday;
  String? sunday;
  String? wednesday;
  String? tuesday;
  String? monday;
  String? friday;
  String? saturday;
  int? subjectId;
  String? subjectName;
  String? notes;
  List<Attachments>? attachments;

  Lines(
      {this.thursday,
        this.sunday,
        this.wednesday,
        this.tuesday,
        this.monday,
        this.friday,
        this.saturday,
        this.subjectId,
        this.subjectName,
        this.notes,
        this.attachments});

  Lines.fromJson(Map<String, dynamic> json) {
    thursday = json['Thursday'];
    sunday = json['Sunday'];
    wednesday = json['Wednesday'];
    tuesday = json['Tuesday'];
    monday = json['Monday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    subjectId = json['subject_id'];
    subjectName = json['subject_name'];
    notes = json['notes'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Thursday'] = this.thursday;
    data['Sunday'] = this.sunday;
    data['Wednesday'] = this.wednesday;
    data['Tuesday'] = this.tuesday;
    data['Monday'] = this.monday;
    data['Friday'] = this.friday;
    data['Saturday'] = this.saturday;
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['notes'] = this.notes;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
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
