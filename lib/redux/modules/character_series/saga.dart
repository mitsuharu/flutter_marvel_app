import 'package:flutter_marvel_app/api/api.dart';
import 'package:flutter_marvel_app/api/error.dart';
import 'package:flutter_marvel_app/api/models/character_series_response.dart'
    as cs;
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/character_series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character_series/selectors.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux_saga/redux_saga.dart';

Iterable characterSeriesSaga() sync* {
  yield TakeEvery(_requestCharacterSiriesSaga, pattern: RequestCharacterSeries);
  yield TakeEvery(_requestCharacterSiriesSaga,
      pattern: ClearAndRequestCharacterSeries);
}

Iterable _requestCharacterSiriesSaga({dynamic action}) sync* {
  yield Try(() sync* {
    var status = Result<RequestStatus>();

    yield Select(selector: selectRequestStatus, result: status);
    if (status.value == RequestStatus.loading) {
      return;
    }

    var param = Result<ApiParam>();
    yield Select(selector: selectApiParam, result: param);
    if (param.value!.hasNext == false) {
      return;
    }

    if (action is RequestCharacterSeries ||
        action is ClearAndRequestCharacterSeries) {
      yield Put(ChangeRequestStatus(status: RequestStatus.loading));

      var response = Result<cs.CharacterSeriesResponse>();
      yield Call(
          () => api.requestCharacterSeries(characterId: action.characterId),
          result: response);

      yield Put(DidRequestCharacterSeries(response: response.value!));
      yield Call(() {
        appDatabase.insertSeriesFromApi(
            action.characterId, response.value!.data.results);
      });
    } else {
      yield Put(ChangeRequestStatus(status: RequestStatus.failed));
    }
  }, Catch: (e, s) sync* {
    // ignore: avoid_print
    print("characterSeriesSaga#_requestCharacterSiriesSaga $e, $s");
    if (e is CustomException) {
      Fluttertoast.showToast(msg: e.message);
    }
    var param = Result<ApiParam>();
    yield Select(selector: selectApiParam, result: param);
    if (param.value!.total == 0) {
      yield Put(ChangeRequestStatus(status: RequestStatus.empty));
    } else {
      yield Put(ChangeRequestStatus(status: RequestStatus.failed));
    }
  });
}
