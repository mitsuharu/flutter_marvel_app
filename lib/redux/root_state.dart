import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:meta/meta.dart';

@immutable
class RootState{

  final CharacterState character;
  const RootState({required this.character});

  RootState copyWith({CharacterState? character}) {
    return RootState(character: character ?? this.character);
  }

  static initialState(){
    return RootState(character: CharacterState.initialState());
  }
}
