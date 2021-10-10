import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/modules/series/state.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/state.dart';
import 'package:meta/meta.dart';

@immutable
class RootState {
  final CharacterState character;
  final SeriesState series;
  final UserSettingState userSetting;
  const RootState({
    required this.character,
    required this.series,
    required this.userSetting,
  });

  RootState copyWith(
      {CharacterState? character,
      SeriesState? series,
      UserSettingState? userSetting}) {
    return RootState(
      character: character ?? this.character,
      series: series ?? this.series,
      userSetting: userSetting ?? this.userSetting,
    );
  }

  static initialState() {
    return RootState(
      character: CharacterState.initialState(),
      series: SeriesState.initialState(),
      userSetting: UserSettingState.initialState(),
    );
  }
}
