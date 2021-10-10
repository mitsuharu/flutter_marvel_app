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

  static UserSettingState fromJson(dynamic json) {
    try {
      final int index = json["characterDetailSwipe"] as int;
      final nextCharacterDetailSwipe = SwipeAction.values[index];
      return UserSettingState(characterDetailSwipe: nextCharacterDetailSwipe);
    } catch (e) {
      // ignore: avoid_print
      print("UserSettingState#fromJson $e");
      return UserSettingState.initialState();
    }
  }

  dynamic toJson() {
    return {"characterDetailSwipe": characterDetailSwipe.index};
  }
}
