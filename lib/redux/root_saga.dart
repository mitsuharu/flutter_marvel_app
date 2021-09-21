import 'package:flutter_marvel_app/redux/modules/character/saga.dart';
import 'package:flutter_marvel_app/redux/modules/character_series/saga.dart';
import 'package:redux_saga/redux_saga.dart';

rootSaga() sync* {
  yield Fork(characterSaga);
  yield Fork(characterSeriesSaga);
}
