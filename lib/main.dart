import 'package:app/AppProvider.dart';
import 'package:app/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
      // ChangeNotifierProvider<InternetConnectionStatus>(create: (_) => InternetConnectionStatus()),
    ],
    child: const MyApp(),
  ));
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: InternetConnectionChecker().onStatusChange,
    //     initialData: InternetConnectionStatus.connected,
    //     builder: (BuildContext context,
    //         AsyncSnapshot<InternetConnectionStatus> snapshot) {
    //     print(InternetConnectionStatus.connected == InternetConnectionStatus.connected);
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen());
    // });
  }
}
