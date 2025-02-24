class TableTime {
  Result_time_table? result;

  TableTime({this.result});

  TableTime.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result_time_table.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result_time_table {
  List<Columns>? columns;
  List<Lines_time_table>? lines;

  Result_time_table({this.columns, this.lines});

  Result_time_table.fromJson(Map<String, dynamic> json) {
    if (json['columns'] != null) {
      columns = <Columns>[];
      json['columns'].forEach((v) {
        columns!.add(new Columns.fromJson(v));
      });
    }
    if (json['lines'] != null) {
      lines = <Lines_time_table>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines_time_table.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.columns != null) {
      data['columns'] = this.columns!.map((v) => v.toJson()).toList();
    }
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
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

class Lines_time_table {
  int? subjectId;
  String? subjectName;
  String? sequence;
  String? saturday;
  String? sunday;
  String? monday;
  String? tuesday;
  String? wednesday;
  String? thursday;
  String? friday;

  Lines_time_table(
      {this.subjectId,
        this.subjectName,
        this.sequence,
        this.saturday,
        this.sunday,
        this.monday,
        this.tuesday,
        this.wednesday,
        this.thursday,
        this.friday});

  Lines_time_table.fromJson(Map<String, dynamic> json) {
    subjectId = json['subject_id'];
    sequence = json['sequence'];
    subjectName = json['subject_name'];
    saturday = json['Saturday'];
    sunday = json['Sunday'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_id'] = this.subjectId;
    data['subject_name'] = this.subjectName;
    data['Saturday'] = this.saturday;
    data['sequence'] = this.sequence;
    data['Sunday'] = this.sunday;
    data['Monday'] = this.monday;
    data['Tuesday'] = this.tuesday;
    data['Wednesday'] = this.wednesday;
    data['Thursday'] = this.thursday;
    data['Friday'] = this.friday;
    return data;
  }
}