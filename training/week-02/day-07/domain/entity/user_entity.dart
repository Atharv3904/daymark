import 'package:equatable/equatable.dart';

const Object _sentinel = Object();

/// Domain entity representing a user in the dashboard.
class UserEntity extends Equatable {
  const UserEntity({
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

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    Object? phone = _sentinel,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: identical(phone, _sentinel) ? this.phone : phone as String?,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, isActive, createdAt];
}
