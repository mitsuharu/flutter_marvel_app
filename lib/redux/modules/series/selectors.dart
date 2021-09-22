import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

ApiParam selectSeriesApiParam(RootState state) {
  return state.series.apiParam;
}

RequestStatus selectSeriesRequestStatus(RootState state) {
  return state.series.status;
}
