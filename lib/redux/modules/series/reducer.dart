import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/series/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';

SeriesState seriesReducer(SeriesState state, dynamic action) {
  if (action is RequestSeries) {
    return state.copyWith(
      param: ApiParam.initialState(),
      filter: state.filter.copyWith(characterId: action.characterId),
      status: RequestStatus.loading,
    );
  }

  if (action is RequestSeriesSucceeded) {
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
