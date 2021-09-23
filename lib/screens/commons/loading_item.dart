import 'package:flutter/material.dart';

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
