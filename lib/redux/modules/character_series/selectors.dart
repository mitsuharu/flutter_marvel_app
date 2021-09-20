import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

ApiParam selectApiParam(RootState state) {
  return state.characterSeries.apiParam;
}

RequestStatus selectRequestStatus(RootState state) {
  return state.characterSeries.status;
}