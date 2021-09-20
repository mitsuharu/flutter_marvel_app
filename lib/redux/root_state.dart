import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/modules/character_series/state.dart';
import 'package:meta/meta.dart';

@immutable
class RootState{

  final CharacterState character;
  final CharacterSeriesState characterSeries;
  const RootState({required this.character, required this.characterSeries});

  RootState copyWith({CharacterState? character, CharacterSeriesState? characterSeries}) {
    return RootState(
      character: character ?? this.character,
      characterSeries: characterSeries ?? this.characterSeries);
  }

  static initialState(){
    return RootState(
      character: CharacterState.initialState(),
      characterSeries: CharacterSeriesState.initialState());
  }
}
