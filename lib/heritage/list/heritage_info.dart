import 'package:meta/meta.dart';
import 'dart:convert';

class Heritage {
  final int id;
  final String time;
  final String category;
  final String location;
  final String apply_location;
  final String content;
  final String number;
  final String img;
  final String title;

  //构造函数
  Heritage({
    @required this.id,
    @required this.time,
    @required this.category,
    @required this.location,
    @required this.apply_location,
    @required this.content,
    @required this.number,
    @required this.img,
    @required this.title
  });

  //解析json
  static List<Heritage> parseFromJson(String json) {
    return JSON.decode(json).map((it) => Heritage.fromMap(it)).toList();
  }

  static Heritage fromMap(Map map) {
    return new Heritage(
        id: map["id"],
        time: map["time"],
        category: map["category"],
        location: map["location"],
        apply_location: map["apply_location"],
        content: map["content"],
        number: map["number"],
        img: map["img"],
        title: map["title"]
    );
  }
}