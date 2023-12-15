class UserStatus {
  final String accessToken;
  final String refreshToken;
  final bool isNewUser;
  final String userId;
  UserStatus({
    required this.accessToken,
    required this.refreshToken,
    required this.isNewUser,
    required this.userId,
  });

  UserStatus copyWith({
    String? accessToken,
    String? refreshToken,
    bool? isNewUser,
    String? userId,
  }) {
    return UserStatus(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isNewUser: isNewUser ?? this.isNewUser,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'accessToken': accessToken});
    result.addAll({'refreshToken': refreshToken});
    result.addAll({'isNewUser': isNewUser});
    result.addAll({'userId': userId});

    return result;
  }

  factory UserStatus.fromJson(Map<String, dynamic> map) {
    return UserStatus(
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      isNewUser: map['isNewUser'] ?? '',
      userId: map['userId'] ?? '',
    );
  }
}
