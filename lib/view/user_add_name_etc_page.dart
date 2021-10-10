import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:provider/provider.dart';

class UserAddNameEtcPage extends StatelessWidget {
  final store;
  UserAddNameEtcPage({Key? key, this.store}) : super(key: key);

  //MyHomePageから渡されたインスタンスをコンストラクタで初期化して、使用可能にする。
  //lateはstoreの処理の際に必須。lateとは、lateと定義した変数はその変数が使用されない
  //限り、初期化もされないのでコスト削減に繋がる。

  late final _controller = TextEditingController(text: store.state.name);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    );

    logger.info("UserAddNameEtcPage");
    logger.info(store.state.name);

    return GestureDetector(
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  height: 35,
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
                      child: DropdownButton<int>(
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
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        isDense: true,
                        value: _model.store.state.age,
                        onChanged: (value) {
                          logger.info(value);
                          _model.store.dispatch(AddAge(value!));
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '歳',
                      style: _titleStyle!.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
