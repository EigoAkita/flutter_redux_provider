import 'package:flutter/material.dart';

class RegistrationConfirmationScreenPage extends StatelessWidget {
  final store;

  RegistrationConfirmationScreenPage({
    Key? key,
    this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: ClipRRect(
              child: Image.file(
                store.state.profileImage,
                fit: BoxFit.fill,
              ),
            ),
          ),
          profileWidget(
            const EdgeInsets.only(
              left: 20,
              top: 5,
            ),
            store.state.name,
            30,
            FontWeight.bold,
            Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 5,
            ),
            child: Row(
              children: <Widget>[
                profileWidget(
                  EdgeInsets.zero,
                  '${store.state.age}歳',
                  13.5,
                  FontWeight.normal,
                  Colors.grey[600],
                ),
                profileWidget(
                  const EdgeInsets.only(
                    left: 5,
                  ),
                  store.state.prefectures,
                  13.5,
                  FontWeight.normal,
                  Colors.grey[600],
                ),
              ],
            ),
          ),
          profileWidget(
            const EdgeInsets.only(
              top: 50,
              left: 20,
            ),
            'プロフィール',
            17.5,
            FontWeight.bold,
            Colors.black,
          ),
          profileWidget(
            const EdgeInsets.only(
              top: 20,
              left: 20,
            ),
            '基本情報',
            14.5,
            FontWeight.bold,
            Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 12.5,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                      child: Text(
                        '性別',
                        style: TextStyle(
                          fontSize: 14.5,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Text(
                      store.state.sex == 0 ? '男性' : '女性',
                      style: TextStyle(
                        fontSize: 14.5,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.5,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Text(
                          '趣味',
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${store.state.hobby}',
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget profileWidget(
  EdgeInsetsGeometry padding,
  String text,
  double fontSize,
  FontWeight weight,
  Color? color,
) {
  return Padding(
    padding: padding,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: weight,
        fontSize: fontSize,
        color: color,
      ),
    ),
  );
}
