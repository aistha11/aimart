import 'package:flutter/material.dart';

class CurrencyDropDown extends StatelessWidget {
  const CurrencyDropDown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChange,
  }) : super(key: key);
  final List<String> items;
  final String value;
  final Function onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: DropdownButton<String>(
        value: value,
        onChanged: (val) {
          onChange(val);
        },
        underline: SizedBox(),
        items: items.map<DropdownMenuItem<String>>(
          (String val) {
            return DropdownMenuItem(
              child: Text(val),
              value: val,
            );
          },
        ).toList(),
      ),
    );
  }
}
