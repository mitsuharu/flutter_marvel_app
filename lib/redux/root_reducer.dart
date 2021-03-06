import 'package:flutter_marvel_app/redux/modules/character/reducer.dart';
import 'package:flutter_marvel_app/redux/modules/series/reducer.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/reducer.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';

RootState rootReducer(RootState state, dynamic action) {
  return state.copyWith(
    character: characterReducer(state.character, action),
    series: seriesReducer(state.series, action),
    userSetting: userSettingReducer(state.userSetting, action),
  );
}
