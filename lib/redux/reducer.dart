import 'package:flutter_redux_provider/redux/action.dart';
import 'package:flutter_redux_provider/redux/state.dart';

AppState appReducer(AppState prevState, action) {
  // Null Check
  // if (action is AddName) {
  //   AppState ret = AppState(name: action.name);
  //   logger.info(ret.hobby);
  //   return ret;
  // }

  if (action is AddName) {
    return prevState.copyWith(
      name: action.name,
    );
  }

  if (action is AddAge) {
    return prevState.copyWith(
      age: action.age,
    );
  }

  if (action is AddSex) {
    return prevState.copyWith(
      sex: action.sex,
    );
  }

  if (action is AddPrefectures) {
    return prevState.copyWith(
      prefectures: action.prefectures,
    );
  }

  if (action is AddHobby) {
    return prevState.copyWith(
      hobby: action.hobby,
    );
  }

  if (action is AddProfileImage) {
    return prevState.copyWith(
      profileImage: action.profileImage,
    );
  }

  if (action is CurrentIndex) {
    return prevState.copyWith(
      currentIndex: action.index,
    );
  }

  return prevState;
}
