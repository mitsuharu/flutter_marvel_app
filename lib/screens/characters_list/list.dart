import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/api/models/characters_response.dart';
import 'package:flutter_marvel_app/screens/characters_list/item.dart';

class ItemList extends StatefulWidget {

  final List<Result> items;
  final bool isLoading;
  final bool hasNext;
  final VoidCallback onRefresh;
  final VoidCallback onEndReached;
  final ValueSetter<Result> onPress;

  const ItemList({Key? key, 
    required this.items,
    required this.isLoading,
    required this.hasNext,
    required this.onRefresh,
    required this.onEndReached,
    required this.onPress,
  }) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<ItemList> {

  // スクロール検知
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // スクロールを検知したときに呼ばれる
  void _scrollListener() {
    double positionRate =
        _scrollController.offset / _scrollController.position.maxScrollExtent;
    const threshold = 0.8;
    if (positionRate > threshold) {
      widget.onEndReached();
    }
  }

  Widget movieListWidget(){
    
    if (widget.isLoading && widget.items.isEmpty){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    var listView = ListView.builder(
      controller: _scrollController,
      itemCount: widget.items.length + (widget.hasNext == true ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {

        if (index < widget.items.length){
          Result item = widget.items[index];

          return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: Item(
                result: item,
                onPress: (){
                  widget.onPress(item);
                },
              ),
          );
        }else{
          return Container(
              height: 80,
              padding: const EdgeInsets.all(8),
              child: const Card(
                  child: Center(
                    child: Text("読み込み中"),
                  )
              ));
        }
      },
    );


    return RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh();
        },
        child: listView);
  }

  @override
  Widget build(BuildContext context) {
    return movieListWidget();
  }
}
