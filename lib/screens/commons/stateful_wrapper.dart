import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function? onInit;
  final Function? onDispose;
  final Widget child;

  const StatefulWrapper(
      {Key? key, required this.child, this.onInit, this.onDispose})
      : super(key: key);

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  void dispose() {
    super.dispose();
    widget.onDispose?.call();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
