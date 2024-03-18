import 'dart:convert';

import 'package:flutter/material.dart';

class MapFilterModel {
  String? name;
  int? id;
  String? type;
  IconData? iconData;
  IconData? selectedIconData;
  MapFilterModel({
    this.name,
    this.id,
    this.type,
    this.iconData,
    this.selectedIconData,
  });

  MapFilterModel copyWith({
    String? name,
    int? id,
    String? type,
    IconData? iconData,
    IconData? selectedIconData,
  }) {
    return MapFilterModel(
      name: name ?? this.name,
      id: id ?? this.id,
      type: type ?? this.type,
      iconData: iconData ?? this.iconData,
      selectedIconData: selectedIconData ?? this.selectedIconData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (iconData != null) {
      result.addAll({'iconData': iconData!.codePoint});
    }
    if (selectedIconData != null) {
      result.addAll({'selectedIconData': selectedIconData!.codePoint});
    }

    return result;
  }

  factory MapFilterModel.fromMap(Map<String, dynamic> map) {
    return MapFilterModel(
      name: map['name'],
      id: map['id']?.toInt(),
      type: map['type'],
      iconData: map['iconData'] != null
          ? IconData(map['iconData'], fontFamily: 'MaterialIcons')
          : null,
      selectedIconData: map['selectedIconData'] != null
          ? IconData(map['selectedIconData'], fontFamily: 'MaterialIcons')
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MapFilterModel.fromJson(String source) =>
      MapFilterModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MapFilterModel(name: $name, id: $id, type: $type, iconData: $iconData, selectedIconData: $selectedIconData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapFilterModel &&
        other.name == name &&
        other.id == id &&
        other.type == type &&
        other.iconData == iconData &&
        other.selectedIconData == selectedIconData;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        type.hashCode ^
        iconData.hashCode ^
        selectedIconData.hashCode;
  }
}
