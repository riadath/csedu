import 'package:csedu/constants.dart';
import 'package:csedu/StudentProfiles/student_profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Screens/Home/navigation_drawer.dart';

class BatchCardView extends StatelessWidget {
  const BatchCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: gPrimaryColorDark),
        backgroundColor: gPrimaryColor,
        title: const Text("Select Batch",
            style: TextStyle(color: gPrimaryColorDark)),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: const Icon(
              Icons.logout,
              color: gPrimaryColorDark,
            ),
          ),
        ],
      ),
      body: const Center(
        child: Background(
          child: BatchCardWidget(),
        ),
      ),
    );
    ;
  }
}

class BatchCardWidget extends StatelessWidget {
  const BatchCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          CardCreator(
            imageUrl: 'images/learn.png',
            screenSize: screenSize,
            title: '24',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentProfilePage(batch: 24),
                  ));
            },
          ),
          CardCreator(
            imageUrl: 'images/learn.png',
            screenSize: screenSize,
            title: '25',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentProfilePage(batch: 25),
                  ));
            },
          ),
          CardCreator(
            imageUrl: 'images/learn.png',
            screenSize: screenSize,
            title: '26',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentProfilePage(batch: 26),
                  ));
            },
          ),
          CardCreator(
            imageUrl: 'images/learn.png',
            screenSize: screenSize,
            title: '27',
            onPress: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StudentProfilePage(batch: 27),
                  ));
            },
          ),
        ],
      ),
    );
  }
}

class CardCreator extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onPress;
  const CardCreator({
    Key? key,
    required this.screenSize,
    required this.imageUrl,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final Size screenSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: screenSize.width,
        height: 150,
        child: Card(
            color: const Color.fromARGB(255, 194, 193, 193),
            child: InkWell(
              splashColor: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Image.asset(imageUrl)),
                  Container(
                    padding: const EdgeInsets.only(top: 17),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lucida Console',
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class Background extends StatefulWidget {
  final Widget child;
  const Background({Key? key, required this.child}) : super(key: key);

  @override
  State<Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            // height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('images/background_wave2.jpg'),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
