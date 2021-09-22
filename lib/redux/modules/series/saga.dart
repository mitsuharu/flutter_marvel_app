import 'package:flutter_marvel_app/api/api.dart';
import 'package:flutter_marvel_app/api/error.dart';
import 'package:flutter_marvel_app/api/models/character_series_response.dart'
    as cs;
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/series/selectors.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux_saga/redux_saga.dart';

Iterable seriesSaga() sync* {
  yield TakeLeading(_requestSeriesSaga, pattern: RequestSeries);
  yield TakeLeading(_fetchSeriesSaga, pattern: LoadMoreSeries);
}

Iterable _requestSeriesSaga({dynamic action}) sync* {
  yield Try(() sync* {
    // 初期リクエストの場合はデータを削除してから取得する
    yield Call(() => appDatabase.deleteSeriesData());
    yield Call(_fetchSeriesSaga);
  }, Catch: (e, s) sync* {
    print("_requestSeriesSaga error $e");
    if (e is CustomException) {
      Fluttertoast.showToast(msg: e.message);
    }
    yield Put(RequestSeriesFailed());
  });
}

Iterable _fetchSeriesSaga({dynamic action}) sync* {
  yield Try(() sync* {
    var param = Result<ApiParam>();
    yield Select(selector: selectSeriesApiParam, result: param);
    if (param.value!.hasNext == false) {
      // 次がなければ何もしないで終了する
      yield Put(RequestSeriesSucceeded());
      return;
    }

    var offset = param.value!.offset;
    if (action is LoadMoreSeries) {
      // 続きの場合は演出の待ちを入れる（TakeLeadingの補強）
      yield Delay(const Duration(milliseconds: 100));

      // 続きの場合は offset を加算する
      offset += param.value!.limit;
    }

    var response = Result<cs.CharacterSeriesResponse>();
    yield Call(
        () => api.requestCharacterSeries(
            offset: offset, characterId: param.value!.characterId!),
        result: response);

    yield Put(RequestSeriesSucceeded(response: response.value!));
    yield Call(() {
      appDatabase.insertSeriesFromApi(
          param.value!.characterId!, response.value!.data.results);
    });
  }, Catch: (e, s) sync* {
    print("_fetchSeriesSaga error $e");
    if (e is CustomException) {
      Fluttertoast.showToast(msg: e.message);
    }
    yield Put(RequestSeriesFailed());
  });
}
