import 'package:flutter_marvel_app/redux/modules/character_series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character_series/state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

CharacterSeriesState characterSeriesReducer(CharacterSeriesState state, dynamic action) {

  if (action is ChangeRequestStatus){
    return state.copyWith(status: action.status);
  }

  if (action is DidRequestCharacterSeries){

    final nextApiParam = state.apiParam.copyWith(
      offset: action.response.data.offset,
      limit: action.response.data.limit,
      total: action.response.data.total,
      count: action.response.data.count);
    
    return state.copyWith(
      apiParam: nextApiParam,
      status: action.response.data.total == 0 ? RequestStatus.empty : RequestStatus.success,
    );
  }

  if (action is ClearAndRequestCharacterSeries){
    final nextApiParam = state.apiParam.copyWith(
      offset: 0,
      limit: 20,
      total: 0,
      count: 0);
    return state.copyWith(
      apiParam: nextApiParam,
      status: RequestStatus.initial,
    );
  }

  return state;
}