class mark {
  List<AllExam>? allExam;
  String? code;

  mark({this.allExam, this.code});

  mark.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['all_exam'] != null) {
      allExam = <AllExam>[];
      json['all_exam'].forEach((v) {
        allExam!.add(new AllExam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all_exam']= this.code;
    if (this.allExam != null) {
      data['all_exam'] = this.allExam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllExam {
  String? semester;
  List<Exam>? exam;

  AllExam({this.semester, this.exam});

  AllExam.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    if (json['exam'] != null) {
      exam = <Exam>[];
      json['exam'].forEach((v) {
        exam!.add(new Exam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semester'] = this.semester;
    if (this.exam != null) {
      data['exam'] = this.exam!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exam {
  String? examNameAr;
  String? examNameEn;
  List<SubjectDet>? subjectDet;

  Exam({this.examNameAr, this.examNameEn, this.subjectDet});

  Exam.fromJson(Map<String, dynamic> json) {
    examNameAr = json['exam_name_ar'];
    examNameEn = json['exam_name_en'];
    if (json['subject_det'] != null) {
      subjectDet = <SubjectDet>[];
      json['subject_det'].forEach((v) {
        subjectDet!.add(new SubjectDet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_name_ar'] = this.examNameAr;
    data['exam_name_en'] = this.examNameEn;
    if (this.subjectDet != null) {
      data['subject_det'] = this.subjectDet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubjectDet {
  String? subjectName;
  String? studentMark;
  String? maxMark;

  SubjectDet({this.subjectName, this.studentMark, this.maxMark});

  SubjectDet.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    studentMark = json['student_mark'];
    maxMark = json['max_mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_name'] = this.subjectName;
    data['student_mark'] = this.studentMark;
    data['max_mark'] = this.maxMark;
    return data;
  }
}
