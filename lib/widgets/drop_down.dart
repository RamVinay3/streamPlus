import 'package:flutter/material.dart';
import 'package:upload_movie/color.dart';
import 'package:upload_movie/enums/language.dart';

class DropDown extends StatefulWidget {
  const DropDown({super.key, required this.toggleLang});
  final void Function(String value) toggleLang;
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  var _selectedLanguage = language.telugu;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<language>(
      value: _selectedLanguage,
      items: language.values
          .map<DropdownMenuItem<language>>(
            (language value) => DropdownMenuItem<language>(
              value: value,
              child: Text(value.value),
              // Display enum value using extension method
            ),
          )
          .toList(),
      onChanged: (value) {
        _selectedLanguage = value!;
        widget.toggleLang(value.value);
      },
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      validator: (value) {
        if (value == null) {
          return 'Please select a language';
        }
        return null;
      },
    );
  }
}
