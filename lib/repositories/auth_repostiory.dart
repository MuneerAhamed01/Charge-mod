import 'package:charge_mod/models/user_status.dart';
import 'package:charge_mod/services/api_path_service.dart';
import 'package:charge_mod/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository(this.dio);

  UserStatus? _currentUser;

  set currentUser(UserStatus user) => _currentUser = user;

  UserStatus? get userStatus {
    _currentUser = LocalStorageService.instance.getUserStatus();
    return _currentUser;
  }

  bool get isLogged => _currentUser != null;

  bool get isNewUser => _currentUser!.isNewUser;

  String? get accessToken => _currentUser?.accessToken;

//  UserStat get

  Future<bool> sendOtp(String mobileNumber) async {
    try {
      final response = await dio.post(
        ApiService.api('signIn'),
        data: {'mobile': mobileNumber},
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<bool> resendOtp(String mobileNumber) async {
    try {
      final response = await dio.post(
        ApiService.api('resend'),
        data: {'mobile': mobileNumber, 'type': 'text'},
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<bool> verifyOtp(String otp, String mobileNumber) async {
    try {
      final response = await dio.post(
        ApiService.api('verify'),
        data: {'mobile': mobileNumber, 'otp': int.parse(otp)},
      );
      currentUser = UserStatus.fromJson(response.data['data']);
      await LocalStorageService.instance.addUserStatus(_currentUser!);
      return _currentUser != null;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }
}
