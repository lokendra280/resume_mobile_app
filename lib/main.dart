import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_app/screen/on_boarding/on_boarding_page.dart';

void main() => run();

Future run() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resume Maker',
      theme: ThemeData.light(),
      home: OnBoardingPage(),
      initialRoute: '/',
    );
  }
}
