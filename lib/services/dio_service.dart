import 'dart:async';

import 'package:charge_mod/services/api_path_service.dart';
import 'package:charge_mod/services/local_storage_service.dart';
import 'package:dio/dio.dart';

import 'interceptor.dart';

class BaseDioService {
  late final Dio _dio;

  Dio get dio => _dio;

  String? accessToken;

  String? refreshToken;

  int retry = 0;

  static BaseDioService instance = BaseDioService._();

  BaseDioService._() {
    _dio = Dio(
      BaseOptions(
        baseUrl:
            'https://as-uat.console.chargemod.com/temporary/sde1flutterATSR/',
      ),
    );
    _dio.interceptors.add(
      DioInterceptor(),
    );
  }

  FutureOr<String?> getToken([bool refresh = false]) async {
    try {
      if (refresh) {
        final response = await _dio.post(
          ApiService.api('refresh',appVersion:  '0.0.8'),
          data: {'refreshToken': refreshToken},
        );
        if (response.statusCode == 200) {
          accessToken = response.data['data']['accessToken'];
          refreshToken = response.data['data']['refreshToken'];
        }
        final userNewStatus =
            LocalStorageService.instance.getUserStatus()?.copyWith(
                  accessToken: accessToken,
                  refreshToken: refreshToken,
                );
        LocalStorageService.instance.addUserStatus(userNewStatus!);
      }
      final token = LocalStorageService.instance.getUserStatus()?.accessToken;
      accessToken = token;

      return accessToken;
    } catch (e) {
      return null;
    }
  }
}
