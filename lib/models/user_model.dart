import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? emai;
  String? image;
  bool? status;
  UserModel({
    this.id,
    this.name,
    this.emai,
    this.image,
    this.status,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? emai,
    String? image,
    bool? status,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      emai: emai ?? this.emai,
      image: image ?? this.image,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (emai != null) {
      result.addAll({'emai': emai});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (status != null) {
      result.addAll({'status': status});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      emai: map['emai'],
      image: map['image'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, emai: $emai, image: $image, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.emai == emai &&
        other.image == image &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        emai.hashCode ^
        image.hashCode ^
        status.hashCode;
  }
}
