import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:provider/provider.dart';

class UserAddHobbyEtcPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MyAppViewModel>(context, listen: false);
    final controller = TextEditingController();

    return ChangeNotifierProvider<MyAppViewModel>(
      create: (context) => MyAppViewModel(),
      child: Container(
        color: Colors.white,
        child: Text('都道府県&趣味'),
      ),
    );
  }
}
