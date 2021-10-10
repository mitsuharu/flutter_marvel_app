import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/screens/character_detail/series_list.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redux/redux.dart';

class DetailView extends StatelessWidget {
  final CharacterData characterData;
  const DetailView({Key? key, required this.characterData}) : super(key: key);

  Widget sliverList(BuildContext context, Store<RootState> store) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Visibility(
          visible: characterData.description.isNotEmpty,
          child: Text(characterData.description,
              style: GoogleFonts.carterOne(fontSize: 24))),
      SeriesList(characterId: characterData.id, store: store),
    ]));
  }

  Widget thumbnailView() {
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

  Widget sliverAppBar(BuildContext context) {
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
          background: thumbnailView()),
    );
  }

  Widget customScrollView(BuildContext context) {
    return StoreBuilder<RootState>(
        onInit: (store) =>
            store.dispatch(RequestSeries(characterId: characterData.id)),
        builder: (context, store) {
          return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels >
                    scrollInfo.metrics.maxScrollExtent * 0.8) {
                  store.dispatch(LoadMoreSeries());
                }
                return false;
              },
              child: CustomScrollView(slivers: <Widget>[
                sliverAppBar(context),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  sliver: sliverList(context, store),
                ),
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return customScrollView(context);
  }
}
