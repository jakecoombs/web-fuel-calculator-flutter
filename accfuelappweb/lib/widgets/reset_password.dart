import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:accfuelappweb/utils/authentication.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatefulWidget {
  @override
  _ResetPasswordDialogState createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail;
  bool _isRegistering;

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerEmail.text = null;
    textFocusNodeEmail = FocusNode();
    _isEditingEmail = false;
    _isRegistering = false;

    super.initState();
  }

  String _validateEmail(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Email can\'t be empty';
      } else if (!value.contains(RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
        return 'Enter a correct email address';
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Dialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Email address'),
                  TextField(
                    focusNode: textFocusNodeEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    controller: textControllerEmail,
                    autofocus: false,
                    onChanged: (value) {
                      setState(() {
                        _isEditingEmail = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodeEmail.unfocus();
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      focusedBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 3)),
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.blueGrey[800],
                          width: 3,
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.blueGrey[300],
                      ),
                      hintText: "Email",
                      fillColor: Colors.white,
                      errorText: _isEditingEmail
                          ? _validateEmail(textControllerEmail.text)
                          : null,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.maxFinite,
                          child: TextButton(
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.hovered))
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5);
                                return null; // Use the component's default.
                              },
                            )),
                            onPressed: () async {
                              if (_validateEmail(textControllerEmail.text) ==
                                  null) {
                                setState(() {
                                  _isRegistering = true;
                                });
                                await resetPassword(textControllerEmail.text)
                                    .then((result) {
                                  print(result);
                                  Navigator.pop(context);
                                  ResponseSnackbar.showSnackbar(
                                      context,
                                      'An email has been sent to ' +
                                          textControllerEmail.text +
                                          ' to reset your password',
                                      duration: Duration(seconds: 8));
                                }).catchError((error) {
                                  print('Reset Error: $error');
                                  ResponseSnackbar.showSnackbar(
                                      context, 'Error: $error',
                                      success: false,
                                      duration: Duration(seconds: 5));
                                });
                              }
                              setState(() {
                                _isRegistering = false;
                                _isEditingEmail = false;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                              child: _isRegistering
                                  ? SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )
                                  : Text(
                                      'Reset Password',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
