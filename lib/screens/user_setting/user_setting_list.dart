import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/actions.dart';
import 'package:flutter_marvel_app/redux/modules/user_setting/selectors.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:redux/redux.dart';

class UserSettingList extends StatelessWidget {
  final Store<RootState> store;
  const UserSettingList({Key? key, required this.store}) : super(key: key);

  Widget detailSwipeItem() {
    return SwitchListTile(
      value: selectIsCharacterDetailSwipePasing(store.state),
      title: const Text('詳細画面をスワイプで遷移する'),
      onChanged: (_) => store.dispatch(ToggleUserSettingCharacterDetailSwipe()),
    );
  }

  Widget licenseItem(BuildContext context) {
    return ListTile(
      title: const Text('ライセンス'),
      onTap: () => showLicensePage(
        context: context,
        applicationName: "flutter_marvel_app",
        applicationLegalese: '本アプリは Marvel 社の API を使用しています。',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("設定")),
        body: ListView(children: [
          detailSwipeItem(),
          licenseItem(context),
        ]));
  }
}
