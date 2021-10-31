import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/reducer.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:flutter_redux_provider/view/registration_confirmation_screen_page.dart';
import 'package:flutter_redux_provider/view/user_add_hobby_etc_page.dart';
import 'package:flutter_redux_provider/view/user_add_name_etc_page.dart';
import 'package:flutter_redux_provider/view/user_add_profile_image_page.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:simple_logger/simple_logger.dart';

//class内に定義などして居らず、一つの変数として扱われる為、どこからでもアクセス可能
final logger = SimpleLogger()
  ..setLevel(
    Level.ALL,
    includeCallerInfo: true,
  );

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => Store<AppState>(
            appReducer,
            initialState: AppState(
              name: '',
              age: 18,
              sex: 0,
              prefectures: '愛知県',
              hobby: '',
              profileImage: null,
              currentIndex: 1,
              errorName: '',
              isErrorName: false,
              errorHobby: '',
              isErrorHobby: false,
            ),
          ),
        ),
      ],
      child: MaterialApp(
        home: Providers(),
      ),
    );
  }
}

class Providers extends StatelessWidget {
  const Providers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _context) {
    //ここで変数宣言している時点でAppStateの初期値は入っている

    //privete引数とは...他クラスやメソッドに同じ変数名がある、しかしvoidメソッド内で同じ変数名を定義したい
    //その際に、変数の前に_をつける事により、他クラスやメソッドからアクセス出来なくなる。

    final _store = Provider.of<Store<AppState>>(_context);
    final _pageController = PageController(keepPage: false);

    return MultiProvider(
      providers: [
        //_storeのインスタンスをmodelのコンストラクタに渡してcreate
        ChangeNotifierProvider(
          create: (context) => MyAppViewModel(
            _store,
            _pageController,
          ),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: MyHomePage(),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            'flutter_redux_provider',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ここのlisten:falseが抜けるとTextFormFieldの挙動がおかしくなった。
    //listen:falseにする事により、リビルドを防止できる
    final model = Provider.of<MyAppViewModel>(context, listen: false);

    //初期値が入っているAppStateのインスタンス（store）をコンストラクタに渡してあげる
    List<StatelessWidget> _pageViewList = [
      UserAddNameEtcPage(
        store: model.store,
      ),
      UserAddHobbyEtcPage(
        store: model.store,
      ),
      UserAddProfileImagePage(
        store: model.store,
      ),
      RegistrationConfirmationScreenPage(
        store: model.store,
      ),
    ];

    logger.info("MyHomePage");

    logger.info(model.store.state.currentIndex);

    return Consumer<MyAppViewModel>(builder: (_context, _model, _child) {
      return PageView.builder(
        itemBuilder: (context, index) {
          return _pageViewList[index];
        },
        itemCount: _model.store.state.currentIndex,
        controller: _model.pageController,
      );
    });
  }
}
