import 'package:flutter_marvel_app/redux/root_reducer.dart';
import 'package:flutter_marvel_app/redux/root_saga.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_saga/redux_saga.dart';
import 'package:redux_logging/redux_logging.dart';

/// initialize redux
Future<Store<RootState>> initializeRedux() async {

  // create the saga middleware
  final sagaMiddleware = createSagaMiddleware();

  // Create store and apply middleware
  final store = Store<RootState>(
    rootReducer,
    initialState: RootState.initialState(),
    middleware: [
      applyMiddleware(sagaMiddleware), 
      LoggingMiddleware.printer(),
    ]);
    
    //connect to store
    sagaMiddleware.setStore(store);

    // then run the saga
    sagaMiddleware.run(rootSaga);
    
    return store;
}
