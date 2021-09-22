import 'package:flutter_marvel_app/api/api_key.dart';
import 'package:flutter_marvel_app/api/error.dart';
import 'package:flutter_marvel_app/api/models/character_series_response.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/api/models/comics_response.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

final api = Api();

class Api {
  final String host = "gateway.marvel.com";

  _param({required int offset, int limit = 20, String? name}) {
    var ts = "1";
    var combination = ts + MarvelDev.privateKey + MarvelDev.publicKey;
    var hash = md5.convert(utf8.encode(combination)).toString();

    Map<String, String> params = {
      "ts": ts,
      "apikey": MarvelDev.publicKey,
      "hash": hash,
      "limit": limit.toString(),
      "offset": offset.toString()
    };
    if (name != null && name.isNotEmpty) {
      params["nameStartsWith"] = name;
    }
    return params;
  }

  Future<CharactersResponse> requestCharacters(
      {int offset = 0, String? name}) async {
    try {
      var url = Uri.https(
          host, "/v1/public/characters", _param(offset: offset, name: name));

      var response = await http.get(url);
      throwIfServerException(response);
      return CharactersResponse.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      print('requestCharacters error:$e');
      throw covertNetworkException(e);
    }
  }

  Future<CharactersResponse> requestCharacter(
      {required String characterId}) async {
    try {
      var url = Uri.https(
        host,
        "/v1/public/characters/" + characterId,
      );
      print('url: $url');
      var response = await http.get(url);
      throwIfServerException(response);
      return CharactersResponse.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      print('requestCharacters error:$e');
      throw covertNetworkException(e);
    }
  }

  Future<CharacterSeriesResponse> requestCharacterSeries(
      {required String characterId, int offset = 0}) async {
    try {
      var path = "/v1/public/characters/" + characterId + "/series";
      var url = Uri.https(host, path, _param(offset: offset, name: null));
      print('url: $url');
      var response = await http.get(url);
      throwIfServerException(response);
      return CharacterSeriesResponse.fromJson(
          jsonDecode(response.body.toString()));
    } catch (e) {
      print('requestCharacterSeries error:$e');
      throw covertNetworkException(e);
    }
  }

  Future<ComicsResponse> requestComics({int offset = 0}) async {
    try {
      var url = Uri.https(host, "/v1/public/comics", _param(offset: offset));
      var response = await http.get(url);
      throwIfServerException(response);
      return ComicsResponse.fromJson(jsonDecode(response.body.toString()));
    } catch (e) {
      throw covertNetworkException(e);
    }
  }
}
