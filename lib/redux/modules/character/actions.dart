import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';

class RequestCharacters{
}

class ClearAndRequestCharacters{
}

class SearchCharacters{
  final String text;
  SearchCharacters({required this.text});
}

class ChangeRequestStatus{
  final RequestStatus status;
  ChangeRequestStatus({required this.status});
}

class DideRequestCharacters{
  final CharactersResponse response;
  DideRequestCharacters({required this.response});
}