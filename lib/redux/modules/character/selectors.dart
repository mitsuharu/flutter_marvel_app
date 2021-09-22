import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

ApiParam selectCharacterApiParam(RootState state) {
  return state.character.apiParam;
}

RequestStatus selectCharacterRequestStatus(RootState state) {
  return state.character.status;
}
