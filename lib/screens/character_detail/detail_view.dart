import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/series/actions.dart';
import 'package:flutter_marvel_app/redux/modules/series/selectors.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/screens/character_detail/series_item.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter_marvel_app/screens/commons/item_separater.dart';
import 'package:flutter_marvel_app/screens/commons/loading_item.dart';
import 'package:flutter_marvel_app/screens/commons/loading_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redux/redux.dart';

class DetailView extends StatelessWidget {
  final CharacterData characterData;
  const DetailView({Key? key, required this.characterData}) : super(key: key);

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

  SeriesItem renderItem(SeriesData item, int? index) {
    return SeriesItem(
        series: item,
        onPress: () {
          _launchURL(item.url);
        });
  }

  Widget listWidget(BuildContext context, Store<RootState> store) {
    final characterId = characterData.id;
    final padding =
        EdgeInsets.only(top: 0, bottom: MediaQuery.of(context).padding.bottom);

    return StreamBuilder(
        stream: appDatabase.streamSeries(characterId),
        builder: (context, AsyncSnapshot<List<SeriesData>> series) {
          List<SeriesData> list = series.data ?? [];
          RequestStatus status = selectSeriesRequestStatus(store.state);
          ApiParam param = selectSeriesParam(store.state);
          return status.isEmpty
              ? const EmptyView(message: "関連シリーズが見つかりませんでした")
              : (status.isLoading && list.isEmpty)
                  ? const LoadingView()
                  : ListView.builder(
                      padding: padding,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: list.length + (param.hasNext == true ? 1 : 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index < list.length) {
                          final item = list[index];
                          return Container(
                            decoration: itemSeparator,
                            child: renderItem(item, index),
                          );
                        } else {
                          return loadingItem();
                        }
                      },
                    );
        });
  }

  Widget sliverList(BuildContext context, Store<RootState> store) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Visibility(
          visible: characterData.description.isNotEmpty,
          child: Text(characterData.description,
              style: GoogleFonts.carterOne(fontSize: 24))),
      listWidget(context, store),
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
