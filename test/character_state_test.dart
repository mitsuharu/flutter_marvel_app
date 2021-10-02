import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/reducer.dart';
import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("characterReducer action RequestCharacters ", () {
    final CharacterState state = CharacterState.initialState();
    expect(state.status, RequestStatus.initial);
    expect(state.filter.name, null);

    final CharacterState nextState =
        characterReducer(state, RequestCharacters());
    expect(nextState.status, RequestStatus.loading);
    expect(nextState.filter.name, null);
  });

  test("characterReducer action RequestCharacters with name", () {
    final CharacterState state = CharacterState.initialState();
    expect(state.status, RequestStatus.initial);
    expect(state.filter.name, null);

    final nextState = characterReducer(state, RequestCharacters(name: "loki"));
    expect(nextState.status, RequestStatus.loading);
    expect(nextState.filter.name, "loki");
  });

// characterReducer action RequestCharactersSucceeded に関して。
// CharactersResponse の mock 化を mockito で試みたけど、名前が被ったので一旦断念。
// Invalid @GenerateMocks annotation: Mockito cannot generate a mock with a name
// which conflicts with another class declared in this library: MockCharactersResponse;
// use the 'customMocks' argument in @GenerateMocks to specify a unique name.

  test("characterReducer action RequestCharactersFailed", () {
    final CharacterState state = CharacterState.initialState();
    expect(state.status, RequestStatus.initial);

    final nextState = characterReducer(state, RequestCharactersFailed());
    expect(nextState.status, RequestStatus.failed);
  });

  test("characterReducer action LoadMoreCharacters", () {
    final CharacterState state = CharacterState.initialState();
    expect(state.status, RequestStatus.initial);

    final nextState = characterReducer(state, LoadMoreCharacters());
    expect(nextState.status, RequestStatus.loading);
  });
}

/*



  if (action is RequestCharactersFailed) {
    return state.copyWith(
      status: RequestStatus.failed,
    );
  }

  if (action is LoadMoreCharacters) {
    return state.copyWith(
      status: RequestStatus.loading,
    );
  }

 */
