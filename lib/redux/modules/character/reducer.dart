import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

CharacterState characterReducer(CharacterState state, dynamic action) {

  if (action is ChangeRequestStatus){
    return state.copyWith(status: action.status);
  }

  if (action is AppendCharacters){
    final nextCharacters = [...state.characters, ...action.response.data.results];

print('characterReducer#AppendCharacters count: ${action.response.data.count}');

    final nextApiParam = state.apiParam.copyWith(
      offset: action.response.data.offset,
      limit: action.response.data.limit,
      total: action.response.data.total,
      count: action.response.data.count);
    
    return state.copyWith(
      characters: nextCharacters,
      apiParam: nextApiParam,
      status: nextCharacters.isEmpty ? RequestStatus.empty : RequestStatus.success,
    );
  }

  if (action is SearchCharacters){
    final nextApiParam = state.apiParam.copyWith(name: action.text);
    return state.copyWith(
      apiParam: nextApiParam,
    );
  }

  if (action is ClearAndRequestCharacters){
    final nextApiParam = state.apiParam.copyWith(
      offset: 0,
      limit: 20,
      total: 0,
      count: 0);
    return state.copyWith(
      characters: [],
      apiParam: nextApiParam,
      status: RequestStatus.initial,
    );
  }


  return state;
}