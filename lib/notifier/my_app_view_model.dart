import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:redux/redux.dart';

class MyAppViewModel extends ChangeNotifier {
  Store<AppState> store;
  final PageController pageController;

  MyAppViewModel(
    this.store,
    this.pageController,
  ) {
    store.onChange.listen(
      (_event) {
        logger.info("state変わったよ");
        notifyListeners();
      },
    );
  }
}
