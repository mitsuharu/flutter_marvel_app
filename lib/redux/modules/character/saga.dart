import 'package:flutter_marvel_app/api/api.dart';
import 'package:flutter_marvel_app/api/error.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart' as res;
import 'package:flutter_marvel_app/main.dart'; 
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux_saga/redux_saga.dart';

Iterable characterSaga() sync* {
  yield TakeEvery(_requestCharactersSaga, pattern: RequestCharacters);
  yield TakeEvery(_searchCharactersSaga, pattern: SearchCharacters);
  yield TakeEvery(_requestCharactersSaga, pattern: ClearAndRequestCharacters);
}

Iterable _requestCharactersSaga({dynamic action}) sync* {

  yield Try(() sync* {
    var status = Result<RequestStatus>();
    yield Select(selector: selectRequestStatus, result: status);
    if (status.value == RequestStatus.loading){
      return;
    }

    var param = Result<ApiParam>();
    yield Select(selector: selectApiParam, result: param);
    if (param.value!.total > 0 && param.value!.total == param.value!.count){
      return;
    }

    yield Put(ChangeRequestStatus(status: RequestStatus.loading));

    var response = Result<res.CharactersResponse>();
    yield Call(
      () => api.requestCharacters(offset: param.value!.count, name: param.value!.name),
      result: response
    );
    
    yield Put(DideRequestCharacters(response: response.value!));
    yield Call((){
      appDatabase.insertCharacterFromApi(response.value!.data.results);
    }); 
  }, Catch: (e, s) sync* {
    // ignore: avoid_print
    print("characterSaga#requestCharactersSaga $e, $s");
    if (e is CustomException){
      Fluttertoast.showToast(msg: e.message);
    }
    var param = Result<ApiParam>();
    yield Select(selector: selectApiParam, result: param);
    if(param.value!.count == 0){
      yield Put(ChangeRequestStatus(status: RequestStatus.empty));
    }else{
      yield Put(ChangeRequestStatus(status: RequestStatus.failed));
    }
  });

}

Iterable _searchCharactersSaga({dynamic action}) sync* {
  yield Try(() sync* {

    yield Call((){
      appDatabase.deleteCharacterData();
    });


    yield Put(ClearAndRequestCharacters());
  }, Catch: (e, s) sync* {
    // ignore: avoid_print
    print("characterSaga#requestCharactersSaga $e, $s");

    if (e is CustomException){
      Fluttertoast.showToast(msg: e.message);
    }
    yield Put(ChangeRequestStatus(status: RequestStatus.failed));
  });
}
