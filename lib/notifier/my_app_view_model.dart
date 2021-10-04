import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_provider/redux/state.dart';

class MyAppViewModel extends ChangeNotifier {
  MyAppViewModel(this.store);
  Store<AppState>? store;

  void addName({@required String? name}) {
    store!.dispatch(AddName(name!));
    store!.onChange.listen((event) => event.name!);
    notifyListeners();
  }

  void addAge() {}

  void currentIndex({@required int? index}) {
    store!.dispatch(CurrentIndex(index!));
    store!.onChange.listen((event) => event.currentIndex);
    notifyListeners();
  }
}
