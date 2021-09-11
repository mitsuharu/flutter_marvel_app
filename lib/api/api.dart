import 'package:flutter_marvel_app/api/api_key.dart';
import 'package:flutter_marvel_app/api/error.dart';
import 'package:flutter_marvel_app/api/models/charactors_response.dart';
import 'package:flutter_marvel_app/api/models/comics_respomse.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:convert';

final api = Api();

class Api{
  final String host = "gateway.marvel.com";

  _param(int offset) {
    var ts = "1";
    var combination = ts + MarvelDev.privateKey + MarvelDev.publicKey ;
    var hash = md5.convert(utf8.encode(combination)).toString();
    return {
      "ts": ts,
      "apikey": MarvelDev.publicKey,
      "hash": hash,
      "limit": "10",
      "offset": offset.toString()};
  }

  Future<CharactorsResponse> requestCharacters({int offset = 0}) async{
    try{
      var url = Uri.https(host, "/v1/public/characters", _param(offset));
      var response = await http.get(url);
      return CharactorsResponse.fromJson(jsonDecode(response.body.toString()));
    } catch(e){
      throwIfNetworkException(e);
      rethrow;
    }
  }

  Future<ComicsResponse> requestComics({int offset = 0}) async{
    try{
      var url = Uri.https(host, "/v1/public/comics", _param(offset)); 
      var response = await http.get(url);
      return ComicsResponse.fromJson(jsonDecode(response.body.toString()));
    } catch(e){
      throwIfNetworkException(e);
      rethrow;
    }
  }
}