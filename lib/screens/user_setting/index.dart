import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/screens/user_setting/user_setting_list.dart';
import 'package:flutter_redux/flutter_redux.dart';

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<RootState>(
      builder: (context, store) => UserSettingList(store: store),
    );
  }
}
