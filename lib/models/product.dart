class product {
  List<ResultProduct>? result;

  product({this.result});

  product.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ResultProduct>[];
      json['result'].forEach((v) {
        result!.add(new ResultProduct.fromJson(v));
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

class ResultProduct {
  String? name;
  String? allergies;
  String? image;
  int? id;
  String? descriptionForMeals;
  String? nutritionalValue;
  String? listPrice;

  ResultProduct(
      {this.name,
        this.allergies,
        this.image,
        this.id,
        this.descriptionForMeals,
        this.nutritionalValue,
        this.listPrice});

  ResultProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    allergies = json['allergies'];
    image = json['image'];
    id = json['id'];
    descriptionForMeals = json['description_for_meals'];
    nutritionalValue = json['nutritional_value'];
    listPrice = json['list_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['allergies'] = this.allergies;
    data['image'] = this.image;
    data['id'] = this.id;
    data['description_for_meals'] = this.descriptionForMeals;
    data['nutritional_value'] = this.nutritionalValue;
    data['list_price'] = this.listPrice;
    return data;
  }
}