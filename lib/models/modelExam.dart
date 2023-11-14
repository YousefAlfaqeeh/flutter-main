class ModelExam {
  List<ResultExam>? result;

  ModelExam({this.result});

  ModelExam.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultExam>[];
      json['result'].forEach((v) {
        result!.add(new ResultExam.fromJson(v));
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

class ResultExam {
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
  bool? start;
  String? startTime;
  String? allowedTimeToStartExams;
  String? allowedEnterExamStudentIds;
  String? examNameEnglish;
  String? examNameArabic;
  double? mark;
  double? timeLimit;
  double? allowedTimeToStart;
  String? lateToExams;
  String? lateTime;
  String? examStartIn;
  bool? allowedToEnterExamAfterTimeLimit;

  ResultExam(
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
        this.start,
        this.startTime,
        this.allowedTimeToStartExams,
        this.allowedEnterExamStudentIds,
        this.examNameEnglish,
        this.examNameArabic,
        this.mark,
        this.timeLimit,
        this.allowedTimeToStart,
        this.lateToExams,
        this.lateTime,
        this.examStartIn,
        this.allowedToEnterExamAfterTimeLimit});

  ResultExam.fromJson(Map<String, dynamic> json) {
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
    start = json['start'];
    startTime = json['start_time'];
    allowedTimeToStartExams = json['allowed_time_to_start_exams'];
    allowedEnterExamStudentIds = json['allowed_enter_exam_student_ids'];
    examNameEnglish = json['exam_name_english'];
    examNameArabic = json['exam_name_arabic'];
    mark = double.parse(json['mark'].toString());
    timeLimit = double.parse(json['time_limit'].toString());
    allowedTimeToStart = json['allowed_time_to_start'];
    lateToExams = json['late_to_exams'];
    lateTime = json['late_time'];
    examStartIn = json['exam_start_in'];
    allowedToEnterExamAfterTimeLimit = json['allowed_to_enter_exam_after_time_limit'];
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
    data['start'] = this.start;
    data['start_time'] = this.startTime;
    data['allowed_time_to_start_exams'] = this.allowedTimeToStartExams;
    data['allowed_enter_exam_student_ids'] = this.allowedEnterExamStudentIds;
    data['exam_name_english'] = this.examNameEnglish;
    data['exam_name_arabic'] = this.examNameArabic;
    data['mark'] = this.mark;
    data['time_limit'] = this.timeLimit;
    data['allowed_time_to_start'] = this.allowedTimeToStart;
    data['late_to_exams'] = this.lateToExams;
    data['late_time'] = this.lateTime;
    data['exam_start_in'] = this.examStartIn;
    data['allowed_to_enter_exam_after_time_limit'] =
        this.allowedToEnterExamAfterTimeLimit;
    return data;
  }
}
