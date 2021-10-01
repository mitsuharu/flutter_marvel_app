import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/screens/character_detail/detail_view.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';

class CharacterDetailPage extends StatelessWidget {
  final String characterId;
  const CharacterDetailPage({Key? key, required this.characterId})
      : super(key: key);

  Widget streamWidget(BuildContext context) {
    return StreamBuilder(
        stream: appDatabase.getCharacter(characterId),
        builder: (context, AsyncSnapshot<CharacterData> character) {
          if (character.data != null) {
            return DetailView(characterData: character.data!);
          } else {
            return detailEmptyView(context);
          }
        });
  }

  Widget detailEmptyView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const EmptyView(onPress: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: streamWidget(context),
    );
  }
}
