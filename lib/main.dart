import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/initialize_redux.dart';
import 'package:flutter_marvel_app/screens/characters_list/characters_list.dart';


Future<void> main() async {
    // 必須
  WidgetsFlutterBinding.ensureInitialized();
  final store = await initializeRedux();
  
  runApp(StoreProvider(
    store: store,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
    Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue,),
        home: const CharactersListPage(),
        );
  }

}

