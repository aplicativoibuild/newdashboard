import 'package:flutter/material.dart';

import '/utils/color_utils.dart';
import '/views/components/body_text.dart';

class DropdownFormCustom extends FormField {
  DropdownFormCustom({
    FormFieldValidator? validator,
    String? labelTop,
    String? hint,
    Function? changed,
    bool border = true,
    required String value,
    required List<String> items,
  }) : super(
            validator: validator,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (labelTop != null) BodyText(labelTop),
                  if (labelTop != null) SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 0, horizontal: !border ? 0 : 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: !border
                            ? null
                            : Border.all(color: colorGrayLight3, width: 1),
                        color: Colors.white),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            errorStyle:
                                TextStyle(height: 0, color: Colors.transparent),
                          ),
                          value: value,
                          validator: validator,
                          onChanged: (value) {
                            state.didChange(value);
                            if (state.hasError) state.validate();
                            if (changed != null) changed(value);
                          },
                          items: items
                              .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: BodyText(
                                    e.isNotEmpty ? e : hint ?? "",
                                    color: e == 'Selecionar' || e.isEmpty
                                        ? colorGrayDark2
                                        : colorBlack,
                                  )))
                              .toList()),
                    ),
                  ),
                  Container(
                    height: !border ? 0 : 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (state.hasError)
                          Text(state.errorText!,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                ],
              );
            });
}
