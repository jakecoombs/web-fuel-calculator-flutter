import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  BaseButton({@required this.text, this.icon, this.onPressed});
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            icon != null
                ? Icon(
                    icon,
                    color: Colors.white,
                  )
                : Container(),
            Expanded(
              child: AutoSizeText(
                text.toUpperCase(),
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).colorScheme.secondary),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                    color: Theme.of(context).accentColor, width: 1.5)))),
      ),
      width: 160,
    );
  }
}
