import 'package:latlong2/latlong.dart';
import 'package:radios/extensions/distance_to.dart';
import 'package:radios/models/radio.dart';

abstract class RadioListState {}

class RadioListInitial extends RadioListState {}

class RadioListLoading extends RadioListState {}

class RadioListLoaded extends RadioListState {
  RadioListLoaded({
    required this.radios,
    required this.textFilter,
    required this.positionFilter,
  });
  final List<Radio> radios;
  final LatLng? positionFilter;
  List<Radio> get filteredRadios => [...radios]
      .where((e) => e.name.contains(textFilter))
      .where((e) => positionFilter == null
          ? true
          : e.position.distanceTo(positionFilter!) < 50000)
      .toList();
  final String textFilter;

  RadioListLoaded copyWith({
    List<Radio>? radios,
    String? textFilter,
    LatLng? Function()? positionFilter,
  }) {
    return RadioListLoaded(
      radios: radios ?? this.radios,
      textFilter: textFilter ?? this.textFilter,
      positionFilter:
          positionFilter == null ? this.positionFilter : positionFilter(),
    );
  }
}

class RadioListError extends RadioListState {
  RadioListError(this.message);
  final String message;
}
