import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/modules/character/selectors.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/router/router.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  SearchAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Widget textField(Store<RootState> store) {
    TextEditingController controller = TextEditingController();
    controller.text = selectCharacterFilter(store.state).name ?? "";

    void onChanged(String text) {
      store.dispatch(RequestCharacters(name: text));
    }

    return TextField(
      textAlign: TextAlign.center,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: 'Who is your Hero or Villain?',
        hintStyle:
            const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(32),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(32),
        ),
        // prefixIcon: const Icon(Icons.search, color: Colors.white),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onSubmitted: onChanged,
      showCursor: true,
      cursorColor: Colors.lightBlueAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<RootState>(builder: (context, store) {
      return AppBar(
        title: textField(store),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => routemaster.push("/settings")),
        ],
      );
    });
  }
}
