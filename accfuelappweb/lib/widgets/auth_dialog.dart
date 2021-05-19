import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:accfuelappweb/utils/authentication.dart';
import 'package:accfuelappweb/widgets/reset_password.dart';
import 'package:accfuelappweb/widgets/thank_you_dialog.dart';
import 'package:flutter/material.dart';

class AuthDialog extends StatefulWidget {
  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  TextEditingController textControllerEmail;
  FocusNode textFocusNodeEmail;
  bool _isEditingEmail;
  TextEditingController textControllerPassword;
  FocusNode textFocusNodePassword;
  bool _isEditingPassword;
  bool _isRegistering;

  @override
  void initState() {
    textControllerEmail = TextEditingController();
    textControllerEmail.text = null;
    textFocusNodeEmail = FocusNode();
    _isEditingEmail = false;
    textControllerPassword = TextEditingController();
    textControllerPassword.text = null;
    textFocusNodePassword = FocusNode();
    _isEditingPassword = false;
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

  String _validatePassword(String value) {
    value = value.trim();

    if (textControllerEmail.text != null) {
      if (value.isEmpty) {
        return 'Password can\'t be empty';
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                    child: Text('Email address'),
                  ),
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
                      FocusScope.of(context)
                          .requestFocus(textFocusNodePassword);
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('Password'),
                  ),
                  TextField(
                    focusNode: textFocusNodePassword,
                    textInputAction: TextInputAction.next,
                    controller: textControllerPassword,
                    autofocus: false,
                    obscureText: true,
                    onChanged: (value) {
                      setState(() {
                        _isEditingPassword = true;
                      });
                    },
                    onSubmitted: (value) {
                      textFocusNodePassword.unfocus();
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
                      hintText: "Password",
                      errorText: _isEditingPassword
                          ? _validatePassword(textControllerPassword.text)
                          : null,
                      fillColor: Colors.white,
                      errorStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Column(
                    children: _isRegistering
                        ? [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 32,
                                width: 32,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            ))
                          ]
                        : [
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
                                          MaterialStateProperty.resolveWith<
                                              Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.hovered))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5);
                                          return null; // Use the component's default.
                                        },
                                      )),
                                      onPressed: () async {
                                        if (_validateEmail(
                                                    textControllerEmail.text) ==
                                                null &&
                                            _validatePassword(
                                                    textControllerPassword
                                                        .text) ==
                                                null) {
                                          setState(() {
                                            _isRegistering = true;
                                          });
                                          await signInWithEmailPassword(
                                                  textControllerEmail.text,
                                                  textControllerPassword.text)
                                              .then((result) {
                                            Navigator.pop(context);
                                            ResponseSnackbar.showSnackbar(
                                                context,
                                                'Signed in successfully');
                                          }).catchError((error) {
                                            ResponseSnackbar.showSnackbar(
                                                context,
                                                'Sign in Error: $error',
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
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        child: Text(
                                          'Sign in',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                          MaterialStateProperty.resolveWith<
                                              Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.hovered))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5);
                                          return null; // Use the component's default.
                                        },
                                      )),
                                      onPressed: () async {
                                        if (_validateEmail(
                                                    textControllerEmail.text) ==
                                                null &&
                                            _validatePassword(
                                                    textControllerPassword
                                                        .text) ==
                                                null) {
                                          setState(() {
                                            _isRegistering = true;
                                          });
                                          await registerWithEmailPassword(
                                                  textControllerEmail.text,
                                                  textControllerPassword.text)
                                              .then((result) {
                                            Navigator.pop(context);
                                            ResponseSnackbar.showSnackbar(
                                                context,
                                                'Signed up successfully');
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  ThankYouDialog(),
                                            );
                                          }).catchError((error) {
                                            ResponseSnackbar.showSnackbar(
                                                context,
                                                'Registration Error: $error',
                                                success: false,
                                                duration: Duration(seconds: 5));
                                          });
                                        } else {
                                          ResponseSnackbar.showSnackbar(context,
                                              'Registration Error: Please fill in all the values',
                                              success: false,
                                              duration: Duration(seconds: 5));
                                        }
                                        setState(() {
                                          _isRegistering = false;
                                          _isEditingEmail = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        child: Text(
                                          'Sign up',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                          MaterialStateProperty.resolveWith<
                                              Color>(
                                        (Set<MaterialState> states) {
                                          if (states
                                              .contains(MaterialState.hovered))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5);
                                          return null; // Use the component's default.
                                        },
                                      )),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              ResetPasswordDialog(),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 15.0, bottom: 15.0),
                                        child: Text(
                                          'Reset password',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
