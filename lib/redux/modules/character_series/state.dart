import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:meta/meta.dart';

@immutable
class CharacterSeriesState{
  final ApiParam apiParam;
  final RequestStatus status;

  const CharacterSeriesState({
    required this.apiParam,
    required this.status});

  CharacterSeriesState copyWith({
    ApiParam? apiParam,
    RequestStatus? status,
  }) {
    return CharacterSeriesState(
      apiParam: apiParam ?? this.apiParam,
      status: status ?? this.status,
      );
  }

  static initialState(){
    return CharacterSeriesState(
      apiParam: ApiParam.initialState(),
      status: RequestStatus.initial,
      );
  }
}