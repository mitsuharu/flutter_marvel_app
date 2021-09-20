import 'package:flutter_marvel_app/api/models/character_series_response.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

class RequestCharacterSeries{
  final String characterId;
  RequestCharacterSeries({required this.characterId});
}

class ChangeRequestStatus{
  final RequestStatus status;
  ChangeRequestStatus({required this.status});
}

class DidRequestCharacterSeries{
  final CharacterSeriesResponse response;
  DidRequestCharacterSeries({required this.response});
}

class ClearAndRequestCharacterSeries{
  final String characterId;
  ClearAndRequestCharacterSeries({required this.characterId});
}