import 'package:flutter_redux_provider/redux/action.dart';
import 'package:flutter_redux_provider/redux/state.dart';

AppState appReducer(AppState prevState, action) {
  if (action is AddName) {
    return AppState(name: action.name);
  }

  if (action is AddAge) {
    return AppState(age: action.age);
  }

  if (action is AddSex) {
    return AppState(sex: action.sex);
  }

  if (action is AddPrefectures) {
    return AppState(prefectures: action.prefectures);
  }

  if (action is AddHobby) {
    return AppState(hobby: action.hobby);
  }

  if (action is AddProfileImage) {
    return AppState(profileImage: action.profileImage);
  }

  if (action is CurrentIndex) {
    return AppState(currentIndex: action.index);
  }

  return prevState;
}
