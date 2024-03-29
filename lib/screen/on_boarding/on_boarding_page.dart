import 'package:flutter/material.dart';
import 'package:resume_app/common/button/custom_rounded_button.dart';
import 'package:resume_app/screen/resume_maker/resume_maker_page.dart';
import 'package:resume_app/utility/fade_route_builder.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          buildTitle(context),
          buildImage(context),
          buildMessage(context),
          buildButton(context),
        ],
      )),
    );
  }

  buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'RESUMEPAD',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: MediaQuery.of(context).size.shortestSide * 0.1),
        textAlign: TextAlign.center,
      ),
    );
  }

  buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: CustomRoundedButton(
        onPressed: () => Navigator.of(context)
            .pushReplacement(FadeRouteBuilder(page: ResumeMakerPage())),
        title: 'Create',
      ),
    );
  }

  buildMessage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Text(
        'Your free resume maker.\nNo adds and easy to use',
        style: TextStyle(
            color: Colors.black87,
            fontSize: MediaQuery.of(context).size.shortestSide * 0.05),
        textAlign: TextAlign.center,
      ),
    );
  }

  buildImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Image.asset('assets/cv.png'),
      ),
    );
  }
}
