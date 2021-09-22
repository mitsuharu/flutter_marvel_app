import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

CharacterState characterReducer(CharacterState state, dynamic action) {
  if (action is RequestCharacters) {
    final nextApiParam = ApiParam.initialState().copyWith(name: action.name);
    return state.copyWith(
      apiParam: nextApiParam,
      status: RequestStatus.loading,
    );
  }

  if (action is RequestCharactersSucceeded) {
    final _data = action.response?.data;
    final nextApiParam = _data != null
        ? state.apiParam.copyWith(
            offset: _data.offset,
            limit: _data.limit,
            total: _data.total,
            hasNext: (_data.offset + _data.limit) < _data.total)
        : state.apiParam;

    print(
        "nextApiParam offset: ${nextApiParam.offset}, limit: ${nextApiParam.limit}, total: ${nextApiParam.total}, hasNext: ${nextApiParam.hasNext}");

    return state.copyWith(
      apiParam: nextApiParam,
      status:
          nextApiParam.total == 0 ? RequestStatus.empty : RequestStatus.success,
    );
  }

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

  return state;
}
