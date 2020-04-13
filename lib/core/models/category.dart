import 'dart:ui';

import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final Color color;
  final IconData icon;

  Category({this.id, this.name, this.color, this.icon});

  Category.fromMap(Map data)
      : id = data['id'] ?? 0,
        name = data['name'] ?? "",
        color = Color(data['color']) ?? Colors.black,
        icon = IconData(data['icon'], fontFamily: 'MaterialIcons') ?? null;

  toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
      'icon': icon.codePoint,
    };
  }

  static List<Category> getCategories() {
    return [
      Category(
        id: 1,
        name: "General",
        color: Colors.blueGrey,
        icon: Icons.subject,
      ),
      Category(
          id: 2,
          name: "Sport",
          color: Colors.lightBlueAccent,
          icon: Icons.directions_run),
      Category(
        id: 3,
        name: "Work",
        color: Colors.amberAccent,
        icon: Icons.work,
      ),
      Category(
          id: 4,
          name: "Hobby",
          color: Colors.pinkAccent,
          icon: Icons.videogame_asset),
      Category(
        id: 5,
        name: "Daily routine",
        color: Colors.black,
        icon: Icons.today,
      ),
      Category(
        id: 6,
        name: "Study",
        color: Colors.lightGreen,
        icon: Icons.book,
      )
    ];
  }

  @override
  bool operator ==(Category other) => other.id == this.id;

  @override
  int get hashCode => name.hashCode;
}
