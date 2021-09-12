import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';

// class SpaceBox extends SizedBox {
//   const SpaceBox({double width = 8, double height = 8})
//       : super(width: width, height: height);

//   const SpaceBox.width([double value = 8]) : super(width: value);
//   const SpaceBox.height([double value = 8]) : super(height: value);
// }


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


// class Item extends StatefulWidget {

//   final Movie movie;
//   final VoidCallback onTapCell;

//   MovieItem({required this.movie, required this.onTapCell});

//   @override
//   _MovieItemState createState() => _MovieItemState();
// }

// class _MovieItemState extends State<MovieItem> {

//   @override
//   Widget build(BuildContext context) {

//     var imageUrl = widget.movie.posterUrl(PosterSize.normal);
//     const double cartHeight = 115.0;
//     const double padding = 16.0;
//     const double imageHeight = cartHeight - padding;

    // Widget imageWidget = Image.asset('lib/images/no_poster_image.png');
    // if (imageUrl.length > 0){
    //   imageWidget = FadeInImage.assetNetwork(
    //     fit: BoxFit.cover,
    //     placeholder: 'lib/images/no_poster_image.png',
    //     image: imageUrl,
    //   );
    // }

//     return InkWell(
//       onTap: () {
//         widget.onTapCell();
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(padding),
//         child: Container(
// //        height: cartHeight,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
              // Container(
              //   height: imageHeight,
              //   width: imageHeight * 2.0/3.0,
              //   child: imageWidget,
              // ),
//               SpaceBox.width(16),

              // Expanded(child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Text(widget.movie.title,
              //           style: TextStyle(fontWeight: FontWeight.bold)),
              //       Text(widget.movie.releasedAt()),
              //       Text(widget.movie.overview,
              //         maxLines: 3,
              //         overflow: TextOverflow.ellipsis,
              //       ),]),
              // ),
//               SpaceBox.width(16),
//               Container(
//                 height: cartHeight,
//                 child: IconButton(
//                   padding: new EdgeInsets.all(0.0),
//                   icon: new Icon(Icons.event, size: 18.0), // event
//                   onPressed: (){
//                     print("add to calendar");
//                     _registerToCalendar();
//                   },
//                 ) ,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }