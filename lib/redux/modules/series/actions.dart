import 'package:flutter_marvel_app/api/models/character_series_response.dart';

class RequestSeries {
  final String characterId;
  RequestSeries({required this.characterId});
}

class RequestSeriesSucceeded {
  final CharacterSeriesResponse? response;
  RequestSeriesSucceeded({this.response});
}

class RequestSeriesFailed {}

class LoadMoreSeries {}
