import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/series/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

SeriesState seriesReducer(SeriesState state, dynamic action) {
  if (action is RequestSeries) {
    print("RequestSeries action.characterId: ${action.characterId}");
    final nextApiParam =
        ApiParam.initialState().copyWith(characterId: action.characterId);

    print("RequestSeries nextApiParam: ${nextApiParam.characterId}");
    return state.copyWith(
      apiParam: nextApiParam,
      status: RequestStatus.loading,
    );
  }

  if (action is RequestSeriesSucceeded) {
    final _data = action.response?.data;
    final nextApiParam = _data != null
        ? state.apiParam.copyWith(
            offset: _data.offset,
            limit: _data.limit,
            total: _data.total,
            hasNext: (_data.offset + _data.limit) < _data.total)
        : state.apiParam;
    return state.copyWith(
      apiParam: nextApiParam,
      status:
          nextApiParam.total == 0 ? RequestStatus.empty : RequestStatus.success,
    );
  }

  if (action is RequestSeriesFailed) {
    return state.copyWith(
      status: RequestStatus.failed,
    );
  }

  if (action is LoadMoreSeries) {
    return state.copyWith(
      status: RequestStatus.loading,
    );
  }

  return state;
}
