import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/views/components/textformfield/text_form_validator.dart';

class TextFormCustom extends StatefulWidget {
  final String hint;
  final FormFieldValidator? validator;
  final String label;
  final String labelTop;
  final bool isPassword;
  final int? maxLen;
  final bool readOnly;
  final double width;
  final String initialValue;
  final List<TextInputFormatter> inputFormatters;
  final int maxLines;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focus;

  TextFormCustom(
      {Key? key,
      this.hint = "",
      this.initialValue = "",
      this.isPassword = false,
      this.label = "",
      this.maxLen,
      this.readOnly = false,
      this.focus,
      this.labelTop = "",
      this.maxLines = 1,
      this.inputFormatters = const [],
      this.validator,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.controller,
      this.width = double.infinity});

  @override
  _TextFormCustomState createState() => _TextFormCustomState();
}

class _TextFormCustomState extends State<TextFormCustom> {
  bool showPassword = false;
  late FocusNode focus;

  @override
  void initState() {
    super.initState();
    showPassword = widget.isPassword;

    focus = widget.focus ?? FocusNode();

    focus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormValidator(
      focus: focus,
      validator: widget.validator,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      hint: widget.hint,
      maxLen: widget.maxLen,
      label: widget.label,
      labelTop: widget.labelTop,
      controller: widget.controller,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      isPassword: widget.isPassword,
      showPassword: showPassword,
      keyboardType: widget.keyboardType,
      changed: widget.onChanged,
      onObscure: () {
        setState(() {
          showPassword = !showPassword;
        });
      },
    );
  }
}
