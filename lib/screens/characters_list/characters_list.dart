import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/router/router.dart';
import 'package:flutter_marvel_app/screens/characters_list/list.dart';
import 'package:flutter_marvel_app/screens/characters_list/search_app_bar.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({Key? key}) : super(key: key);

  void _onPress(CharacterData result) {
    try {
      routemaster.push("/detail/character/" + result.id);
    } on Exception {
      Fluttertoast.showToast(msg: "詳細ページの表示に失敗しました");
    }
  }

  Widget listWidget(BuildContext context) {
    return StoreBuilder<RootState>(
        onInit: (store) => store.dispatch(RequestCharacters()),
        builder: (context, store) {
          return StreamBuilder(
              stream: appDatabase.streamCharacters(),
              builder:
                  (context, AsyncSnapshot<List<CharacterData>> characters) {
                List<CharacterData> list = characters.data ?? [];
                RequestStatus status =
                    selectCharacterRequestStatus(store.state);
                return status.isEmpty
                    ? EmptyView(
                        onPress: () => store.dispatch(RequestCharacters()))
                    : ItemList(
                        items: list,
                        isLoading: status.isLoading,
                        hasNext: selectCharacterParam(store.state).hasNext,
                        onRefresh: () => store.dispatch(RequestCharacters()),
                        onEndReached: () =>
                            store.dispatch(LoadMoreCharacters()),
                        onPress: (res) => _onPress(res));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(),
      body: listWidget(context),
    );
  }
}
