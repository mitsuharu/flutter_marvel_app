import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:meta/meta.dart';

@immutable
class CharacterState {
  final ApiParam apiParam;
  final RequestStatus status;

  const CharacterState({required this.apiParam, required this.status});

  CharacterState copyWith({
    ApiParam? apiParam,
    RequestStatus? status,
  }) {
    return CharacterState(
      apiParam: apiParam ?? this.apiParam,
      status: status ?? this.status,
    );
  }

  static initialState() {
    return CharacterState(
      apiParam: ApiParam.initialState(),
      status: RequestStatus.initial,
    );
  }
}
