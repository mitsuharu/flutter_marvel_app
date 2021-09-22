import 'package:flutter_marvel_app/api/models/characters_response.dart';

/// 初期リクエストを行う
class RequestCharacters {
  final String? name;
  RequestCharacters({this.name});
}

/// 初期リクエストが成功した
class RequestCharactersSucceeded {
  final CharactersResponse? response;
  RequestCharactersSucceeded({this.response});
}

/// 初期リクエストが失敗した
class RequestCharactersFailed {}

/// 続きのリクエストを行う
/// 完了時はRequestCharactersSucceeded, RequestCharactersFailed で併用可能
class LoadMoreCharacters {}
