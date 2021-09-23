import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/character_filter.dart';
import 'package:meta/meta.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';

@immutable
class CharacterState {
  final ApiParam param;
  final CharacterFilter filter;
  final RequestStatus status;

  const CharacterState(
      {required this.param, required this.filter, required this.status});

  CharacterState copyWith({
    ApiParam? param,
    CharacterFilter? filter,
    RequestStatus? status,
  }) {
    return CharacterState(
      param: param ?? this.param,
      filter: filter ?? this.filter,
      status: status ?? this.status,
    );
  }

  static initialState() {
    return CharacterState(
      param: ApiParam.initialState(),
      filter: CharacterFilter.initialState(),
      status: RequestStatus.initial,
    );
  }
}
