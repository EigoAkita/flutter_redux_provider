import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:provider/provider.dart';

class UserAddNameEtcPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MyAppViewModel>(context, listen: false);
    final controller = TextEditingController();
    final defaultTextTheme = Theme.of(context).textTheme;
    final titleStyle = defaultTextTheme.subtitle1?.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.teal,
    );

    return ChangeNotifierProvider<MyAppViewModel>(
      create: (context) => MyAppViewModel(),
      child: Container(
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
                Text('名前', style: titleStyle),
                TextFormField(
                  controller: controller,
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
                          model.addName(name: controller.text);
                          print('${model.store!.state.name}');
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
                        '${model.store!.state.name}',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
