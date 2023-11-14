class ModelClinic {
  List<Result>? result;

  ModelClinic({this.result});

  ModelClinic.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
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

class Result {
  int? visitId;
  String? name;
  String? date;
  String? time;
  String? note;
  String? temperature;
  String? bloodPressure;
  String? prescription;

  Result(
      {this.visitId,
        this.name,
        this.date,
        this.time,
        this.note,
        this.temperature,
        this.bloodPressure,
        this.prescription});

  Result.fromJson(Map<String, dynamic> json) {
    visitId = json['visit_id'];
    name = json['name'];
    date = json['date'];
    time = json['time'];
    note = json['note'];
    temperature = json['temperature'];
    bloodPressure = json['blood_pressure'];
    prescription = json['prescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visit_id'] = this.visitId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['time'] = this.time;
    data['note'] = this.note;
    data['temperature'] = this.temperature;
    data['blood_pressure'] = this.bloodPressure;
    data['prescription'] = this.prescription;
    return data;
  }
}