class ListDetail
{
  late String? name;
  late String? image;

  ListDetail({ this.name,  this.image});
}


class ListFeatures
{
  late String? name;
  late String? name_ar;
  late String? icon;
  late String? url;
  late String? arabic_url;
  late String? mobile_number;
  ListFeatures({this.name, this.name_ar, this.icon, this.url, this.arabic_url,this.mobile_number});
  ListFeatures.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    name_ar = json['name_ar'];
    icon = json['icon'];
    url = json['url'];
    arabic_url = json['arabic_url'];

  }




}