import '../../domain/entity/user_entity.dart';

const Object _sentinel = Object();

/// Data model representing a user in the dashboard with JSON serialization
/// and bidirectional mapping to [UserEntity].
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.isActive,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String email;
  final String? phone;
  final bool isActive;
  final DateTime createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    Object? phone = _sentinel,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: identical(phone, _sentinel) ? this.phone : phone as String?,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}
