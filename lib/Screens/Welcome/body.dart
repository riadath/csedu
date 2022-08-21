import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:csedu/Screens/Welcome/Background.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          Image.asset('images/learn.png'),
        ],
      ),
    );
  }
}
