import 'package:charge_mod/models/location_model.dart';
import 'package:charge_mod/repositories/location_repostiory.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;
  LocationBloc(this._locationRepository) : super(LocationLoadingState()) {
    on<LocationFeatchEvent>(_onGetLocation);
    add(LocationFeatchEvent());
  }

  _onGetLocation(LocationFeatchEvent event, Emitter<LocationState> emit) async {
    try {
      emit(LocationLoadingState());
      final response = await _locationRepository.getChargeLocation();

      emit(LocationSuccessState(location: response));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        emit(LocationErrorState('Please check your internet connection'));
        return;
      }
      emit(LocationErrorState(e.message ?? ""));
    } catch (e) {
      emit(LocationErrorState(e.toString()));
    }
  }
}
