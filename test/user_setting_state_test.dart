import 'package:flutter_marvel_app/redux/modules/user_setting/actions.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/reducer.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/state.dart';
import 'package:flutter_marvel_app/redux/types/swipe_action.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("userSettingReducer action AssignUserSettingCharacterDetailSwipe 1 ",
      () {
    final UserSettingState state = UserSettingState.initialState();
    expect(state.characterDetailSwipe, SwipeAction.back);

    final UserSettingState nextState = userSettingReducer(state,
        AssignUserSettingCharacterDetailSwipe(swipeAction: SwipeAction.pasing));
    expect(nextState.characterDetailSwipe, SwipeAction.pasing);
  });

  test("userSettingReducer action AssignUserSettingCharacterDetailSwipe 2", () {
    final UserSettingState state = UserSettingState.initialState();
    expect(state.characterDetailSwipe, SwipeAction.back);

    final UserSettingState nextState = userSettingReducer(state,
        AssignUserSettingCharacterDetailSwipe(swipeAction: SwipeAction.back));
    expect(nextState.characterDetailSwipe, SwipeAction.back);
  });

  test("userSettingReducer action ToggleUserSettingCharacterDetailSwipe 1", () {
    final UserSettingState state = UserSettingState.initialState();
    expect(state.characterDetailSwipe, SwipeAction.back);

    final UserSettingState nextState =
        userSettingReducer(state, ToggleUserSettingCharacterDetailSwipe());
    expect(nextState.characterDetailSwipe, SwipeAction.pasing);
  });

  test("userSettingReducer action ToggleUserSettingCharacterDetailSwipe 2", () {
    const UserSettingState state =
        UserSettingState(characterDetailSwipe: SwipeAction.pasing);
    expect(state.characterDetailSwipe, SwipeAction.pasing);

    final UserSettingState nextState =
        userSettingReducer(state, ToggleUserSettingCharacterDetailSwipe());
    expect(nextState.characterDetailSwipe, SwipeAction.back);
  });
}
