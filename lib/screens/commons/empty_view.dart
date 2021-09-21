import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {

  final VoidCallback? onPress;
  const EmptyView({Key? key, required this.onPress}) : super(key: key);

  final message = "見つかりませんでした";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sentiment_dissatisfied_rounded,
            color: Colors.grey,
            size: 128.0),
          Center(
            child: Text(message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 10,),
          Visibility(
            visible: onPress != null,
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: const Text('更新する'),
              onPressed: onPress,
            ),
          )
        ],
      ),
    );
  }
}