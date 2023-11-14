class SettingModel {
  String? locale;
  bool? nearby;
  bool? checkIn;
  bool? checkOut;

  SettingModel({this.locale, this.nearby, this.checkIn, this.checkOut});

  SettingModel.fromJson(Map<String, dynamic> json) {
    locale = json['locale'];
    nearby = json['nearby'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locale'] = this.locale;
    data['nearby'] = this.nearby;
    data['check_in'] = this.checkIn;
    data['check_out'] = this.checkOut;
    return data;
  }
}