import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_marvel_app/database/db.dart';
import 'package:flutter_marvel_app/main.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/screens/character_detail/index.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:provider/provider.dart';

class CurrentPageStore with ChangeNotifier {
  int currentPage = 0;
  CurrentPageStore({required this.currentPage});

  void updateCurrentPage(value) {
    currentPage = value;
    notifyListeners();
  }
}

class CharactersPageView extends StatelessWidget {
  final String index;
  const CharactersPageView({Key? key, required this.index}) : super(key: key);

  void onPageChanged(
      {required BuildContext context,
      required int pageIndex,
      required int itemCount,
      required Store<RootState> store}) {
    Provider.of<CurrentPageStore>(context).updateCurrentPage(pageIndex);
    var param = selectCharacterParam(store.state);
    // 2つ前になったら、リクエストする
    if (pageIndex + 2 >= itemCount && param.hasNext) {
      store.dispatch(LoadMoreCharacters());
    }
  }

  Widget carouselSlider(
      {required BuildContext context,
      required List<CharacterData> items,
      required Store<RootState> store}) {
    return CarouselSlider.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        if (itemIndex < items.length) {
          var item = items[itemIndex];
          return CharacterDetailPage(characterId: item.id);
        } else {
          return const EmptyView();
        }
      },
      options: CarouselOptions(
        initialPage: Provider.of<CurrentPageStore>(context).currentPage,
        onPageChanged: (page, r) => onPageChanged(
            context: context,
            pageIndex: page,
            itemCount: items.length,
            store: store),
        viewportFraction: 1.0,
        aspectRatio: MediaQuery.of(context).size.aspectRatio,
      ),
    );
  }

  Widget storeWidget(BuildContext context) {
    return StoreBuilder<RootState>(
        onInit: (store) => {},
        builder: (context, store) {
          return StreamBuilder(
              stream: appDatabase.streamCharacters(),
              builder:
                  (context, AsyncSnapshot<List<CharacterData>> characters) {
                return carouselSlider(
                  store: store,
                  context: context,
                  items: characters.data ?? [],
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentPageStore(currentPage: int.parse(index)),
      child: storeWidget(context),
    );
  }
}
