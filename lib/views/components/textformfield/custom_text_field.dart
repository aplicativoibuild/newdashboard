import 'package:flutter/material.dart';

import '/utils/color_utils.dart';

class CustomTextField extends StatefulWidget {
  final IconData? icon;
  final String hint;
  final String initialValue;
  final String label;
  final FocusNode? focusNode;
  final Function(String?) validate;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final int maxLines;
  final bool isPassword;

  final double fontSize;

  CustomTextField(
      {this.icon,
      this.hint = "",
      this.maxLines = 1,
      this.onChanged,
      this.isPassword = false,
      this.initialValue = '',
      this.onSubmit,
      this.fontSize = 16,
      this.focusNode,
      this.label = "",
      required this.validate});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController textController = TextEditingController();
  bool hasError = false;
  String errorText = "Mínimo 6 caracteres!";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(widget.label,
                    style: TextStyle(
                        color: colorBlack,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w600)),
              ),
              if (hasError)
                Text(errorText.toUpperCase(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: widget.fontSize - 2,
                        fontWeight: FontWeight.w600)),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          height: 60.0 * widget.maxLines,
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: colorGrayLight3, width: 1))),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                focusNode: widget.focusNode,
                maxLines: widget.maxLines,
                obscureText: widget.isPassword,
                validator: (txt) {
                  return widget.validate(txt);
                },
                onChanged: widget.onChanged,
                initialValue: widget.initialValue,
                onFieldSubmitted: widget.onSubmit,
                style: TextStyle(
                    fontSize: widget.fontSize + 2, color: colorGrayDark3),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: TextStyle(fontSize: 20, color: colorGrayLight3),
                    hintText: widget.hint),
              )),
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  size: 30,
                )
            ],
          ),
        ),
      ],
    );
  }
}
