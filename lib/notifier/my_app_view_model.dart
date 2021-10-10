import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:redux/redux.dart';

class MyAppViewModel extends ChangeNotifier {
  Store<AppState> store;
  String? inputName;

  MyAppViewModel(this.store) {
    store.onChange.listen((event) {
      logger.info("state変わったよ");
    });
  }

  void addAge({@required int? age}) {
    store.dispatch(AddAge(age!));
    store.onChange.listen((event) => event.age!);
    notifyListeners();
  }

  void addSex({@required int? sex}) {
    store.dispatch(AddSex(sex!));
    store.onChange.listen((event) => event.sex!);
    notifyListeners();
  }

  void currentIndex({@required int? index}) {
    store.dispatch(CurrentIndex(index!));
    store.onChange.listen((event) => event.currentIndex);
    notifyListeners();
  }
}
