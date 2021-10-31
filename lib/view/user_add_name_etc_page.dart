import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:provider/provider.dart';

class UserAddNameEtcPage extends StatelessWidget {
  final store;

  UserAddNameEtcPage({
    Key? key,
    this.store,
  }) : super(key: key);

  //MyHomePageから渡されたインスタンスをコンストラクタで初期化して、使用可能にする。
  //lateはstoreの処理の際に必須。lateとは、lateと定義した変数はその変数が使用されない
  //限り、初期化もされないのでコスト削減に繋がる。
  late final _controller = TextEditingController(text: store.state.name);

  @override
  Widget build(BuildContext context) {
    //前提として全てProvider.ofを定義する時は、listen:falseでリビルド防止。変更が可視化
    //例えば、カウンターアプリの数値とかはCousumerでラップしてあげて、変更が通知されたら
    //Widgetをリビルドするなど使い分けが重要

    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      color: Colors.teal,
      fontSize: 13.5,
    );
    final _bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    logger.info("UserAddNameEtcPage");
    logger.info(store.state.name);

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            reverse: false,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: _bottomSpace,
              ),
              child: GestureDetector(
                onTap: () {
                  //TextFieldのフォーカスを正しく外す方法
                  final FocusScopeNode currentScope = FocusScope.of(context);
                  if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
                    FocusManager.instance.primaryFocus!.unfocus();
                  }
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Text('名前', style: _titleStyle),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 45,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextFormField(
                              onChanged: (text) {
                                logger.info("onChangedText");
                                _model.store.dispatch(AddName(text));
                              },
                              controller: _controller,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration.collapsed(
                                hintText: '山田 太郎',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.5,
                          ),
                          Consumer<MyAppViewModel>(builder: (
                            _context,
                            _model,
                            _child,
                          ) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _model.store.state.isErrorName!
                                    ? Text(
                                        '${_model.store.state.errorName}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                        ),
                                      )
                                    : SizedBox(),
                                _model.store.state.isErrorName!
                                    ? Text(
                                        '${_model.store.state.name!.length}/6',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                        ),
                                      )
                                    : Text(
                                        '${_model.store.state.name!.length}/6',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                              ],
                            );
                          }),
                          SizedBox(
                            height: 50,
                          ),
                          Text('年齢', style: _titleStyle),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Consumer<MyAppViewModel>(
                                  builder: (
                                    _context,
                                    _model,
                                    _child,
                                  ) {
                                    return DropdownButton<int>(
                                      items: <int>[
                                        18,
                                        19,
                                        20,
                                        21,
                                        22,
                                        23,
                                        24,
                                        25,
                                      ].map((int value) {
                                        return DropdownMenuItem<int>(
                                          value: value,
                                          child: Text(
                                            value.toString(),
                                          ),
                                        );
                                      }).toList(),
                                      isDense: true,
                                      value: _model.store.state.age,
                                      onChanged: (value) {
                                        logger.info(value);
                                        _model.store.dispatch(
                                          AddAge(value!),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '歳',
                                style: _titleStyle!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '性別',
                            style: _titleStyle,
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Consumer<MyAppViewModel>(
                                  builder: (
                                    _context,
                                    _model,
                                    _child,
                                  ) {
                                    return DropdownButton<int>(
                                      items: <int>[
                                        0,
                                        1,
                                      ].map(
                                        (int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: value == 0
                                                ? Text(
                                                    '男性',
                                                  )
                                                : Text(
                                                    '女性',
                                                  ),
                                          );
                                        },
                                      ).toList(),
                                      isDense: true,
                                      value: _model.store.state.sex,
                                      onChanged: (value) {
                                        logger.info(value);
                                        _model.store.dispatch(
                                          AddSex(value!),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 50,
            ),
            child: TextButton(
              onPressed: () {
                if (_model.store.state.name!.isEmpty ||
                    _model.store.state.isErrorName! == true) {
                  return;
                } else {
                  // reduxは、action経由で値を変更する。
                  // 以下のコードの場合は、model側でactionを拾って
                  // notifyListenersして値を変更しているから、
                  // notifyListenersは発火しない
                  // _model.store.state.currentIndex = 2;

                  _model.pageController.nextPage(
                    duration: Duration(
                      milliseconds: 250,
                    ),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Consumer<MyAppViewModel>(
                builder: (
                  _context,
                  _model,
                  _child,
                ) {
                  return Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _model.store.state.name!.isEmpty
                          ? Colors.grey
                          : Colors.teal,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        '次へ',
                        style: TextStyle(
                          fontSize: 17.5,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
