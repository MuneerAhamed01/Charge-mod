import 'package:charge_mod/models/location_model.dart';
import 'package:charge_mod/services/api_path_service.dart';
import 'package:dio/dio.dart';

class LocationRepository {
  final Dio _dio;

  LocationRepository({required Dio dio}) : _dio = dio;

  Future<List<Location>> getChargeLocation() async {
    try {
      final response =
          await _dio.get(ApiService.api('8.5465282/76.9151412/all-locations?limit=10&page=1'));

      if (response.statusCode == 200) {
        final location = (response.data['data']['result'] as List)
            .map((e) => Location.fromJson(e));

        return location.toList();
      }

      throw Exception('Something went wrong');
    } catch (e) {
      rethrow;
    }
  }
}
