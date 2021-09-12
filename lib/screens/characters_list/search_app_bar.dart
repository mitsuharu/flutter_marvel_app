import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {

  SearchAppBar({Key? key}) : super(key: key) ;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
  Widget textField (ValueSetter<String> onChanged) {  
    return TextField(
      textAlign: TextAlign.center, 
      decoration: InputDecoration(
        hintText: 'Who is your Heroes or Villains?',
        hintStyle: const TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0)),
          ),  
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),  
      ),
      style: const TextStyle(color: Colors.white,),
      onSubmitted: onChanged,
      showCursor: true,
      cursorColor: Colors.white,
      );
  }

  @override
  Widget build(BuildContext context) {
      return StoreConnector<RootState, ValueSetter<String>>(
      distinct: true,
      converter: (store) => (text) => store.dispatch(SearchCharacters(text: text)),
      builder: (context, onChanged){
        return AppBar(title: textField(onChanged));
      },
    );
  }
}
