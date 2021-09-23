import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef WidgetCallback<T, W extends Widget> = W Function(T value, int? index);

/// ListViewの改修
/// onRefresh や onEndReached とかを足してる
class ItemList<T, W extends Widget> extends StatefulWidget {
  final List<T> items;
  final bool isLoading;
  final bool hasNext;
  final VoidCallback? onRefresh;
  final VoidCallback? onEndReached;
  final WidgetCallback<T, W> renderItem;
  final bool isNest;

  const ItemList({
    Key? key,
    required this.items,
    required this.isLoading,
    required this.hasNext,
    required this.onRefresh,
    required this.onEndReached,
    required this.renderItem,
    this.isNest = false,
  }) : super(key: key);

  @override
  _ItemListState<T, W> createState() => _ItemListState<T, W>();
}

class _ItemListState<T, W extends Widget> extends State<ItemList<T, W>> {
  /// スクロール検知（StatefulWidgetじゃないと動かない？）
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

  /// スクロールを検知したときに呼ばれる
  void _scrollListener() {
    double positionRate =
        _scrollController.offset / _scrollController.position.maxScrollExtent;
    const threshold = 0.8;

    print("_scrollListener positionRate: $positionRate, threshold: $threshold");

    if (positionRate > threshold) {
      widget.onEndReached?.call();
    }
  }

  /// ローディングセル
  Widget loadingItem() {
    return Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        child: Card(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
            SizedBox(width: 10),
            Text("読み込み中")
          ],
        )));
  }

  /// item のセパレーター
  final separator = const BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 1.0, color: Colors.black26),
    ),
  );

  Widget listWidget() {
    if (widget.isLoading && widget.items.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    var listView = ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: widget.isNest,
      physics: widget.isNest ? const NeverScrollableScrollPhysics() : null,
      controller: _scrollController,
      itemCount: widget.items.length + (widget.hasNext == true ? 1 : 0),
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.items.length) {
          final item = widget.items[index];
          return Container(
            decoration: separator,
            child: widget.renderItem(item, index),
          );
        } else {
          return loadingItem();
        }
      },
    );

    return RefreshIndicator(
        onRefresh: () async {
          widget.onRefresh?.call();
        },
        child: listView);
  }

  @override
  Widget build(BuildContext context) {
    return listWidget();
  }
}
