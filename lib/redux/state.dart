// class AppState {
//   final String? name;
//   final int? age;
//   final int? sex;
//   final String? prefectures;
//   final String? hobby;
//   final String? profileImage;
//   int? currentIndex;

//   AppState({
//     this.name,
//     this.age,
//     this.sex,
//     this.prefectures,
//     this.hobby,
//     this.profileImage,
//     this.currentIndex,
//   });

//   AppState.initialState()
//       : name = '',
//         age = 0,
//         sex = 0,
//         prefectures = '',
//         hobby = '',
//         profileImage = '',
//         currentIndex = 0;
// }

import 'package:flutter/material.dart';

class AppState {
  final String? name;
  final int? age;
  final int? sex;
  final String? prefectures;
  final String? hobby;
  final String? profileImage;
  int? currentIndex;

  AppState({
    @required this.name,
    @required this.age,
    @required this.sex,
    @required this.prefectures,
    @required this.hobby,
    @required this.profileImage,
    @required this.currentIndex,
  });

  //全て一から新しいStateを作るのではなく、今のStateから変更しないものはコピーして、
  //変更する値だけ変更するという形をとっています。
  //name ?? this.nameの部分が、
  //copyWithメソッドに値が渡されなかったものは今の値を使うという実装です。

  AppState copyWith({
    String? name,
    final int? age,
    final int? sex,
    final String? prefectures,
    final String? hobby,
    final String? profileImage,
    int? currentIndex,
  }) {
    return AppState(
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      prefectures: prefectures ?? this.prefectures,
      hobby: hobby ?? this.hobby,
      profileImage: profileImage ?? this.profileImage,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
