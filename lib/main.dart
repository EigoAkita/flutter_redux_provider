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
              prefectures: '',
              hobby: '',
              profileImage: '',
              currentIndex: 0,
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
  Widget build(BuildContext context) {
    final _store = Provider.of<Store<AppState>>(context);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyAppViewModel(_store),
        ),
      ],
      child: Scaffold(
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
    final model = Provider.of<MyAppViewModel>(context);
    final pageController = PageController(initialPage: 0, keepPage: true);

    logger.info("MyHomePage");

    return PageView(
      controller: pageController,
      onPageChanged: (int index) {
        model.store.state.currentIndex = index;
      },
      children: [
        UserAddNameEtcPage(store: model.store),
        UserAddHobbyEtcPage(),
        UserAddProfileImagePage(),
      ],
    );
  }
}
