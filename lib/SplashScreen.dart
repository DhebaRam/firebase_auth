import 'package:app/Login.dart';
import 'package:app/mainPage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkSignedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlutterLogo(size:MediaQuery.of(context).size.height)
            ],
          ),
        ),
      ),
    );
  }

  void checkSignedIn() {

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const MainPage()));
  }
}
