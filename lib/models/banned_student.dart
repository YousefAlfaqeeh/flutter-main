class Banned_student {
  List<DateIte>? dateIte;
  List<DataCat>? dataCat;

  Banned_student({this.dateIte, this.dataCat});

  Banned_student.fromJson(Map<String, dynamic> json) {
    if (json['date_ite'] != null) {
      dateIte = <DateIte>[];
      json['date_ite'].forEach((v) {
        dateIte!.add(new DateIte.fromJson(v));
      });
    }
    if (json['data_cat'] != null) {
      dataCat = <DataCat>[];
      json['data_cat'].forEach((v) {
        dataCat!.add(new DataCat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dateIte != null) {
      data['date_ite'] = this.dateIte!.map((v) => v.toJson()).toList();
    }
    if (this.dataCat != null) {
      data['data_cat'] = this.dataCat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateIte {
  String? name;
  int? id;
  int?product_id;
  String? price;
  String? image;
  String? type;

  DateIte({this.name, this.id, this.price, this.image,this.type,this.product_id});

  DateIte.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    price = json['price'];
    image = json['image'];
    type = json['type'];
    product_id = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['price'] = this.price;
    data['image'] = this.image;
    data['type'] = this.type;
    data['product_id'] = this.product_id;
    return data;
  }
}

class DataCat {
  String? name;
  int? id;
  String? categorySup;

  DataCat({this.name, this.id, this.categorySup});

  DataCat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    categorySup = json['category_sup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['category_sup'] = this.categorySup;
    return data;
  }
}
