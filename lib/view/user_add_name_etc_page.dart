import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:provider/provider.dart';

class UserAddNameEtcPage extends StatelessWidget {
  const UserAddNameEtcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _controller = TextEditingController();
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    );

    return Container(
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
                child: TextField(
                  onChanged: (text) {
                    _model.addName(name: text);
                    print(text);
                  },
                  controller: _controller..text = _model.store!.state.name!,
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
                      value: _model.store!.state.age,
                      onChanged: (value) {
                        _model.addAge(age: value);
                        print(_model.store!.state.age);
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
              // Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: Row(
              //     children: <Widget>[
              //       TextButton(
              //         style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all<Color>(Colors.teal)),
              //         onPressed: () {
              //           _model.addName(name: _controller.text);
              //           print(_model.store!.state.name);
              //         },
              //         child: Text(
              //           '次へ',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 15,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         '${name!}',
              //         style: TextStyle(color: Colors.teal),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
