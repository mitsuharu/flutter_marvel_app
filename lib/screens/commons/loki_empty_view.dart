import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LokiEmptyView extends HookWidget {
  final String message;
  final VoidCallback? onPress;
  const LokiEmptyView({Key? key, this.message = "見つかりませんでした", this.onPress})
      : super(key: key);

  Widget component(BuildContext context) {
    final animationController = useAnimationController();
    final visibleLottie = useState<bool>(false);
    final lokiMessage = useState<String>(message);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        onPress?.call();
      }
    });

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sentiment_dissatisfied_rounded,
              color: Colors.grey, size: 128.0),
          Center(
            child: Text(
              lokiMessage.value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Visibility(
            visible: onPress != null,
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: const Text('更新する'),
              onPressed: (visibleLottie.value == false
                  ? () {
                      visibleLottie.value = true;
                      lokiMessage.value = "ロキが現れた！！";
                      animationController
                        ..duration = const Duration(seconds: 3)
                        ..reset()
                        ..forward();
                    }
                  : null),
            ),
          ),
          Visibility(
            visible: visibleLottie.value,
            child: Lottie.asset(
              "lib/assets/65319-loki-stiker.json",
              controller: animationController,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return component(context);
  }
}
