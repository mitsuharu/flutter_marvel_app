import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';

class Item extends StatelessWidget {
  final Result result;
  final VoidCallback onPress;

  const Item({Key? key, required this.result, required this.onPress}) : super(key: key);

  Widget imageWidget(Thumbnail thumbnail){
    const noImagePath = 'lib/images/no-image.png';
    if (thumbnail.path.isNotEmpty && thumbnail.extension.isNotEmpty){
      final imageUrl = thumbnail.path + "." + thumbnail.extension;
      return FadeInImage.assetNetwork(
        fit: BoxFit.contain,
        placeholder: noImagePath,
        image: imageUrl,
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
                child: imageWidget(result.thumbnail),
              ),
        const SizedBox(width: 10),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(result.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(result.description, maxLines: 3, overflow: TextOverflow.ellipsis),
          ]),
        ),
              
        // Text(result.thumbnail.path + result.thumbnail.extension),
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

