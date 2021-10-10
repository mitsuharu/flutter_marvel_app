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

  static RootState initialState() {
    return RootState(
      character: CharacterState.initialState(),
      series: SeriesState.initialState(),
      userSetting: UserSettingState.initialState(),
    );
  }

  static RootState fromJson(dynamic json) {
    try {
      // 永続化は userSetting のみとする
      return RootState.initialState().copyWith(
        userSetting: UserSettingState.fromJson(json["userSetting"]),
      );
    } catch (e) {
      // ignore: avoid_print
      print("RootState#fromJson $e");
      return RootState.initialState();
    }
  }

  dynamic toJson() {
    // 永続化は userSetting のみとする
    return {"userSetting": userSetting.toJson()};
  }
}
