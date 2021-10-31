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
    if (action.name.length > 6) {
      return prevState.copyWith(
        name: action.name,
        errorName: '名前は6文字以内です',
        isErrorName: true,
        currentIndex: 1,
      );
    }
    if (action.name.isEmpty) {
      return prevState.copyWith(
        name: action.name,
        errorName: '名前を入力してください',
        isErrorName: true,
        currentIndex: 1,
      );
    }
    return prevState.copyWith(
      name: action.name,
      errorName: '',
      isErrorName: false,
      currentIndex: 2,
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
    if (action.hobby.length > 500) {
      return prevState.copyWith(
        hobby: action.hobby,
        errorHobby: '趣味は500文字以内です',
        isErrorHobby: true,
        currentIndex: 2,
      );
    }
    if (action.hobby.isEmpty) {
      return prevState.copyWith(
        hobby: action.hobby,
        errorHobby: '趣味を入力してください',
        isErrorHobby: true,
        currentIndex: 2,
      );
    }
    return prevState.copyWith(
      hobby: action.hobby,
      errorHobby: '',
      isErrorHobby: false,
      currentIndex: 3,
    );
  }

  if (action is AddProfileImage) {
    return prevState.copyWith(
      profileImage: action.profileImage,
      currentIndex: 4,
    );
  }

  return prevState;
}
