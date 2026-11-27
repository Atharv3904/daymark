// lib/features/authethication/data/model/login_model.dart
//
// Data model used by the data layer to interact with the FastAPI backend
// for the login flow. It mirrors the fields required by the REST API
// (`email` and `password`). The model can be constructed from a domain
// `LoginEntity` and provides a `toJson` method for the API request body.

import 'package:daymark_tracking/features/authethication/domain/entity/login_entity.dart';

class LoginModel {
  const LoginModel({required this.email, required this.password});

  final String email;
  final String password;

  /// Create a [LoginModel] from a domain [LoginEntity].
  factory LoginModel.fromEntity(LoginEntity entity) {
    return LoginModel(email: entity.email, password: entity.password);
  }

  /// Convert the model to a JSON map for the REST API request body.
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
