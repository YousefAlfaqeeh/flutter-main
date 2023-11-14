class ModelEvents {
  List<ResultEvent>? result;

  ModelEvents({this.result});

  ModelEvents.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultEvent>[];
      json['result'].forEach((v) {
        result!.add(new ResultEvent.fromJson(v));
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

class ResultEvent {
  int? eventId;
  String? name;
  String? startDate;
  String? endDate;
  String? registrationStartDate;
  String? registrationLastDate;
  int? maximumParticipants;
  int? availableSeats;
  String? cost;
  String? contactName;
  int? contactId;
  String? contactImage;
  String? supervisorName;
  String? event;
  String? eventName;
  String? link;
  int? supervisorId;
  String? supervisorImage;
  String? state;
  String? flag;
  String? period;
  String? newAdded;
  List<StudentSolutionEvent>? studentSolution;

  ResultEvent(
      {this.eventId,
        this.name,
        this.startDate,
        this.endDate,
        this.registrationStartDate,
        this.registrationLastDate,
        this.maximumParticipants,
        this.availableSeats,
        this.cost,
        this.contactName,
        this.contactId,
        this.contactImage,
        this.supervisorName,
        this.event,
        this.eventName,
        this.link,
        this.supervisorId,
        this.supervisorImage,
        this.state,
        this.flag,
        this.period,
        this.studentSolution,
      this.newAdded});

  ResultEvent.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    registrationStartDate = json['registration_start_date'];
    registrationLastDate = json['registration_last_date'];
    maximumParticipants = json['maximum_participants'];
    availableSeats = json['available_seats'];
    cost = json['cost'];
    contactName = json['contact_name'];
    contactId = json['contact_id'];
    contactImage = json['contact_image'];
    supervisorName = json['supervisor_name'];
    event = json['event'];
    eventName = json['event_name'];
    link = json['link'];
    supervisorId = json['supervisor_id'];
    supervisorImage = json['supervisor_image'];
    state = json['state'];
    flag = json['flag'];
    period = json['period'];
    newAdded=json['new_added'];
    if (json['student_solution'] != null) {
      studentSolution = <StudentSolutionEvent>[];
      json['student_solution'].forEach((v) {
        studentSolution!.add(new StudentSolutionEvent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['registration_start_date'] = this.registrationStartDate;
    data['registration_last_date'] = this.registrationLastDate;
    data['maximum_participants'] = this.maximumParticipants;
    data['available_seats'] = this.availableSeats;
    data['cost'] = this.cost;
    data['contact_name'] = this.contactName;
    data['contact_id'] = this.contactId;
    data['contact_image'] = this.contactImage;
    data['supervisor_name'] = this.supervisorName;
    data['event'] = this.event;
    data['event_name'] = this.eventName;
    data['link'] = this.link;
    data['supervisor_id'] = this.supervisorId;
    data['supervisor_image'] = this.supervisorImage;
    data['state'] = this.state;
    data['flag'] = this.flag;
    data['period'] = this.period;
    data['new_added']=this.newAdded;
    if (this.studentSolution != null) {
      data['student_solution'] =
          this.studentSolution!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentSolutionEvent {
  String? name;
  String? fileSize;

  StudentSolutionEvent({this.name, this.fileSize});

  StudentSolutionEvent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    fileSize = json['file_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['file_size'] = this.fileSize;
    return data;
  }
}
