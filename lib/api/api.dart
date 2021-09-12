import 'package:flutter_marvel_app/api/api_key.dart';
import 'package:flutter_marvel_app/api/error.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/api/models/comics_response.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

final api = Api();

class Api{
  final String host = "gateway.marvel.com";

  _param({required int offset, int limit = 20}) {
    var ts = "1";
    var combination = ts + MarvelDev.privateKey + MarvelDev.publicKey ;
    var hash = md5.convert(utf8.encode(combination)).toString();
    return {
      "ts": ts,
      "apikey": MarvelDev.publicKey,
      "hash": hash,
      "limit": limit.toString(),
      "offset": offset.toString()};
  }

  Future<CharactersResponse> requestCharacters({int offset = 0}) async{
    try{
      var url = Uri.https(host, "/v1/public/characters", _param(offset: offset));
      var response = await http.get(url);
      return CharactersResponse.fromJson(jsonDecode(response.body.toString()));
    } catch(e){
      throwIfNetworkException(e);
      rethrow;
    }
  }

  Future<ComicsResponse> requestComics({int offset = 0}) async{
    try{
      var url = Uri.https(host, "/v1/public/comics", _param(offset: offset)); 
      var response = await http.get(url);
      return ComicsResponse.fromJson(jsonDecode(response.body.toString()));
    } catch(e){
      throwIfNetworkException(e);
      rethrow;
    }
  }
}