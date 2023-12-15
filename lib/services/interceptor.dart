import 'package:charge_mod/services/dio_service.dart';
import 'package:dio/dio.dart';

class DioInterceptor extends InterceptorsWrapper {
  int retry = 0;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await BaseDioService.instance.getToken();
    if (token != null) {
      options.headers = {'Authorization': 'Bearer $token'};
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (retry == 1) {
        return handler.next(err);
      }
      final token = await BaseDioService.instance.getToken(true);

      err.requestOptions.headers['Authorization'] = 'Bearer $token';
      retry = 1;

      return handler
          .resolve(await BaseDioService.instance.dio.fetch(err.requestOptions));
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    retry = 0;
    super.onResponse(response, handler);
  }
}
