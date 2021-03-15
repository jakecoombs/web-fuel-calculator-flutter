import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'decimal_formatter.dart';

class NumberInput extends StatelessWidget {
  NumberInput({this.controller, this.inputLength, this.decimal = false});

  final TextEditingController controller;
  final int inputLength;
  final bool decimal;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
        cursorColor: Theme.of(context).colorScheme.primaryVariant,
        maxLength: inputLength,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: !decimal
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : [DecimalTextInputFormatter(decimalRange: 2)],
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primaryVariant)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            counterText: ''),
      ),
      width: (inputLength > 3) ? 66 : inputLength * 22.0,
    );
  }
}
