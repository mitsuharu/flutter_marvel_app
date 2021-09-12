import 'dart:io';
import 'package:http/http.dart' as http;

class CustomException implements Exception {
  final String message;
  final String _type;

  CustomException(this.message, this._type);

  @override
  String toString() {
    if (message.isEmpty){
      return _type;
    }
    return "$_type: $message";
  }
}

const msgNetwork = "ネットワークに接続できませんでした。ネットワーク設定の確認、または時間をおいて再度お試しください。";
const msgTimeout = "接続タイムアウトが発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。";
const msgFetch = "データ取得に問題が発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。";
const msgBadRequest = "リクエストに問題が発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。";
const msgUnauthorised = "リクエスト認証に問題が発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。";
const msgInvalidInput = "リクエストの設定に問題が発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。";
const msgUnknown = "不明な問題が発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。";

class NetworkException extends CustomException {
  NetworkException([message = msgNetwork]): super(message, "Network failed");
}

class TimeoutException extends CustomException {
  TimeoutException([message = msgTimeout]): super(message, "Timeout");
}

class FetchDataException extends CustomException {
  FetchDataException([message = msgFetch])
      : super(message, "Exception During Communication");
}

class BadRequestException extends CustomException {
  BadRequestException([message = msgBadRequest]) : super(message, "Invalid Request");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message = msgUnauthorised]) : super(message, "Unauthorised");
}

class InvalidInputException extends CustomException {
  InvalidInputException([message = msgInvalidInput ]) : super(message, "Invalid Input");
}

class UnknownException extends CustomException {
  UnknownException([message = msgUnknown]) : super(message, "Unknown");
}

void throwIfServerException(http.Response response) {
  switch (response.statusCode) {
    case 200:
      break;
    case 400:
      throw BadRequestException();
    case 401:
    case 403:
      throw UnauthorisedException();
    case 500:
    default:
      throw FetchDataException();
  }
}

dynamic covertNetworkException(dynamic e) {
  if (e is SocketException){
    return NetworkException();
  }
  if (e is TimeoutException){
    return TimeoutException();
  }

  return UnknownException("エラーが発生した。ネットワーク設定の確認、または時間をおいて再度お試しください。");
}