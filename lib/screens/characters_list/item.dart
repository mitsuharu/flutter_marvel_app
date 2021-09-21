import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';

class Item extends StatelessWidget {
  final CharacterData character;
  final VoidCallback onPress;

  const Item({Key? key, required this.character, required this.onPress}) : super(key: key);

  Widget imageWidget(){
    const noImagePath = 'lib/images/no-image.png';
    if (character.thumbnailUrl.isNotEmpty){
      return FadeInImage.assetNetwork(
        fit: BoxFit.contain,
        placeholder: noImagePath,
        image: character.thumbnailUrl,
      );
    }
    return Image.asset(noImagePath);
  }

  Widget container(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 160,
          width: 160,
          child: imageWidget(),
        ),
        const SizedBox(width: 10),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(character.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Visibility(
              visible: character.description.isNotEmpty,
              child: Text(character.description, maxLines: 3, overflow: TextOverflow.ellipsis))
          ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(child: container(context)),
      ) ,
    );
    
  }
}

