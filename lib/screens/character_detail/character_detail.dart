import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/screens/characters_list/list.dart';
import 'package:flutter_marvel_app/screens/characters_list/search_app_bar.dart';
import 'package:flutter_marvel_app/screens/commons/empty_view.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:bordered_text/bordered_text.dart';


class CharacterDetailPage extends StatelessWidget{
  final Result result;
  const CharacterDetailPage({Key? key, required this.result}) : super(key: key);

  Widget thumbnailView(BuildContext context, Thumbnail thumbnail){
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



  Widget sliverAppBar(BuildContext context, Thumbnail thumbnail){

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
              background: thumbnailView(context, thumbnail)            
            ),
      actions: [],
      );
  }

  Widget customScrollView(BuildContext context){
    return CustomScrollView(
    slivers: <Widget>[
      sliverAppBar(context, result.thumbnail),
      SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text("a"), const Text("b"), const SizedBox(height: 1000,)])),
      ),
    ],
);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: customScrollView(context),
    );
  }
  
}
