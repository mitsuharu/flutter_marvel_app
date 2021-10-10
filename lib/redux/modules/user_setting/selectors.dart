import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/swipe_action.dart';

SwipeAction selectCharacterDetailSwipe(RootState state) {
  return state.userSetting.characterDetailSwipe;
}

bool selectIsCharacterDetailSwipePasing(RootState state) {
  return selectCharacterDetailSwipe(state) == SwipeAction.pasing;
}
