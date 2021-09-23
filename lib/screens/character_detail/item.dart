import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/database/db.dart';

class Item extends StatelessWidget {
  final SeriesData series;
  final VoidCallback onPress;

  const Item({Key? key, required this.series, required this.onPress})
      : super(key: key);

  Widget imageWidget() {
    const noImagePath = 'lib/images/no-image.png';
    if (series.thumbnailUrl.isNotEmpty) {
      return FadeInImage.assetNetwork(
        fit: BoxFit.contain,
        placeholder: noImagePath,
        image: series.thumbnailUrl,
      );
    }
    return Image.asset(noImagePath);
  }

  Widget container(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: imageWidget(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(series.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Visibility(
                visible: series.description.isNotEmpty,
                child: Text(series.description,
                    maxLines: 2, overflow: TextOverflow.ellipsis))
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
      ),
    );
  }
}
