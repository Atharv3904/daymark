// lib/features/authethication/data/model/registration_model.dart
//
// Data model used by the data layer to interact with Supabase for the
// registration flow. It mirrors the fields required by Supabase (`email`
// and `password`). The model can be constructed from a domain
// `RegistrationEntity` and provides a `toJson` method for the Supabase SDK.

import 'package:daymark_tracking/features/authethication/domain/entity/registration_entity.dart';

class RegistrationModel {
  const RegistrationModel({required this.email, required this.password});

  final String email;
  final String password;

  /// Create a [RegistrationModel] from a domain [RegistrationEntity].
  factory RegistrationModel.fromEntity(RegistrationEntity entity) {
    return RegistrationModel(email: entity.email, password: entity.password);
  }

  /// Convert the model to a map that can be passed to Supabase's `signUp`
  /// method. The SDK expects a JSON‑like map with `email` and `password`
  /// keys.
  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
