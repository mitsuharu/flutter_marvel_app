import 'package:flutter_marvel_app/redux/modules/user_setting/actions.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/state.dart';
import 'package:flutter_marvel_app/redux/types/swipe_action.dart';

UserSettingState userSettingReducer(UserSettingState state, dynamic action) {
  if (action is AssignUserSettingCharacterDetailSwipe) {
    return state.copyWith(characterDetailSwipe: action.swipeAction);
  }

  if (action is ToggleUserSettingCharacterDetailSwipe) {
    final nextSwipeAction = state.characterDetailSwipe == SwipeAction.back
        ? SwipeAction.pasing
        : SwipeAction.back;
    return state.copyWith(characterDetailSwipe: nextSwipeAction);
  }

  return state;
}
