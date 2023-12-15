import 'dart:async';
import 'dart:convert';

import 'package:charge_mod/models/user_status.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late final SharedPreferences _sharedPreferences;

  bool _isInitialized = false;

  static LocalStorageService? _instance;

  LocalStorageService._();

  static LocalStorageService get instance {
    if (_instance == null) {
      throw Exception('Did not provide any singleton for this ');
    } else {
      return _instance!;
    }
  }

  static Future<LocalStorageService> getInstance() async {
    _instance = LocalStorageService._();

    if (_instance!._isInitialized) {
      return _instance!;
    } else {
      _instance!._sharedPreferences = await SharedPreferences.getInstance();
      _instance!._isInitialized = true;
      return _instance!;
    }
  }

  Future<bool> addUserStatus(UserStatus userStatus) async {
    return await _sharedPreferences.setString(
      _MyLocalKeys.userStatus,
      jsonEncode(userStatus.toJson()),
    );
  }

  UserStatus? getUserStatus() {
    final status = _sharedPreferences.getString(_MyLocalKeys.userStatus);
    if (status == null) return null;
    return UserStatus.fromJson(
      jsonDecode(status),
    );
  }

  Future<bool> addOnboardingStatus(bool status) async {
    return await _sharedPreferences.setBool(_MyLocalKeys.onboarding, status);
  }

  /// Conclude the onboarding shown only first time when screen is appeared
  bool getOnBoardingStatus() {
    return _sharedPreferences.getBool(_MyLocalKeys.onboarding) ?? false;
  }
}

class _MyLocalKeys {
  static const String userStatus = 'user-status';
  static const String onboarding = 'onboarding';
}
