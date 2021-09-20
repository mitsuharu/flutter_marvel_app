import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_marvel_app/api/api.dart';

class CharacterDetailPage extends StatelessWidget{
  final String characterId;
  const CharacterDetailPage({Key? key, required this.characterId}) : super(key: key);

  Widget sliverList(BuildContext context, CharacterData characterData){
    return SliverList(delegate: SliverChildListDelegate([
      Text(characterData.description, style: GoogleFonts.carterOne(fontSize: 24)),
      const SizedBox(height: 1000)
    ])); 
  }

  Widget thumbnailView(BuildContext context, CharacterData characterData){
    const noImagePath = 'lib/images/no-image.png';
    if (characterData.thumbnailUrl.isNotEmpty){
      return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder: noImagePath,
        image: characterData.thumbnailUrl,
      );
    }
    return Image.asset(noImagePath);
  }

  Widget sliverAppBar(BuildContext context, CharacterData characterData){
    final Size size = MediaQuery.of(context).size;
    return  SliverAppBar(  
      floating: true,
      forceElevated: true,
      pinned: true,
      expandedHeight: size.height * 0.4,
      flexibleSpace: FlexibleSpaceBar(
        title: BorderedText(
          strokeWidth: 1.0,
          child: Text(characterData.name,
            style: const TextStyle(
              decoration: TextDecoration.none,
              decorationColor: Colors.blue,
            ),
          )),
        background: thumbnailView(context, characterData)            
        ),
      );
  }

  Widget customScrollView(BuildContext context, CharacterData characterData){
    return CustomScrollView(slivers: <Widget>[
      sliverAppBar(context, characterData),
      SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: sliverList(context, characterData),
      ),
    ]);
  }

  Widget streamWidget(BuildContext context){

    Api().requestCharacterSeries(characterId: characterId);
    
    return StreamBuilder(
      stream: appDatabase.getCharacter(characterId),
      builder: (context, AsyncSnapshot<CharacterData> character){
        if (character.data != null) {
          return customScrollView(context, character.data!);
        } else {
          return detailEmptyView(context);
        }
    });
  }

  Widget detailEmptyView(BuildContext context){
     return Scaffold(
      appBar: AppBar(),
      body: const EmptyView(onPress: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: streamWidget(context), //storeConnector(context),
    );
  }
}
