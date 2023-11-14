class AllWorksheet {
  List<ResultAllWorksheet>? result;

  AllWorksheet({this.result});

  AllWorksheet.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultAllWorksheet>[];
      json['result'].forEach((v) {
        result!.add(new ResultAllWorksheet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultAllWorksheet {
  int? worksheetId;
  String? name;
  String? date;
  String? priority;
  String? deadline;
  String? subject;
  String? finish;

  ResultAllWorksheet(
      {this.worksheetId,
        this.name,
        this.date,
        this.priority,
        this.deadline,
        this.subject,
      this.finish});

  ResultAllWorksheet.fromJson(Map<String, dynamic> json) {
    worksheetId = json['worksheet_id'];
    name = json['name'];
    date = json['date'];
    priority = json['priority'];
    deadline = json['deadline'];
    subject = json['subject'];
    finish = json['finish'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worksheet_id'] = this.worksheetId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['priority'] = this.priority;
    data['deadline'] = this.deadline;
    data['subject'] = this.subject;
    data['finish'] = this.finish;
    return data;
  }
}
