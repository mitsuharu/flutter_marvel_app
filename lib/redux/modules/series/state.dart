import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:meta/meta.dart';

@immutable
class SeriesState {
  final ApiParam apiParam;
  final RequestStatus status;

  const SeriesState({required this.apiParam, required this.status});

  SeriesState copyWith({
    ApiParam? apiParam,
    RequestStatus? status,
  }) {
    return SeriesState(
      apiParam: apiParam ?? this.apiParam,
      status: status ?? this.status,
    );
  }

  static initialState() {
    return SeriesState(
      apiParam: ApiParam.initialState(),
      status: RequestStatus.initial,
    );
  }
}
