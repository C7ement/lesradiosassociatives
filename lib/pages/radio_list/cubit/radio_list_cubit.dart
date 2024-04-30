import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:radios/pages/radio_list/cubit/radio_list_state.dart';
import 'package:radios/repository.dart';
import 'package:radios/util/location_service.dart';
import 'package:radios/util/require_position_permission.dart';

class RadioListCubit extends Cubit<RadioListState> {
  RadioListCubit() : super(RadioListInitial()) {
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      emit(RadioListLoading());
      final radios = await Repository().getRadios();
      emit(RadioListLoaded(
          radios: radios, textFilter: "", positionFilter: null));
    } catch (e) {
      emit(RadioListError(e.toString()));
    }
  }

  Future<void> updateTextFilter(String filter) async {
    final currentState = state;
    if (currentState is RadioListLoaded) {
      emit(currentState.copyWith(textFilter: filter));
    }
  }

  Future<void> togglePositionFilter() async {
    final currentState = state;
    if (currentState is RadioListLoaded) {
      if (currentState.positionFilter != null) {
        emit(currentState.copyWith(positionFilter: () => null));
        return;
      }
      final enabled = await requirePositionPermission();
      if (!enabled) return;
      final position = await LocationService().getPosition();
      final point = LatLng(position.latitude, position.longitude);

      emit(currentState.copyWith(positionFilter: () => point));
    }
  }
}
