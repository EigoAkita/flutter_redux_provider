import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_provider/redux/reducer.dart';
import 'package:flutter_redux_provider/redux/state.dart';

class MyAppViewModel extends ChangeNotifier {
  String name = '';
  int age = 0;
  int sex = 0;
  String prefectures = '';
  String hobby = '';
  String profileImage = '';
  int currrentIndex = 0;

  final store =
      Store<AppState>(appReducer, initialState: AppState.initialState());

  void addName({@required String? name}) {
    store.dispatch(AddName(name!));
    store.onChange.listen((event) => this.name = event.name!);
    notifyListeners();
  }

  void addAge() {}

  void currentIndex({@required int? index}) {
    store.dispatch(CurrentIndex(index!));
    store.onChange.listen((event) => this.currrentIndex = event.currentIndex!);
    notifyListeners();
  }
}
