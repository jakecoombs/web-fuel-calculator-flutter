import 'package:flutter/material.dart';

class ThankYouDialog extends StatefulWidget {
  @override
  _ThankYouDialogState createState() => _ThankYouDialogState();
}

class _ThankYouDialogState extends State<ThankYouDialog> {
  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  TextEditingController textControllerPassword;
  FocusNode textFocusNodePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Thank You',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Thank you for signing up. ACC Fuel Calculator uses Google Firebase technology so you can be sure that your credentials are stored and used safely and securely. As a Software Engineering University Student, I built this app as a project to improve my coding skills, and I am so pleased with how it has progressed. By signing up your lap times and data are now saved to the cloud meaning you can use the same data across devices, even on the web, you can always delete your account if you feel like it. Once again, thank you.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  )
                ],
              ),
              constraints: BoxConstraints(maxWidth: 500),
            ),
          )),
    );
  }
}
