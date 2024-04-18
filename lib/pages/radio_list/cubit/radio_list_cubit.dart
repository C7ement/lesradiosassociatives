import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radios/pages/radio_list/cubit/radio_list_state.dart';
import 'package:radios/repository.dart';

class RadioListCubit extends Cubit<RadioListState> {
  RadioListCubit() : super(RadioListInitial()) {
    fetchExercises();
  }

  Future<void> fetchExercises() async {
    try {
      emit(RadioListLoading());
      final radios = await Repository().getRadios();
      emit(RadioListLoaded(radios: radios));
    } catch (e) {
      emit(RadioListError(e.toString()));
    }
  }
}
