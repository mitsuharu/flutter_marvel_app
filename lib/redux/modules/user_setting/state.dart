import 'package:flutter_marvel_app/redux/types/swipe_action.dart';
import 'package:meta/meta.dart';

@immutable
class UserSettingState {
  final SwipeAction characterDetailSwipe;

  const UserSettingState({required this.characterDetailSwipe});

  UserSettingState copyWith({
    SwipeAction? characterDetailSwipe,
  }) {
    return UserSettingState(
      characterDetailSwipe: characterDetailSwipe ?? this.characterDetailSwipe,
    );
  }

  static initialState() {
    return const UserSettingState(
      characterDetailSwipe: SwipeAction.back,
    );
  }
}
