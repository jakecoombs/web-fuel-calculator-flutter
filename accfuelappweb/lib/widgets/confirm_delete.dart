import 'package:accfuelappweb/components/functions/break.dart';
import 'package:accfuelappweb/components/response_snackbar.dart';
import 'package:accfuelappweb/utils/authentication.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Are you sure you want to delete your account?',
                    style: Theme.of(context).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                  Break(),
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
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                              child: Text(
                                'Cancel',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.maxFinite,
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered))
                                      return Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5);
                                    return null; // Use the component's default.
                                  },
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.onPrimary)),
                            onPressed: () async {
                              deleteUser().catchError((error) {
                                ResponseSnackbar.showSnackbar(
                                    context, 'Error: $error');
                                return;
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ResponseSnackbar.showSnackbar(
                                  context, 'User deleted successfully');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                              child: Text(
                                'Confirm',
                                style: Theme.of(context).textTheme.bodyText1,
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
