class AllWeeklyPlan {
  List<ResultAllWeeklyPlan>? result;

  AllWeeklyPlan({this.result});

  AllWeeklyPlan.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultAllWeeklyPlan>[];
      json['result'].forEach((v) {
        result!.add(new ResultAllWeeklyPlan.fromJson(v));
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

class ResultAllWeeklyPlan {
  int? id;
  String? planName;
  String? startDate;
  String? endDate;

  ResultAllWeeklyPlan({this.id, this.planName, this.startDate, this.endDate});

  ResultAllWeeklyPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan_name'] = this.planName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}