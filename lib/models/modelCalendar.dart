class ModelCalendar {
  List<ResultCalendar>? result;

  ModelCalendar({this.result});

  ModelCalendar.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultCalendar>[];
      json['result'].forEach((v) {
        result!.add(new ResultCalendar.fromJson(v));
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

class ResultCalendar {
  int? id;
  String? name;
  String? startDate;
  String? year;

  ResultCalendar({this.id, this.name, this.startDate, this.year});

  ResultCalendar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['year'] = this.year;
    return data;
  }
}