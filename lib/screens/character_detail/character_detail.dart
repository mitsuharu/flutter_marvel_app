import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/series/selectors.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/screens/character_detail/item.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_marvel_app/screens/commons/item_list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterDetailPage extends StatelessWidget {
  final String characterId;
  const CharacterDetailPage({Key? key, required this.characterId})
      : super(key: key);

  Future<void> _launchURL(String url) async {
    try {
      final value = await canLaunch(url);
      if (value) {
        launch(url);
      }
    } on Exception {
      Fluttertoast.showToast(msg: "詳細ページの表示に失敗しました");
    }
  }

  Item renderItem(SeriesData item, int? index) {
    return Item(
        series: item,
        onPress: () {
          _launchURL(item.url);
        });
  }

  Widget listWidget(BuildContext context, CharacterData characterData) {
    final characterId = characterData.id;
    return StoreBuilder<RootState>(
        onInit: (store) =>
            store.dispatch(RequestSeries(characterId: characterId)),
        builder: (context, store) {
          return StreamBuilder(
              stream: appDatabase.streamSeries(characterId),
              builder: (context, AsyncSnapshot<List<SeriesData>> series) {
                List<SeriesData> list = series.data ?? [];
                RequestStatus status = selectSeriesRequestStatus(store.state);
                return status.isEmpty
                    ? EmptyView(
                        onPress: () => store
                            .dispatch(RequestSeries(characterId: characterId)))
                    : ItemList<SeriesData, Item>(
                        items: list,
                        isLoading: status.isLoading,
                        hasNext: selectSeriesParam(store.state).hasNext,
                        renderItem: renderItem,
                        onRefresh: () => store
                            .dispatch(RequestSeries(characterId: characterId)),
                        onEndReached: () => store.dispatch(LoadMoreSeries()),
                        isNest: true,
                      );
              });
        });
  }

  Widget sliverList(BuildContext context, CharacterData characterData) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Visibility(
          visible: characterData.description.isNotEmpty,
          child: Text(characterData.description,
              style: GoogleFonts.carterOne(fontSize: 24))),
      listWidget(context, characterData),
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
