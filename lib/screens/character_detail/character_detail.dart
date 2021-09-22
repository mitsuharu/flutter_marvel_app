import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

class CharacterDetailPage extends StatelessWidget {
  final String characterId;
  const CharacterDetailPage({Key? key, required this.characterId})
      : super(key: key);

  Widget seriesWidget(BuildContext context, CharacterData characterData) {
    return StreamBuilder(
        stream: appDatabase.streamCharacterSeries(characterId),
        builder: (context, AsyncSnapshot<List<SeriesData>> series) {
          if (series.data != null) {
            return Column(
                children: series.data!.map((e) => Text(e.title)).toList());
          } else {
            return const Text("series null");
          }
        });
  }

  Widget sliverList(BuildContext context, CharacterData characterData) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Visibility(
          visible: characterData.description.isNotEmpty,
          child: Text(characterData.description,
              style: GoogleFonts.carterOne(fontSize: 24))),
      seriesWidget(context, characterData),
      const SizedBox(height: 1000)
    ]));
  }

  Widget thumbnailView(BuildContext context, CharacterData characterData) {
    const noImagePath = 'lib/images/no-image.png';
    if (characterData.thumbnailUrl.isNotEmpty) {
      return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder: noImagePath,
        image: characterData.thumbnailUrl,
      );
    }
    return Image.asset(noImagePath);
  }

  Widget sliverAppBar(BuildContext context, CharacterData characterData) {
    final Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      floating: true,
      forceElevated: true,
      pinned: true,
      expandedHeight: size.height * 0.5,
      flexibleSpace: FlexibleSpaceBar(
          title: BorderedText(
              strokeWidth: 1.0,
              child: Text(
                characterData.name,
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  decorationColor: Colors.blue,
                ),
              )),
          background: thumbnailView(context, characterData)),
    );
  }

  Widget customScrollView(BuildContext context, CharacterData characterData) {
    return CustomScrollView(slivers: <Widget>[
      sliverAppBar(context, characterData),
      SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: sliverList(context, characterData),
      ),
    ]);
  }

  Widget streamWidget(BuildContext context) {
    return StreamBuilder(
        stream: appDatabase.getCharacter(characterId),
        builder: (context, AsyncSnapshot<CharacterData> character) {
          if (character.data != null) {
            return customScrollView(context, character.data!);
          } else {
            return detailEmptyView(context);
          }
        });
  }

  Widget storeBuilder(BuildContext context) {
    return StoreBuilder<RootState>(
        onInit: (store) {
          store.dispatch(RequestSeries(characterId: characterId));
        },
        builder: (context, store) => streamWidget(context));
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
      body: storeBuilder(context), //storeConnector(context),
    );
  }
}
