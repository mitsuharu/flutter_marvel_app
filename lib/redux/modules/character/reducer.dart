import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';

CharacterState characterReducer(CharacterState state, dynamic action) {
  if (action is RequestCharacters) {
    final nextFilter = state.filter.copyWith(name: action.name);
    return state.copyWith(
      param: ApiParam.initialState(),
      filter: nextFilter,
      status: RequestStatus.loading,
    );
  }

  if (action is RequestCharactersSucceeded) {
    final _data = action.response?.data;
    final nextParam = _data != null
        ? state.param.copyWith(
            offset: _data.offset,
            limit: _data.limit,
            total: _data.total,
            hasNext: (_data.offset + _data.limit) < _data.total)
        : state.param;
    final nexStatus =
        nextParam.total == 0 ? RequestStatus.empty : RequestStatus.success;
    return state.copyWith(
      param: nextParam,
      status: nexStatus,
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
