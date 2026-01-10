class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;
  final String phone;
  final String cell;
  final String gender;
  final String city;
  final String state;
  final String country;
  final DateTime? dateOfBirth;
  final int? age;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    this.phone = '',
    this.cell = '',
    this.gender = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.dateOfBirth,
    this.age,
  });

  // Full name getter
  String get fullName => '$firstName $lastName';

  // Create UserModel from randomuser.me JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as Map<String, dynamic>? ?? {};
    final location = json['location'] as Map<String, dynamic>? ?? {};
    final login = json['login'] as Map<String, dynamic>? ?? {};
    final picture = json['picture'] as Map<String, dynamic>? ?? {};
    final dob = json['dob'] as Map<String, dynamic>? ?? {};

    DateTime? dateOfBirth;
    if (dob['date'] != null) {
      dateOfBirth = DateTime.tryParse(dob['date'] as String);
    }

    return UserModel(
      id: login['uuid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: name['first'] as String? ?? '',
      lastName: name['last'] as String? ?? '',
      avatar: picture['large'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      cell: json['cell'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      city: location['city'] as String? ?? '',
      state: location['state'] as String? ?? '',
      country: location['country'] as String? ?? '',
      dateOfBirth: dateOfBirth,
      age: dob['age'] as int?,
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'login': {'uuid': id},
      'email': email,
      'name': {'first': firstName, 'last': lastName},
      'picture': {'large': avatar},
      'phone': phone,
      'cell': cell,
      'gender': gender,
      'location': {'city': city, 'state': state, 'country': country},
      'dob': {'date': dateOfBirth?.toIso8601String(), 'age': age},
    };
  }

  // Create a copy of the model with updated fields
  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
    String? phone,
    String? cell,
    String? gender,
    String? city,
    String? state,
    String? country,
    DateTime? dateOfBirth,
    int? age,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      cell: cell ?? this.cell,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $fullName, city: $city)';
  }
}
