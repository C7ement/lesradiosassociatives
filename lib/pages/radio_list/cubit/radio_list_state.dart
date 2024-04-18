import 'package:radios/models/radio.dart';

abstract class RadioListState {}

class RadioListInitial extends RadioListState {}

class RadioListLoading extends RadioListState {}

class RadioListLoaded extends RadioListState {
  RadioListLoaded({required this.radios});
  final List<Radio> radios;

  RadioListLoaded copyWith({
    List<Radio>? radios,
  }) {
    return RadioListLoaded(
      radios: radios ?? this.radios,
    );
  }
}

class RadioListError extends RadioListState {
  RadioListError(this.message);
  final String message;
}
