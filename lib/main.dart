import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/reducer.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:flutter_redux_provider/view/user_add_hobby_etc_page.dart';
import 'package:flutter_redux_provider/view/user_add_name_etc_page.dart';
import 'package:flutter_redux_provider/view/user_add_profile_image_page.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

void main() {
  logger.setLevel(
    Level.ALL,
    includeCallerInfo: true,
  );
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      name: '',
      age: 0,
      sex: 0,
      prefectures: '',
      hobby: '',
      profileImage: '',
      currentIndex: 0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => store,
        ),

        //データの受け渡しだけ行いたい場合
        Provider(create: (context) => MyAppViewModel(store)),

        //NotifyListeners();で変更した値でWidgetを再構築
        // ChangeNotifierProvider(
        //   create: (context) => MyAppViewModel(store),
        // ),
      ],
      child: MaterialApp(
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MyAppViewModel>(context);
    final pageController = PageController(initialPage: 0, keepPage: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'flutter_redux_provider',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {
          model.store!.state.currentIndex = index;
        },
        children: [
          UserAddNameEtcPage(),
          UserAddHobbyEtcPage(),
          UserAddProfileImagePage(),
        ],
      ),
    );
  }
}
