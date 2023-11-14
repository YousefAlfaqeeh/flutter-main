class Allergies {
  List<Result_Allergies>? result;

  Allergies({this.result});

  Allergies.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result_Allergies>[];
      json['result'].forEach((v) {
        result!.add(new Result_Allergies.fromJson(v));
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

class Result_Allergies {
  int? id;
  String? name;
  String? icon;
  String? des;
  bool ?st;

  Result_Allergies({this.id, this.name,this.icon, this.des,this.st});

  Result_Allergies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    des = json['des'];
    st = json['st'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['des'] = this.des;
    data['st'] = this.st;
    return data;
  }
}