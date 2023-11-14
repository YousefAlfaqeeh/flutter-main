class School {
  String? nameEn;
  String? nameAr;
  String? dbName;
  String? url;
  String? image;

  School({this.nameEn, this.nameAr, this.dbName, this.url, this.image});

  School.fromJson(Map<String, dynamic> json) {
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    dbName = json['db_name'];
    url = json['url'];
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['db_name'] = dbName;
    data['url'] = url;
    data['image'] = image;
    return data;
  }
}
