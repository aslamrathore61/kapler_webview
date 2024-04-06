import 'package:hive/hive.dart';

part 'native_item.g.dart'; // Generated file by running flutter pub run build_runner build

@HiveType(typeId: 0)
class NativeItem {
  @HiveField(0)
  List<Items>? items;

  NativeItem({this.items});

  factory NativeItem.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      var itemList = json['items'] as List;
      List<Items> itemsList = itemList.map((i) => Items.fromJson(i)).toList();
      return NativeItem(items: itemsList);
    }
    return NativeItem(items: []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class Items {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? icon;
  @HiveField(2)
  String? uRL;
  @HiveField(3)
  int? id;

  Items({this.title, this.icon, this.uRL, this.id});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      title: json['title'],
      icon: json['icon'],
      uRL: json['URL'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['URL'] = this.uRL;
    data['id'] = this.id;
    return data;
  }
}
