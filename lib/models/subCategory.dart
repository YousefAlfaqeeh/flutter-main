import 'package:flutter/material.dart';

// List dataList = [
//   {
//     "name": "Sales",
//     "icon": Icons.payment,
//     "subMenu": [
//       {"name": "Orders"},
//       {"name": "Invoices"}
//     ]
//   },
//   {
//     "name": "Marketing",
//     "icon": Icons.volume_up,
//     "subMenu": [
//       {
//         "name": "Promotions",
//         "subMenu": [
//           {"name": "Catalog Price Rule"},
//           {"name": "Cart Price Rules"}
//         ]
//       },
//       {
//         "name": "Communications",
//         "subMenu": [
//           {"name": "Newsletter Subscribers"}
//         ]
//       },
//       {
//         "name": "SEO & Search",
//         "subMenu": [
//           {"name": "Search Terms"},
//           {"name": "Search Synonyms"}
//         ]
//       },
//       {
//         "name": "User Content",
//         "subMenu": [
//           {"name": "All Reviews"},
//           {"name": "Pending Reviews"}
//         ]
//       }
//     ]
//   }
// ];
class Menu_Cat {
  List<Menu>? result;

  Menu_Cat({this.result});

  Menu_Cat.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Menu>[];
      json['result'].forEach((v) {
        result!.add(new Menu.fromJson(v));
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

class Menu {
  String? name;
  String? icon;
  List<Menu> subMenu = [];
  int? id;
  bool? stutes;
  bool?sub;
  Menu({required this.name, required this.subMenu, required this.icon,this.id,this.stutes,this.sub});
  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    id=json['id'] ;
    stutes=json['stutes'];
    sub=json['sub'];
    if (json['subMenu'] != null) {
      subMenu.clear();
      json['subMenu'].forEach((v) {
        subMenu?.add(new Menu.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['stutes'] = this.stutes;
    data['icon'] = this.icon;
    data['sub'] = this.sub;
    if (this.subMenu != null) {
      data['subMenu'] = this.subMenu!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}