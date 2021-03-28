import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DataDropdown extends StatelessWidget {
  DataDropdown({
    @required this.items,
    @required this.onChanged,
    @required this.value,
  });
  final List<String> items;
  final ValueChanged<String> onChanged;
  final value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        items: items != null
            ? items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                );
              }).toList()
            : [],
        onChanged: onChanged,
        value: value,
        dropdownColor: Colors.grey[900],
        underline: SizedBox(),
        iconEnabledColor: Colors.red[200],
      ),
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.5, color: Theme.of(context).accentColor)),
      margin: EdgeInsets.only(bottom: 5),
      height: 40,
    );
  }
}

class ConstrainedDataDropdown extends StatelessWidget {
  ConstrainedDataDropdown(
      {@required this.items,
      @required this.onChanged,
      @required this.value,
      this.height,
      this.width});
  final List<String> items;
  final ValueChanged<String> onChanged;
  final value;
  final double width, height;

  Widget dropdownButton(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButton<String>(
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: AutoSizeText(
              value,
              style: Theme.of(context).textTheme.headline2,
            ),
          );
        }).toList(),
        onChanged: onChanged,
        value: value,
        dropdownColor: Colors.grey[900],
        underline: SizedBox(),
        iconEnabledColor: Colors.red[200],
        isExpanded: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: dropdownButton(context),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.5, color: Theme.of(context).accentColor)),
      margin: EdgeInsets.only(bottom: 5, left: 5, right: 5),
      height: height ?? 40,
      width: width,
    );
  }
}
