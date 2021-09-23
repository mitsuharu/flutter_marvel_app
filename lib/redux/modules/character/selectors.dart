import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/character_filter.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';

ApiParam selectCharacterParam(RootState state) {
  return state.character.param;
}

CharacterFilter selectCharacterFilter(RootState state) {
  return state.character.filter;
}

RequestStatus selectCharacterRequestStatus(RootState state) {
  return state.character.status;
}
