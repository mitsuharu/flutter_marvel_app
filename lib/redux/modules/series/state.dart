import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/series_filter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';

@immutable
class SeriesState {
  final ApiParam param;
  final SeriesFilter filter;
  final RequestStatus status;

  const SeriesState(
      {required this.param, required this.filter, required this.status});

  SeriesState copyWith({
    ApiParam? param,
    SeriesFilter? filter,
    RequestStatus? status,
  }) {
    return SeriesState(
      param: param ?? this.param,
      filter: filter ?? this.filter,
      status: status ?? this.status,
    );
  }

  static initialState() {
    return SeriesState(
      param: ApiParam.initialState(),
      filter: SeriesFilter.initialState(),
      status: RequestStatus.initial,
    );
  }
}
