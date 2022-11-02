import 'package:csedu/Screens/Routine/Routine_screen.dart';
import 'package:csedu/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Home/navigation_drawer.dart';
import 'ClassAdd_page.dart';

class RoutineWidget extends StatefulWidget {
  const RoutineWidget({Key? key}) : super(key: key);
  
  @override
  State<RoutineWidget> createState() => _RoutineWidgetIndState();
}

class _RoutineWidgetIndState extends State<RoutineWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: gPrimaryColorDark),
        backgroundColor: gPrimaryColor,
        title:
            const Text("Routines", style: TextStyle(color: gPrimaryColorDark)),
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

      body:  const Center(
        child: Background(
          child: RoutineByDay(),
        ),
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

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CSEDU',
      theme: ThemeData(
        primaryColor: gPrimaryColor,
        primaryColorLight: gPrimaryColor,
        primaryColorDark: Colors.grey[850],
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      home:  RoutineWidget(),
    );
  }
}
