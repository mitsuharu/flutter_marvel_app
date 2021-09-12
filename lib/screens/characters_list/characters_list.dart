import 'package:flutter/material.dart';
import 'package:flutter_marvel_app/redux/types/api_param.dart';
import 'package:flutter_marvel_app/screens/characters_list/list.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_marvel_app/redux/root_state.dart';
import 'package:flutter_marvel_app/redux/modules/character/actions.dart';

class CharactersListPage extends StatelessWidget{
  const CharactersListPage({Key? key}) : super(key: key);

  Widget searchItemWidget(BuildContext context){
  return IconButton(
        icon: const Icon(Icons.search),
        onPressed: (){
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => InfoPage())
          // );
        });
}
  Widget listWidget(BuildContext context){
    return StoreBuilder<RootState>(
      onInit: (store) => store.dispatch(RequestCharacters()),
      builder: (context, store){
        return ItemList(
          items: store.state.character.characters,
          isLoading: store.state.character.status == RequestStatus.loading,
          hasNext: store.state.character.characters.length != store.state.character.apiParam.total,
          onRefresh: () => store.dispatch(RequestCharacters()),
          onEndReached: () => store.dispatch(RequestCharacters()),
          onPress: (res){} );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Characters"),
        actions: [searchItemWidget(context)],
      ),
      body: listWidget(context),
    );
  }
  
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_tmdb_app/api/error.dart';
// import 'package:flutter_tmdb_app/screens/widgets/empty_view.dart';
// import 'package:flutter_tmdb_app/screens/widgets/movie_list.dart';
// import 'package:flutter_tmdb_app/screens/movie_detail_page.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../constants.dart';
// import '../api/api.dart';
// import '../api/tmdb/movies_response.dart';
// import './info_page.dart';
// import '../api/tmdb/movie.dart';

// /// メイン（前後数か月公開の映画の一覧）です
// class MainPage extends StatefulWidget {
//   MainPage({Key? key}) : super(key: key);

//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {

//   Api api = Api();
//   int page = 1;
//   RequestStatus requestStatus = RequestStatus.initial;
//   bool hasNext = true;
//   List<Movie> movies = <Movie>[];

//   @override
//   void initState() {
//     super.initState();
//     requestAPIs(this.page);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<void> requestAPIs(int page) async{
//     try {
//       setState(() {
//         requestStatus = RequestStatus.loading;
//       });
//       MoviesResponse res = await api.requestMovies(page);
//       var nextMovies = movies + res.movies;

//       setState(() {
//         movies = nextMovies;
//         requestStatus = nextMovies.length == 0 ? RequestStatus.empty : RequestStatus.success;
//         hasNext = api.hasNext;
//       });
//     }catch(e){
//       setState(() {
//         requestStatus =  movies.length == 0 ? RequestStatus.empty : RequestStatus.failed;
//       });
//       if (e is NetworkError){
//         Fluttertoast.showToast(msg: Constant.error.networkFailed);
//       }else{
//         Fluttertoast.showToast(msg: Constant.error.unknown);
//       }
//     }
//   }

//   Future<void> _onRefresh() async{
//     try {
//       this.page = 1;
//       setState(() {
//         this.movies = <Movie>[];
//         requestStatus = RequestStatus.initial;
//         hasNext = true;
//       });
//       await requestAPIs(this.page);
//     }catch(e){
//       print("MainPage#_onRefresh $e");
//     }
//   }

//   Future<void> _onEndReached() async{
//     try{
//       if (requestStatus != RequestStatus.loading && hasNext == true) {
//         this.page += 1;
//         requestAPIs(this.page);
//       }
//     }catch(e){
//       print("MainPage#_onEndReached $e");
//     }
//   }

//   /// 詳細ページを開く
//   void _onPress(Movie movie){
//     try {
//       var page = MovieDetailPage(movie: movie,);
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => page),
//       );
//     }catch(e){
//       print("MainPage#_onPress $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {

//     Widget infoItem = IconButton(
//         icon: Icon(Icons.info),
//         onPressed: (){
//           Navigator.of(context).push(
//               MaterialPageRoute(builder: (context) => InfoPage())
//           );
//         });

//     var appBar = AppBar(
//       title: Text(Constant.app.mainTitle),
//       actions: [infoItem],
//     );

//     return Scaffold(
//       appBar: appBar,
//       body: requestStatus == RequestStatus.empty
//           ? EmptyView(onPress: (){
//             _onRefresh();
//           })
          // : MovieList(movies: movies,
          //   isLoading: requestStatus == RequestStatus.loading,
          //   hasNext: hasNext,
          //   onRefresh: _onRefresh,
          //   onEndReached: _onEndReached,
          //   onPress: _onPress,
          // )
//     );
//   }
// }
