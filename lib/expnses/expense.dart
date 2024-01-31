import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

import 'category_icons.dart';

part 'expense.g.dart';

@collection
class Expense {
  Id isarId = Isar.autoIncrement;

  final double? amount;
  final String? description;
  final DateTime? selectedDate;
  final String? notes;
  final String? tags;
  final CategoryIconData? category;

  Expense({
    this.amount,
    this.tags,
    this.notes,
    this.selectedDate,
    this.description,
    this.category,
  });
}

@embedded
class CategoryIconData {
  final int? iconDataCodepoint;
  final String? label;
  final int? colorValue;
  final int? backgroundColorValue;

  CategoryIconData({
    this.iconDataCodepoint,
    this.label,
    this.colorValue,
    this.backgroundColorValue,
  });
}

  // static String toJSONString(IconData data) {
  //   Map<String, dynamic> map = <String, dynamic>{};
  //   map['codePoint'] = data.codePoint;
  //   map['fontFamily'] = data.fontFamily;
  //   map['fontPackage'] = data.fontPackage;
  //   map['matchTextDirection'] = data.matchTextDirection;
  //   return jsonEncode(map);
  // }

  // static IconData fromJSONString(String jsonString) {
  //   Map<String, dynamic> map = jsonDecode(jsonString);
  //   return IconData(
  //     map['codePoint'],
  //     fontFamily: map['fontFamily'],
  //     fontPackage: map['fontPackage'],
  //     matchTextDirection: map['matchTextDirection'],
  //   );
  // }