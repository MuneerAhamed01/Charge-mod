class User {
  final String userId;
  final String? mobile;
  final String? firstName;
  final String? lastName;
  final List<String> refreshToken;

  User({
    required this.userId,
    required this.mobile,
    required this.firstName,
    required this.lastName,
    required this.refreshToken,
  });

  String get userFullName => "$firstName $lastName";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      mobile: json['mobile'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      refreshToken: List<String>.from(json['refreshToken']),
    );
  }
}
