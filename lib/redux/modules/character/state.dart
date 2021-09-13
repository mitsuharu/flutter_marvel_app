import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:meta/meta.dart';

@immutable
class CharacterState{
  final List<Result> characters;
  final ApiParam apiParam;
  final RequestStatus status;

  const CharacterState({
    required this.characters,
    required this.apiParam,
    required this.status});

  CharacterState copyWith({
    List<Result>? characters,
    ApiParam? apiParam,
    RequestStatus? status,
  }) {
    return CharacterState(
      characters: characters ?? this.characters,
      apiParam: apiParam ?? this.apiParam,
      status: status ?? this.status,
      );
  }

  static initialState(){
    return CharacterState(
      characters: const [],
      apiParam: ApiParam.initialState(),
      status: RequestStatus.initial,
      );
  }
}