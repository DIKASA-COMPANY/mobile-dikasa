import 'user.dart';

/// Safe self-account fields returned by the backend.
class AccountProfile {
  AccountProfile.fromJson(Map<String, dynamic> j)
    : user = User.fromJson(j),
      firstName = j['first_name'] as String? ?? '',
      lastName = j['last_name'] as String? ?? '',
      phone = j['phone_number'] as String? ?? '',
      email = j['email'] as String? ?? '',
      birthDate = j['date_of_birth'] as String? ?? '',
      genderId = j['gender_id'] as String? ?? '',
      address = j['personal_address'] as String? ?? '',
      avatarUrl = j['avatar_url'] as String?,
      hasPIN = j['has_pin'] as bool? ?? false,
      canChangePassword = j['can_change_password'] as bool? ?? false {
    if (j['id'] is! String ||
        (j['id'] as String).isEmpty ||
        j['first_name'] is! String) {
      throw const FormatException('Invalid self profile');
    }
  }
  final User user;
  final String firstName, lastName, phone, email, birthDate, genderId, address;
  final String? avatarUrl;
  final bool hasPIN, canChangePassword;
  Map<String, String> get fields => {
    'first_name': firstName,
    'last_name': lastName,
    'phone_number': phone,
    'email': email,
    'date_of_birth': birthDate,
    'gender_id': genderId,
    'personal_address': address,
  };
}

class GenderOption {
  GenderOption.fromJson(Map<String, dynamic> j)
    : id = j['id'] as String,
      name = j['name'] as String;
  final String id, name;
}
