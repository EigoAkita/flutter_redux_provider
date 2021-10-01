import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:flutter_redux_provider/redux/reducer.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  //MyApp生成時にStoreも生成させる（コンストラクタ処理の為、runAppした時に初期化されて実行する）
  MyApp()
      : store = Store<AppState>(
          appReducer,
          initialState: AppState.initialState(),
        );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(store),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Store<AppState> store;
  MyHomePage(this.store);

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //StoreにアクセスしてStateやActionを使ってViewを作る
    return StoreConnector<AppState, MyAppViewModel>(
      // Store から必要な要素を _ViewModel に集約します
      converter: (store) {
        return MyAppViewModel(
          name: store.state.name,
          age: store.state.age,
          sex: store.state.sex,
          prefectures: store.state.prefectures,
          hobby: store.state.hobby,
          profileImage: store.state.profileImage,
          currentIndex: store.state.currentIndex,
        );
      },
      // converter が作ってくれた viewModel で View を作成していきます
      builder: (BuildContext context, MyAppViewModel model) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'flutter_redux_provider',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('${model.name}'),
              TextField(
                controller: controller,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: TextButton(
                  onPressed: () {
                    store.dispatch(AddName(controller.text));
                  },
                  child: Text('名前を入力'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
