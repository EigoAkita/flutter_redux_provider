import 'package:flutter/material.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:provider/provider.dart';

class UserAddProfileImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    // context.select((MyAppViewModel model) => model.store!.state.name);

    // final controller = TextEditingController();

    return Container(
      color: Colors.grey[300],
      child: Text('${_model.store.state.name}'),
    );
  }
}
