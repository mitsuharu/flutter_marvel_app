import 'package:flutter_marvel_app/api/api.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart' as res; 
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:redux_saga/redux_saga.dart';

Iterable characterSaga() sync* {
  yield TakeLatest(_requestCharactersSaga, pattern: RequestCharacters);
}

Iterable _requestCharactersSaga() sync* {
  try{
    var status = Result<RequestStatus>();
    yield Select(selector: selectRequestStatus, result: status);

    if (status.value == RequestStatus.loading){
      return;
    }
    yield Put(ChangeRequestStatus(status: RequestStatus.loading));

    var param = Result<ApiParam>();
    yield Select(selector: selectApiParam, result: param);

    var response = Result<res.CharactersResponse>();
    yield Call(
      () => api.requestCharacters(offset: param.value!.count),
      result: response
    );
    yield Put(AppendCharacters(response: response.value!));

  }catch(e){
    // ignore: avoid_print
    print("characterSaga#requestCharactersSaga $e");
    yield Put(ChangeRequestStatus(status: RequestStatus.failed));
  }
}

