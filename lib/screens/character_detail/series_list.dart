import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/series/selectors.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/screens/character_detail/series_item.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_marvel_app/screens/commons/item_separater.dart';
import 'package:flutter_marvel_app/screens/commons/loading_item.dart';
import 'package:flutter_marvel_app/screens/commons/loading_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:redux/redux.dart';

class SeriesList extends StatelessWidget {
  final String characterId;
  final Store<RootState> store;
  const SeriesList({
    Key? key,
    required this.characterId,
    required this.store,
  }) : super(key: key);

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

  Widget listWidget(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return listWidget(context);
  }
}
