import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/router/router.dart';
import 'package:flutter_marvel_app/screens/characters_list/character_item.dart';
import 'package:flutter_marvel_app/screens/characters_list/search_app_bar.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_marvel_app/screens/commons/item_separater.dart';
import 'package:flutter_marvel_app/screens/commons/loading_item.dart';
import 'package:flutter_marvel_app/screens/commons/loading_view.dart';
import 'package:flutter_marvel_app/screens/commons/loki_empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({Key? key}) : super(key: key);

  void _onPress(CharacterData result, int? index) {
    try {
      if (index != null) {
        routemaster.push("/detail/characters/page/" + index.toString());
      } else {
        routemaster.push("/detail/character/" + result.id);
      }
    } on Exception {
      Fluttertoast.showToast(msg: "詳細ページの表示に失敗しました");
    }
  }

  CharacterItem renderItem(CharacterData item, int? index) {
    return CharacterItem(character: item, onPress: () => _onPress(item, index));
  }

  Widget listWidget(
      BuildContext context, List<CharacterData> items, Store<RootState> store) {
    ApiParam param = selectCharacterParam(store.state);
    final padding =
        EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom);
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >
              scrollInfo.metrics.maxScrollExtent * 0.8) {
            store.dispatch(LoadMoreCharacters());
          }
          return false;
        },
        child: RefreshIndicator(
            onRefresh: () async {
              store.dispatch(RequestCharacters());
            },
            child: ListView.builder(
              padding: padding,
              itemCount: items.length + (param.hasNext == true ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index < items.length) {
                  final item = items[index];
                  return Container(
                    decoration: itemSeparator,
                    child: renderItem(item, index),
                  );
                } else {
                  return loadingItem();
                }
              },
            )));
  }

  Widget storeWidget(BuildContext context) {
    return StoreBuilder<RootState>(
        onInit: (store) => store.dispatch(RequestCharacters()),
        builder: (context, store) {
          return StreamBuilder(
              stream: appDatabase.streamCharacters(),
              builder:
                  (context, AsyncSnapshot<List<CharacterData>> characters) {
                List<CharacterData> items = characters.data ?? [];
                RequestStatus status =
                    selectCharacterRequestStatus(store.state);
                return status.isEmpty
                    ? LokiEmptyView(
                        onPress: () =>
                            store.dispatch(RequestCharacters(name: "Loki")))
                    : (status.isLoading && items.isEmpty)
                        ? const LoadingView()
                        : listWidget(context, items, store);
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(),
      body: storeWidget(context),
    );
  }
}
