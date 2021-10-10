import 'package:flutter_marvel_app/redux/root_reducer.dart';
import 'package:flutter_marvel_app/redux/root_saga.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_saga/redux_saga.dart';
import 'package:redux_logging/redux_logging.dart';

/// initialize redux
Future<Store<RootState>> initializeRedux() async {
  // create the saga middleware
  final sagaMiddleware = createSagaMiddleware();

  // create Persistor
  final persistor = Persistor<RootState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<RootState>(RootState.fromJson),
  );

  // load initial state
  final RootState state = await persistedStore(persistor);

  // create store and apply middleware
  final store = Store<RootState>(
    rootReducer,
    initialState: state,
    middleware: [
      applyMiddleware(sagaMiddleware),
      persistor.createMiddleware(),
      LoggingMiddleware.printer(),
    ],
  );

  // connect to store
  sagaMiddleware.setStore(store);

  // then run the saga
  sagaMiddleware.run(rootSaga);

  return store;
}

Future<RootState> persistedStore(Persistor<RootState> persistor) async {
  try {
    final RootState? state = await persistor.load();
    return state ?? RootState.initialState();
  } catch (e) {
    // ignore: avoid_print
    print("persistedStore $e");
    return RootState.initialState();
  }
}
