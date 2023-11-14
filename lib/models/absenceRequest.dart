class AbsenceRequestD {
  List<AbsenceRequest>? absenceRequest;
  List<DailyAttendance>? dailyAttendance;

  AbsenceRequestD({this.absenceRequest, this.dailyAttendance});

  AbsenceRequestD.fromJson(Map<String, dynamic> json) {
    if (json['absence_request'] != null) {
      absenceRequest = <AbsenceRequest>[];
      json['absence_request'].forEach((v) {
        absenceRequest!.add(new AbsenceRequest.fromJson(v));
      });
    }
    if (json['daily_attendance'] != null) {
      dailyAttendance = <DailyAttendance>[];
      json['daily_attendance'].forEach((v) {
        dailyAttendance!.add(new DailyAttendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.absenceRequest != null) {
      data['absence_request'] =
          this.absenceRequest!.map((v) => v.toJson()).toList();
    }
    if (this.dailyAttendance != null) {
      data['daily_attendance'] =
          this.dailyAttendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AbsenceRequest {
  int? leaveId;
  String? name;
  String? startDate;
  String? endDate;
  String? reason;
  String? type;
  String? status;
  String? arrivalTime;

  AbsenceRequest(
      {this.leaveId,
        this.name,
        this.startDate,
        this.endDate,
        this.reason,
        this.type,
        this.status,
        this.arrivalTime});

  AbsenceRequest.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    reason = json['reason'];
    type = json['type'];
    status = json['status'];
    arrivalTime = json['arrival_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_id'] = this.leaveId;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['reason'] = this.reason;
    data['type'] = this.type;
    data['status'] = this.status;
    data['arrival_time'] = this.arrivalTime;
    return data;
  }
}

class DailyAttendance {
  int? leaveId;
  String? name;
  String? startDate;
  String? endDate;
  String? reason;
  String? type;
  String? arrivalTime;

  DailyAttendance(
      {this.leaveId,
        this.name,
        this.startDate,
        this.endDate,
        this.reason,
        this.type,
        this.arrivalTime});

  DailyAttendance.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    reason = json['reason'];
    type = json['type'];
    arrivalTime = json['arrival_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_id'] = this.leaveId;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['reason'] = this.reason;
    data['type'] = this.type;
    data['arrival_time'] = this.arrivalTime;
    return data;
  }
}