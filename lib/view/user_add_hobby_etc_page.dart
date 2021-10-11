import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/common/prefectures.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:provider/provider.dart';

class UserAddHobbyEtcPage extends StatelessWidget {
  final store;
  UserAddHobbyEtcPage({Key? key, this.store}) : super(key: key);

  late final _controller = TextEditingController(text: store.state.hobby);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      color: Colors.teal,
      fontSize: 13.5,
    );
    final _bottomSpace = MediaQuery.of(context).viewInsets.bottom;

    logger.info("UserAddHobbyEtcPage");
    logger.info(store.state.hobby);

    return SingleChildScrollView(
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
                    Text('都道府県', style: _titleStyle),
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
                          return DropdownButton<String>(
                            items: prefectures.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isDense: true,
                            value: _model.store.state.prefectures,
                            onChanged: (value) {
                              logger.info(value);
                              _model.store.dispatch(AddPrefectures(value!));
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text('趣味', style: _titleStyle),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _controller,
                        onChanged: (text) {
                          logger.info('onChangedHobby');
                          _model.store.dispatch(AddHobby(text));
                        },
                        minLines: 10,
                        maxLines: 15,
                        decoration: InputDecoration.collapsed(
                          hintText: '猫と遊ぶ事です！',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Consumer<MyAppViewModel>(
                      builder: (
                        _context,
                        _model,
                        _child,
                      ) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _model.store.state.isErrorHobby!
                                ? Text(
                                    '${_model.store.state.errorHobby}',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                    ),
                                  )
                                : SizedBox(),
                            _model.store.state.isErrorHobby!
                                ? Text(
                                    '${_model.store.state.hobby!.length}/500',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    '${_model.store.state.hobby!.length}/500',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
