import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

CharacterState characterReducer(CharacterState state, dynamic action) {

  if (action is ChangeRequestStatus){
    return state.copyWith(status: action.status);
  }

  if (action is AppendCharacters){
    final nextCharacters = [...state.characters, ...action.response.data.results];
    final nextApiParam = ApiParam(
      offset: action.response.data.offset,
      limit: action.response.data.limit,
      total: action.response.data.total,
      count: action.response.data.count);
    
    return state.copyWith(
      characters: nextCharacters,
      apiParam: nextApiParam,
      status: RequestStatus.success,
    );
  }

  return state;
}