import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/redux/types/series_filter.dart';

ApiParam selectSeriesParam(RootState state) {
  return state.series.param;
}

SeriesFilter selectSeriesFilter(RootState state) {
  return state.series.filter;
}

RequestStatus selectSeriesRequestStatus(RootState state) {
  return state.series.status;
}
