import 'package:flutter/material.dart';
import 'package:upload_movie/color.dart';

class Input extends StatefulWidget {
  const Input(
      {super.key,
      required this.placeholder,
      this.onChanged,
      this.noOfLines = 1,
      required this.validator,
      required this.onSaved});
  final String placeholder;
  final int noOfLines;
  final void Function(String value) onSaved;
  final void Function(String url)? onChanged;
  final String? Function(String) validator;

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: appColors.input,
        ),
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          validator: (value) {
            if (value == null) {
              return widget.validator('');
            }
            return widget.validator(value);
          },
          enableSuggestions: false,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            border: InputBorder.none,
          ),
          maxLines: 10,
          minLines: widget.noOfLines,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onSaved: (value) {
            widget.onSaved(value!);
          },
        ),
      ),
    );
  }
}
