import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/screens/characters_list/list.dart';
import 'package:flutter_marvel_app/screens/characters_list/search_app_bar.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';

class CharactersListPage extends StatelessWidget{
  const CharactersListPage({Key? key}) : super(key: key);

  Widget listWidget(BuildContext context){
    return StoreBuilder<RootState>(
      onInit: (store) => store.dispatch(RequestCharacters()),
      builder: (context, store){
        return store.state.character.status == RequestStatus.empty
        ? EmptyView(onPress:  () => store.dispatch(ClearAndRequestCharacters()))
        : ItemList(
          items: store.state.character.characters,
          isLoading: store.state.character.status == RequestStatus.loading,
          hasNext: store.state.character.characters.length != store.state.character.apiParam.total,
          onRefresh: () => store.dispatch(ClearAndRequestCharacters()),
          onEndReached: () => store.dispatch(RequestCharacters()),
          onPress: (res){} );
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
