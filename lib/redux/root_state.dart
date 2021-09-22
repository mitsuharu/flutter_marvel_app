import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/modules/series/state.dart';
import 'package:meta/meta.dart';

@immutable
class RootState {
  final CharacterState character;
  final SeriesState series;
  const RootState({required this.character, required this.series});

  RootState copyWith({CharacterState? character, SeriesState? series}) {
    return RootState(
        character: character ?? this.character, series: series ?? this.series);
  }

  static initialState() {
    return RootState(
        character: CharacterState.initialState(),
        series: SeriesState.initialState());
  }
}
