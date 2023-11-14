class Food_student {
  List<DateItem>? dateItem;

  Food_student({this.dateItem});

  Food_student.fromJson(Map<String, dynamic> json) {
    if (json['date_item'] != null) {
      dateItem = <DateItem>[];
      json['date_item'].forEach((v) {
        dateItem!.add(new DateItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dateItem != null) {
      data['date_item'] = this.dateItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateItem {
  String? name;
  int? id;
  String? price;
  String? image;
  String? type;

  DateItem({this.name, this.id, this.price, this.image, this.type});

  DateItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['price'] = this.price;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
