class ModelAss {
  List<ResultAss>? result;

  ModelAss({this.result});

  ModelAss.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultAss>[];
      json['result'].forEach((v) {
        result!.add(new ResultAss.fromJson(v));
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

class ResultAss {
  int? id;
  int? assignmentId;
  String? name;
  String? subject;
  String? token;
  String? answerToken;
  int? questionsCount;
  String? state;
  String? lastDisplayedPage;
  int? answeredQuestions;
  String? assState;
  String? deadline;
  bool? start;

  ResultAss(
      {this.id,
        this.assignmentId,
        this.name,
        this.subject,
        this.token,
        this.answerToken,
        this.questionsCount,
        this.state,
        this.lastDisplayedPage,
        this.answeredQuestions,
        this.assState,
        this.deadline,
        this.start});

  ResultAss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignmentId = json['assignment_id'];
    name = json['name'];
    subject = json['subject'];
    token = json['token'];
    answerToken = json['answer_token'];
    questionsCount = json['questions_count'];
    state = json['state'];
    lastDisplayedPage = json['last_displayed_page'];
    answeredQuestions = json['answered_questions'];
    assState = json['ass_state'];
    deadline = json['deadline'];
    start = json['start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['assignment_id'] = this.assignmentId;
    data['name'] = this.name;
    data['subject'] = this.subject;
    data['token'] = this.token;
    data['answer_token'] = this.answerToken;
    data['questions_count'] = this.questionsCount;
    data['state'] = this.state;
    data['last_displayed_page'] = this.lastDisplayedPage;
    data['answered_questions'] = this.answeredQuestions;
    data['ass_state'] = this.assState;
    data['deadline'] = this.deadline;
    data['start'] = this.start;
    return data;
  }
}