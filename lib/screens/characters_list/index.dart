import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/types/request_status.dart';
import 'package:flutter_marvel_app/screens/characters_list/characters_list.dart';
import 'package:flutter_marvel_app/screens/characters_list/search_app_bar.dart';
import 'package:flutter_marvel_app/screens/commons/loading_view.dart';
import 'package:flutter_marvel_app/screens/commons/loki_empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({Key? key}) : super(key: key);

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
                        : CharactersList(items: items, store: store);
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
