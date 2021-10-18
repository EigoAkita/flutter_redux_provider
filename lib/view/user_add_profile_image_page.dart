import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:flutter_redux_provider/redux/state.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserAddProfileImagePage extends StatelessWidget {
  final store;
  UserAddProfileImagePage({Key? key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      color: Colors.teal,
      fontSize: 13.5,
    );

    logger.info("UserAddProfileImagePage");

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
              Text(
                'プロフィール写真',
                style: _titleStyle,
              ),
              SizedBox(
                height: 25,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Consumer<MyAppViewModel>(builder: (
                      _context,
                      _model,
                      _child,
                    ) {
                      return _model.store.state.profileImage == null
                          ? Container(
                              color: Colors.white,
                              width: 200,
                              height: 200,
                              child: Image.asset('lib/images/人物シルエット.png'),
                            )
                          : Image.file(_model.store.state.profileImage!);
                    }),
                    TextButton(
                      onPressed: () => pickImage(ImageSource.gallery, _model),
                      child: Text('選択'),
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

Future pickImage(
  ImageSource _source,
  MyAppViewModel _model,
) async {
  try {
    final _image = await ImagePicker().pickImage(source: _source);
    if (_image == null) return;
    final _imageTemporary = await ImageCropper.cropImage(
      sourcePath: _image.path,
      maxWidth: 200,
      maxHeight: 200,
      aspectRatio: CropAspectRatio(
        ratioX: 1,
        ratioY: 1,
      ),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 100,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'プロフィール写真',
        toolbarColor: Colors.blue,
        toolbarWidgetColor: Colors.white,
        lockAspectRatio: true,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'プロフィール写真',
        doneButtonTitle: '完了',
        cancelButtonTitle: 'キャンセル',
      ),
    );
    // final _imageTemporary = File(_image.path);
    if (_imageTemporary != null)
      _model.store.dispatch(
        AddProfileImage(_imageTemporary),
      );
  } on PlatformException catch (e) {
    print(
      e.toString(),
    );
  }
}
