import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/screens/character_detail/index.dart';
import 'package:flutter_marvel_app/screens/characters_list/characters_list.dart';
import 'package:flutter_marvel_app/screens/characters_page_view/characters_page_view.dart';
import 'package:routemaster/routemaster.dart';

final _routes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: CharactersListPage()),
    '/detail/character/:id': (info) {
      return MaterialPage(
          child: CharacterDetailPage(characterId: info.pathParameters['id']!));
    },
    "/detail/characters/page/:index": (info) {
      return MaterialPage(
          child: CharactersPageView(index: info.pathParameters['index']!));
    }
  },
);

final routemaster = RoutemasterDelegate(
  routesBuilder: (context) => _routes,
);

class MyAppRouter extends StatelessWidget {
  const MyAppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: routemaster,
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
