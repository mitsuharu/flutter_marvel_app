import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

List<Result> selectCharacters(RootState state) {
  return state.character.characters;
}

int selectCharacterCount(RootState state) {
  return state.character.characters.length;
}

ApiParam selectApiParam(RootState state) {
  return state.character.apiParam;
}

RequestStatus selectRequestStatus(RootState state) {
  return state.character.status;
}