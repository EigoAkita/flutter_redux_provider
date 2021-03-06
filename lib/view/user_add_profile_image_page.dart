import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux_provider/main.dart';
import 'package:flutter_redux_provider/notifier/my_app_view_model.dart';
import 'package:flutter_redux_provider/redux/action.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UserAddProfileImagePage extends StatelessWidget {
  final store;

  UserAddProfileImagePage({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _model = Provider.of<MyAppViewModel>(context, listen: false);
    final _defaultTextTheme = Theme.of(context).textTheme;
    final _titleStyle = _defaultTextTheme.subtitle1?.copyWith(
      color: Colors.teal,
      fontSize: 13.5,
    );

    logger.info("UserAddProfileImagePage");

    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
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
                        Text(
                          'プロフィール写真',
                          style: _titleStyle,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: Consumer<MyAppViewModel>(
                                  builder: (
                                    _context,
                                    _model,
                                    _child,
                                  ) {
                                    return _model.store.state.profileImage ==
                                            null
                                        ? Container(
                                            width: 225,
                                            height: 225,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.grey,
                                                size: 150,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            width: 225,
                                            height: 225,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              child: Image.file(
                                                _model
                                                    .store.state.profileImage!,
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 200,
                                    ),
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: IconButton(
                                        color: Colors.white,
                                        onPressed: () async {
                                          showModalBottomSheet<int>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Text(
                                                      'カメラで撮影',
                                                    ),
                                                    leading: Icon(
                                                      Icons.camera_alt_outlined,
                                                      color: Colors.black,
                                                    ),
                                                    onTap: () {
                                                      pickImage(
                                                        ImageSource.camera,
                                                        _model,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  ListTile(
                                                    title: Text(
                                                      '写真を選択',
                                                    ),
                                                    leading: Icon(
                                                      Icons.photo,
                                                      color: Colors.black,
                                                    ),
                                                    onTap: () {
                                                      pickImage(
                                                        ImageSource.gallery,
                                                        _model,
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                if (_model.store.state.profileImage == null) {
                  return;
                } else {
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
                      color: _model.store.state.profileImage == null
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

Future<void> pickImage(
  ImageSource _source,
  MyAppViewModel _model,
) async {
  try {
    final _image = await ImagePicker().pickImage(source: _source);
    if (_image == null) return;
    final _imageTemporary = await ImageCropper.cropImage(
      sourcePath: _image.path,
      maxWidth: 1000,
      maxHeight: 1000,
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
