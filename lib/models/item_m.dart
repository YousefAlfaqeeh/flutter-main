class Item_model {
  List<Category>? category;
  List<Product>? product;

  Item_model({this.category, this.product});

  Item_model.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? name;
  int? id;
  String? icon;
  bool?sta;

  Category({this.name, this.id, this.icon,this.sta});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    icon = json['icon'];
    sta = json['sta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['sta'] = this.sta;
    return data;
  }
}

class Product {
  String? name;
  int? id;
  String? type;
  String? price;
  String? image;

  Product({this.name, this.id, this.type, this.price, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    type = json['type'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['type'] = this.type;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}