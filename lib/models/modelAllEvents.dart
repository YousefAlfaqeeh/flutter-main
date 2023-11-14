class AllEvent {
  List<ResultAllEvents>? result;

  AllEvent({this.result});

  AllEvent.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultAllEvents>[];
      json['result'].forEach((v) {
        result!.add(new ResultAllEvents.fromJson(v));
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

class ResultAllEvents {
  int? eventId;
  String? name;
  String? startDate;
  String? state;
  String? participantState;
  String? newAdded;

  ResultAllEvents(
      {this.eventId,
        this.name,
        this.startDate,
        this.state,
        this.participantState,
        this.newAdded});

  ResultAllEvents.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    name = json['name'];
    startDate = json['start_date'];
    state = json['state'];
    participantState = json['participant_state'];
    newAdded = json['new_added'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['state'] = this.state;
    data['participant_state'] = this.participantState;
    data['new_added'] = this.newAdded;
    return data;
  }
}
