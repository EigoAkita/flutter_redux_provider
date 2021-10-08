import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux_provider/redux/state.dart';

class MyAppViewModel extends ChangeNotifier {
  MyAppViewModel(this.store);
  Store<AppState>? store;
  String? inputName;

  void addName({@required String? name}) {
    store!.dispatch(AddName(name!));
    store!.onChange.listen((event) => this.inputName = event.name!);
    // notifyListeners();
  }

  void addAge({@required int? age}) {
    store!.dispatch(AddAge(age!));
    store!.onChange.listen((event) => event.age!);
    notifyListeners();
  }

  void addSex({@required int? sex}) {
    store!.dispatch(AddSex(sex!));
    store!.onChange.listen((event) => event.sex!);
    notifyListeners();
  }

  void currentIndex({@required int? index}) {
    store!.dispatch(CurrentIndex(index!));
    store!.onChange.listen((event) => event.currentIndex);
    notifyListeners();
  }
}
