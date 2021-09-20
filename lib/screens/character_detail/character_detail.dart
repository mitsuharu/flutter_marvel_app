import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart' as ch;
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:bordered_text/bordered_text.dart';


class CharacterDetailPage extends StatelessWidget{
  final int characterId;
  const CharacterDetailPage({Key? key, required this.characterId}) : super(key: key);

  Widget sliverList(BuildContext context,){
    return SliverList(delegate: SliverChildListDelegate([
      const Text("a"),
      const Text("b"),
      const SizedBox(height: 1000)
    ])); 
  }

  Widget thumbnailView(BuildContext context, ch.Thumbnail thumbnail){
    const noImagePath = 'lib/images/no-image.png';
    if (thumbnail.path.isNotEmpty && thumbnail.extension.isNotEmpty){
      final imageUrl = thumbnail.path + "." + thumbnail.extension;
      return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        placeholder: noImagePath,
        image: imageUrl,
      );
    }
    return Image.asset(noImagePath);
  }

  Widget sliverAppBar(BuildContext context, ch.Result result){
    final Size size = MediaQuery.of(context).size;
    return  SliverAppBar(  
      floating: true,
      forceElevated: true,
      pinned: true,
      expandedHeight: size.height * 0.4,
      flexibleSpace: FlexibleSpaceBar(
        title: BorderedText(
          strokeWidth: 1.0,
          child: Text(result.name,
            style: const TextStyle(
              decoration: TextDecoration.none,
              decorationColor: Colors.blue,
            ),
          )),
        background: thumbnailView(context, result.thumbnail)            
        ),
      );
  }

  Widget customScrollView(BuildContext context, ch.Result result){
    return CustomScrollView(slivers: <Widget>[
      sliverAppBar(context, result),
      SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: sliverList(context),
      ),
    ]);
  }

 Widget storeConnector(BuildContext context){
    return StoreConnector<RootState, ch.Result?>(
      distinct: true,
      converter: (store) => store.state.character.characters.firstWhere((e) => e.id == characterId),
      builder: (context, result){
        if (result != null) {
          return customScrollView(context, result);
        }else{
          return detailEmptyView(context);
        }
      }
    );
  }

  Widget detailEmptyView(BuildContext context){
     return Scaffold(
      appBar: AppBar(),
      body: const EmptyView(onPress: null),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storeConnector(context),
    );
  }
}
