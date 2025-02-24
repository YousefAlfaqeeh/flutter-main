// class WorkSheet {
//   List<ResultFormWorkSheet>? result;
//
//   WorkSheet({this.result});
//
//   WorkSheet.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = <ResultFormWorkSheet>[];
//       json['result'].forEach((v) {
//         result!.add(new ResultFormWorkSheet.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
// class StudentSolution {
//   String? name;
//   String? fileSize;
//
//   StudentSolution({this.name, this.fileSize});
//
//   StudentSolution.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     fileSize = json['file_size'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['file_size'] = this.fileSize;
//     return data;
//   }
// }
//
// class ResultFormWorkSheet {
//   int? worksheetId;
//   String? name;
//   String? date;
//   String? teacherName;
//   String? link;
//   String? teacherPosition;
//   int? teacherId;
//   String? teacherImage;
//   String? subject;
//   String? homework;
//   String? homeworkName;
//   String? description;
//   String? deadline;
//   String? end;
//   List<StudentSolution>? studentSolution;
//
//   ResultFormWorkSheet(
//       {this.worksheetId,
//         this.name,
//         this.date,
//         this.teacherName,
//         this.link,
//         this.teacherPosition,
//         this.teacherId,
//         this.teacherImage,
//         this.subject,
//         this.homework,
//         this.homeworkName,
//         this.description,
//         this.deadline,
//         this.end,
//         this.studentSolution});
//
//   ResultFormWorkSheet.fromJson(Map<String, dynamic> json) {
//     worksheetId = json['worksheet_id'];
//     name = json['name'];
//     date = json['date'];
//     teacherName = json['teacher_name'];
//     link = json['link'];
//     teacherPosition = json['teacher_position'];
//     teacherId = json['teacher_id'];
//     teacherImage = json['teacher_image'];
//     subject = json['subject'];
//     homework = json['homework'];
//     homeworkName = json['homework_name'];
//     description = json['description'];
//     deadline = json['deadline'];
//     end = json['end'];
//     if (json['student_solution'] != null) {
//       studentSolution = <StudentSolution>[];
//       json['student_solution'].forEach((v) {
//         studentSolution!.add(new StudentSolution.fromJson(v));
//       });
//     }
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['worksheet_id'] = this.worksheetId;
//     data['name'] = this.name;
//     data['date'] = this.date;
//     data['teacher_name'] = this.teacherName;
//     data['link'] = this.link;
//     data['teacher_position'] = this.teacherPosition;
//     data['teacher_id'] = this.teacherId;
//     data['teacher_image'] = this.teacherImage;
//     data['subject'] = this.subject;
//     data['homework'] = this.homework;
//     data['homework_name'] = this.homeworkName;
//     data['description'] = this.description;
//     data['deadline'] = this.deadline;
//     data['end'] = this.end;
//     if (this.studentSolution != null) {
//       data['student_solution'] =
//           this.studentSolution!.map((v) => v.toJson()).toList();
//     }
//     return data;
//
//
//   }
// }
// class WorkSheet {
//   List<ResultFormWorkSheet>? result;
//
//   WorkSheet({this.result});
//
//   WorkSheet.fromJson(Map<String, dynamic> json) {
//     if (json['result'] != null) {
//       result = <ResultFormWorkSheet>[];
//       json['result'].forEach((v) {
//         result!.add(new ResultFormWorkSheet.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.result != null) {
//       data['result'] = this.result!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ResultFormWorkSheet {
//   int? worksheetId;
//   String? name;
//   String? date;
//   String? teacherName;
//   String? link;
//   String? teacherPosition;
//   int? teacherId;
//   String? teacherImage;
//   String? subject;
//   String? homework;
//   String? homeworkName;
//   String? description;
//   String? deadline;
//   String? end;
//   String? external_link;
//   List<StudentSolution>? studentSolution;
//
//   ResultFormWorkSheet(
//       {this.worksheetId,
//         this.name,
//         this.date,
//         this.teacherName,
//         this.link,
//         this.teacherPosition,
//         this.teacherId,
//         this.teacherImage,
//         this.subject,
//         this.homework,
//         this.homeworkName,
//         this.description,
//         this.deadline,
//         this.end,
//         this.studentSolution,this.external_link});
//
//   ResultFormWorkSheet.fromJson(Map<String, dynamic> json) {
//     worksheetId = json['worksheet_id'];
//     name = json['name'];
//     date = json['date'];
//     teacherName = json['teacher_name'];
//     link = json['link'];
//     teacherPosition = json['teacher_position'];
//     teacherId = json['teacher_id'];
//     teacherImage = json['teacher_image'];
//     subject = json['subject'];
//     homework = json['homework'];
//     homeworkName = json['homework_name'];
//     description = json['description'];
//     deadline = json['deadline'];
//     end = json['end'];
//     external_link=json['external_link'];
//     if (json['student_solution'] != null) {
//       studentSolution = <StudentSolution>[];
//       json['student_solution'].forEach((v) {
//         studentSolution!.add(new StudentSolution.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['worksheet_id'] = this.worksheetId;
//     data['name'] = this.name;
//     data['date'] = this.date;
//     data['teacher_name'] = this.teacherName;
//     data['link'] = this.link;
//     data['teacher_position'] = this.teacherPosition;
//     data['teacher_id'] = this.teacherId;
//     data['teacher_image'] = this.teacherImage;
//     data['subject'] = this.subject;
//     data['homework'] = this.homework;
//     data['homework_name'] = this.homeworkName;
//     data['description'] = this.description;
//     data['deadline'] = this.deadline;
//     data['end'] = this.end;
//    data['external_link']= external_link;
//     if (this.studentSolution != null) {
//       data['student_solution'] =
//           this.studentSolution!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class StudentSolution {
//   String? name;
//   String? fileSize;
//
//   StudentSolution({this.name, this.fileSize});
//
//   StudentSolution.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     fileSize = json['file_size'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['file_size'] = this.fileSize;
//     return data;
//   }
// }


class WorkSheet {
  List<ResultFormWorkSheet>? result;

  WorkSheet({this.result});

  WorkSheet.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultFormWorkSheet>[];
      json['result'].forEach((v) {
        result!.add(new ResultFormWorkSheet.fromJson(v));
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

class ResultFormWorkSheet {
  int? worksheetId;
  String? name;
  String? date;
  String? teacherName;
  String? link;
  int? teacherId;
  String? teacherImage;
  String? teacherPosition;
  String? subject;
  String? homework;
  String? homeworkName;
  String? description;
  String? externalLink;
  String? teacherNote;
  String? deadline;
  String? end;
  List<StudentSolution>? studentSolution;
  List<HowmorkList>? howmorkList;

  ResultFormWorkSheet(
      {this.worksheetId,
        this.name,
        this.date,
        this.teacherName,
        this.link,
        this.teacherId,
        this.teacherImage,
        this.teacherPosition,
        this.subject,
        this.homework,
        this.homeworkName,
        this.description,
        this.externalLink,
        this.deadline,
        this.end,
        this.studentSolution,
        this.howmorkList,
      this.teacherNote});

  ResultFormWorkSheet.fromJson(Map<String, dynamic> json) {
    worksheetId = json['worksheet_id'];
    name = json['name'];
    date = json['date'];
    teacherName = json['teacher_name'];
    link = json['link'];
    teacherId = json['teacher_id'];
    teacherImage = json['teacher_image'];
    teacherPosition = json['teacher_position'];
    subject = json['subject'];
    homework = json['homework'];
    homeworkName = json['homework_name'];
    description = json['description'];
    externalLink = json['external_link'];
    deadline = json['deadline'];
    end = json['end'];
    teacherNote=json['notes'];
    if (json['student_solution'] != null) {
      studentSolution = <StudentSolution>[];
      json['student_solution'].forEach((v) {
        studentSolution!.add(new StudentSolution.fromJson(v));
      });
    }
    if (json['howmork_list'] != null) {
      howmorkList = <HowmorkList>[];
      json['howmork_list'].forEach((v) {
        howmorkList!.add(new HowmorkList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['worksheet_id'] = this.worksheetId;
    data['name'] = this.name;
    data['date'] = this.date;
    data['teacher_name'] = this.teacherName;
    data['link'] = this.link;
    data['teacher_id'] = this.teacherId;
    data['teacher_image'] = this.teacherImage;
    data['teacher_position'] = this.teacherPosition;
    data['subject'] = this.subject;
    data['homework'] = this.homework;
    data['homework_name'] = this.homeworkName;
    data['description'] = this.description;
    data['external_link'] = this.externalLink;
    data['deadline'] = this.deadline;
    data['end'] = this.end;
    data['notes'] =this.teacherNote;
    if (this.studentSolution != null) {
      data['student_solution'] =
          this.studentSolution!.map((v) => v.toJson()).toList();
    }
    if (this.howmorkList != null) {
      data['howmork_list'] = this.howmorkList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentSolution {
  String? name;
  String? link;

  StudentSolution({this.name, this.link});

  StudentSolution.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['link'] = this.link;
    return data;
  }
}

class HowmorkList {
  String? name;
  String? link;
  String? type;

  HowmorkList({this.name, this.link, this.type});

  HowmorkList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['link'] = this.link;
    data['type'] = this.type;
    return data;
  }
}