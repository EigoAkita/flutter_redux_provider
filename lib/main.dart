import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/reducer.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:flutter_redux_provider/view/user_add_hobby_etc_page.dart';
import 'package:flutter_redux_provider/view/user_add_name_etc_page.dart';
import 'package:flutter_redux_provider/view/user_add_profile_image_page.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StoreProvider(
        store: Store<AppState>(
          appReducer,
          initialState: AppState.initialState(),
        ),
        child: ChangeNotifierProvider<MyAppViewModel>(
          create: (context) => MyAppViewModel(),
          child: const MyHomePage(),
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
            model.currrentIndex = index;
          },
          children: [
            UserAddNameEtcPage(),
            UserAddHobbyEtcPage(),
            UserAddProfileImagePage(),
          ],
        ));
  }
}
