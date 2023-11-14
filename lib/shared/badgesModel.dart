class ModelBadges {
  List<ResultBadges>? result;
  bool newAdd=false;
  ModelBadges({this.result,required this.newAdd});

  ModelBadges.fromJson(Map<String, dynamic> json) {
    newAdd = json['new_add'];
    if (json['result'] != null) {
      result = <ResultBadges>[];
      json['result'].forEach((v) {
        result!.add(new ResultBadges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['new_add']=this.newAdd;
    return data;
  }
}

class ResultBadges {
  String? name;
  String? date;
  String? image;
  int? id;
  String? teacher;
  String? subject;
  String? description;
  String? jopNmae;
  String? imageT;
  bool? newBadge;
  bool? disable;

  ResultBadges(
      {this.name,
        this.date,
        this.image,
        this.id,
        this.teacher,
        this.subject,
        this.description,
        this.newBadge,
        this.disable,this.imageT,this.jopNmae});

  ResultBadges.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    date = json['date'];
    image = json['image'];
    id = json['id'];
    teacher = json['teacher'];
    subject = json['subject'];
    description = json['description'];
    newBadge = json['new_badge'];
    disable = json['disable'];
    jopNmae=json['jop_name'];
    imageT=json['image_teacher'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['date'] = this.date;
    data['image'] = this.image;
    data['id'] = this.id;
    data['teacher'] = this.teacher;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['new_badge'] = this.newBadge;
    data['disable'] = this.disable;
    data['jop_name']=this.jopNmae;
    data['image_teacher']=this.imageT;
    return data;
  }
}
