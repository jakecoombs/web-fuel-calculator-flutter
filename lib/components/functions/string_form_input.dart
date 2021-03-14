import 'package:flutter/material.dart';

class StringFormInput extends StatelessWidget {
  StringFormInput(
      {this.controller, this.width, this.initialValue, this.validator});
  final TextEditingController controller;
  final double width;
  final Function(String) validator;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.headline4,
        textAlign: TextAlign.center,
        cursorColor: Theme.of(context).colorScheme.primaryVariant,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryVariant)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            counterText: ''),
        initialValue: initialValue,
        validator: validator,
        minLines: 1,
        maxLines: 5,
        maxLength: 250,
      ),
      width: MediaQuery.of(context).size.width - 40,
    );
  }
}
