import 'package:flutter_marvel_app/redux/modules/character/saga.dart';
import 'package:flutter_marvel_app/redux/modules/series/saga.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/saga.dart';
import 'package:redux_saga/redux_saga.dart';

rootSaga() sync* {
  yield Fork(characterSaga);
  yield Fork(seriesSaga);
  yield Fork(userSettingSaga);
}
