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
  yield TakeLeading(_requestCharactersSaga, pattern: RequestCharacters);
  yield TakeLeading(_fetchCharactersSaga, pattern: LoadMoreCharacters);
}

Iterable _requestCharactersSaga({dynamic action}) sync* {
  yield Try(() sync* {
    // 初期リクエストの場合はデータを削除してから取得する
    yield Call(() => appDatabase.deleteCharacterData());
    yield Call(_fetchCharactersSaga);
  }, Catch: (e, s) sync* {
    if (e is CustomException) {
      Fluttertoast.showToast(msg: e.message);
    }
    yield Put(RequestCharactersFailed());
  });
}

Iterable _fetchCharactersSaga({dynamic action}) sync* {
  yield Try(() sync* {
    var param = Result<ApiParam>();
    yield Select(selector: selectApiParam, result: param);
    if (param.value!.hasNext == false) {
      // 次がなければ何もしないで終了する
      yield Put(RequestCharactersSucceeded());
      return;
    }

    var offset = param.value!.offset;
    if (action is LoadMoreCharacters) {
      // 続きの場合は演出の待ちを入れる（TakeLeadingの補強）
      yield Delay(const Duration(milliseconds: 100));

      // 続きの場合は offset を加算する
      offset += param.value!.limit;
    }

    var response = Result<res.CharactersResponse>();
    yield Call(
        () => api.requestCharacters(offset: offset, name: param.value!.name),
        result: response);

    yield Put(RequestCharactersSucceeded(response: response.value!));
    yield Call(() {
      appDatabase.insertCharacterFromApi(response.value!.data.results);
    });
  }, Catch: (e, s) sync* {
    if (e is CustomException) {
      Fluttertoast.showToast(msg: e.message);
    }
    yield Put(RequestCharactersFailed());
  });
}
