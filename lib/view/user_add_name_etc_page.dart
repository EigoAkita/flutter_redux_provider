import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:provider/provider.dart';

class UserAddNameEtcPage extends StatelessWidget {
  const UserAddNameEtcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final name =
        context.select((MyAppViewModel model) => model.store!.state.name);

    final _controller = TextEditingController();
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    );

    return Container(
      width: double.infinity,
      color: Colors.white,
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
              TextFormField(
                onChanged: (text) {
                  _model.addName(name: _controller.text);
                  print(_model.store!.state.name);
                },
                controller: _controller,
                cursorColor: Colors.grey,
                maxLength: 10,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.teal)),
                      onPressed: () {
                        _model.addName(name: _controller.text);
                        print(_model.store!.state.name);
                      },
                      child: Text(
                        '次へ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '${name!}',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
