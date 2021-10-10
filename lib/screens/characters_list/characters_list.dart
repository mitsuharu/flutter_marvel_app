import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/selectors.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/router/router.dart';
import 'package:flutter_marvel_app/screens/characters_list/character_item.dart';
import 'package:flutter_marvel_app/screens/commons/item_separater.dart';
import 'package:flutter_marvel_app/screens/commons/loading_item.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:redux/redux.dart';

class CharactersList extends StatelessWidget {
  final List<CharacterData> items;
  final Store<RootState> store;

  const CharactersList({Key? key, required this.items, required this.store})
      : super(key: key);

  void _onPress(CharacterData result, int? index) {
    try {
      final isPasing = selectIsCharacterDetailSwipePasing(store.state);
      if (isPasing && index != null) {
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

  Widget listWidget(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return listWidget(context);
  }
}
