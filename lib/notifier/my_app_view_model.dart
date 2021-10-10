import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:redux/redux.dart';

class MyAppViewModel extends ChangeNotifier {
  Store<AppState> store;

  MyAppViewModel(this.store) {
    store.onChange.listen(
      (event) {
        logger.info("state変わったよ");
        notifyListeners();
      },
    );
  }
}
