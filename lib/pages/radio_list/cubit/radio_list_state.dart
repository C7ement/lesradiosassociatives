import 'package:radios/models/radio.dart';

abstract class RadioListState {}

class RadioListInitial extends RadioListState {}

class RadioListLoading extends RadioListState {}

class RadioListLoaded extends RadioListState {
  RadioListLoaded({required this.radios, required this.filter});
  final List<Radio> radios;
  List<Radio> get filteredRadios =>
      [...radios].where((e) => e.website.contains(filter)).toList();
  final String filter;

  RadioListLoaded copyWith({
    List<Radio>? radios,
    String? filter,
  }) {
    return RadioListLoaded(
      radios: radios ?? this.radios,
      filter: filter ?? this.filter,
    );
  }
}

class RadioListError extends RadioListState {
  RadioListError(this.message);
  final String message;
}
