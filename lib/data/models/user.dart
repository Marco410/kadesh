class KUser {
  final String id;
  final String name;
  final String lastName;
  final String username;
  final String email;
  final String role;
  final String sessionToken;
  final String? phone;
  final ProfileImage? profileImage;
  final String? secondLastName;
  final bool? verified;
  final String? birthday;
  final int? age;

  KUser({
    required this.id,
    required this.name,
    required this.lastName,
    required this.username,
    required this.email,
    required this.role,
    required this.sessionToken,
    this.phone,
    this.profileImage,
    this.secondLastName,
    this.verified,
    this.birthday,
    this.age,
  });

  factory KUser.fromJson(Map<String, dynamic> json) {
    return KUser(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      username: json['username'],
      secondLastName: json['secondLastName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      sessionToken: json['sessionToken'],
      profileImage: json['profileImage'],
      verified: json['verified'],
      birthday: json['birthday'],
      age: json['age'] != "" ? int.parse(json['age'] ?? '0') : 0,
    );
  }
}

class ProfileImage {
  final String url;

  ProfileImage({required this.url});

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      url: json['url'],
    );
  }
}
