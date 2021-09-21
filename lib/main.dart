import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/router/router.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/initialize_redux.dart';

AppDatabase appDatabase= AppDatabase();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await initializeRedux();

  runApp(StoreProvider(
    store: store,
    child: const MyAppRouter(),
  ));
 }
