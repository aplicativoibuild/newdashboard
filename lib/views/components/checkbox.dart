import 'package:flutter/material.dart';

import '/utils/color_utils.dart';
import '/views/components/body_text.dart';

class WCheckBox extends StatefulWidget {
  const WCheckBox(
      {Key? key, required this.value, required this.onChanged, this.text = ""})
      : super(key: key);

  final bool value;
  final Function(bool) onChanged;
  final String text;

  @override
  _WCheckBoxState createState() => _WCheckBoxState();
}

class _WCheckBoxState extends State<WCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(color: colorGrayDark3, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              decoration: BoxDecoration(
                  color: widget.value ? colorPrimary : colorWhite,
                  borderRadius: BorderRadius.circular(3)),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: colorWhite,
                  size: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
              child: BodyText(
            widget.text,
            textAlign: TextAlign.start,
          ))
        ],
      ),
    );
  }
}
