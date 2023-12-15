import 'package:charge_mod/models/user_model.dart';
import 'package:charge_mod/services/api_path_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserRepository {
  final Dio dio;

  UserRepository(this.dio);

  User? _currentUser;

  set currentUser(User user) => _currentUser = user;

//  UserStat get

  Future<bool> updateUserDetails(Map<String, dynamic> data) async {
    try {
      final response = await dio.post(
        ApiService.api('register'),
        data: data,
      );

      return response.statusCode == 200;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      rethrow;
    }
  }

  Future<User> getUserDetails() async {
    try {
      final response = await dio.get(ApiService.api('get-customer'));
      if (response.data['data']['user'] != null &&
          (response.data['data']['user'] as List).isNotEmpty) {
        _currentUser =
            User.fromJson((response.data['data']['user'] as List).first);
      } else {
        throw Exception('Something went wrong');
      }

      return _currentUser!;
    } catch (e, stacktrace) {
      if (kDebugMode) {
        print('${e.toString()} $stacktrace');
      }
      rethrow;
    }
  }


  void logOut(){
    _currentUser = null;
  }
}



extension UserData on BuildContext {
  User? get user => read<UserRepository>()._currentUser;
}
