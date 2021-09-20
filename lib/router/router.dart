import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/screens/character_detail/character_detail.dart';
import 'package:flutter_marvel_app/screens/characters_list/characters_list.dart';
import 'package:routemaster/routemaster.dart';

final _routes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: CharactersListPage()),
    '/detail/character/:id': (info){
      int characterId = int.parse(info.pathParameters['id']!);
      return MaterialPage(child: CharacterDetailPage(characterId: characterId));
    },
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
      theme: ThemeData(primarySwatch: Colors.blue,),
      routerDelegate: routemaster,
      routeInformationParser: const RoutemasterParser(),
    );
  }
}