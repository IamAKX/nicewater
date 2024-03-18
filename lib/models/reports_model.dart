import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MapModel {
  String? id;
  GeoPoint? location;
  String? type;
  Timestamp? createdOn;
  String? address;
  String? city;
  String? comment;
  String? otherInfo;
  bool? status;
  MapModel({
    this.id,
    this.location,
    this.type,
    this.createdOn,
    this.address,
    this.city,
    this.comment,
    this.otherInfo,
    this.status,
  });

  MapModel copyWith({
    String? id,
    GeoPoint? location,
    String? type,
    Timestamp? createdOn,
    String? address,
    String? city,
    String? comment,
    String? otherInfo,
    bool? status,
  }) {
    return MapModel(
      id: id ?? this.id,
      location: location ?? this.location,
      type: type ?? this.type,
      createdOn: createdOn ?? this.createdOn,
      address: address ?? this.address,
      city: city ?? this.city,
      comment: comment ?? this.comment,
      otherInfo: otherInfo ?? this.otherInfo,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (location != null) {
      result.addAll({'location': location});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (comment != null) {
      result.addAll({'comment': comment});
    }
    if (otherInfo != null) {
      result.addAll({'otherInfo': otherInfo});
    }
    if (status != null) {
      result.addAll({'status': status});
    }

    return result;
  }

  factory MapModel.fromMap(Map<String, dynamic> map) {
    return MapModel(
      id: map['id'],
      location: map['location'],
      type: map['type'],
      createdOn: map['createdOn'],
      address: map['address'],
      city: map['city'],
      comment: map['comment'],
      otherInfo: map['otherInfo'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MapModel.fromJson(String source) =>
      MapModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MapModel(id: $id, location: $location, type: $type, createdOn: $createdOn, address: $address, city: $city, comment: $comment, otherInfo: $otherInfo, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MapModel &&
        other.id == id &&
        other.location == location &&
        other.type == type &&
        other.createdOn == createdOn &&
        other.address == address &&
        other.city == city &&
        other.comment == comment &&
        other.otherInfo == otherInfo &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        location.hashCode ^
        type.hashCode ^
        createdOn.hashCode ^
        address.hashCode ^
        city.hashCode ^
        comment.hashCode ^
        otherInfo.hashCode ^
        status.hashCode;
  }
}
