import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '/utils/color_utils.dart';

class TextFormValidator extends FormField {
  TextFormValidator(
      {FormFieldSetter? onSaved,
      FormFieldValidator? validator,
      String initialValue = "",
      bool showPassword = false,
      bool autovalidate = false,
      Function? onObscure,
      int maxLines = 1,
      String hint = "",
      String label = "",
      String labelTop = "",
      int? maxLen,
      bool readOnly = false,
      List<TextInputFormatter> inputFormatters = const [],
      double width = double.infinity,
      bool isPassword = false,
      double paddingBottom = 0,
      required FocusNode focus,
      String? icon,
      TextEditingController? controller,
      Function? changed,
      TextInputType keyboardType = TextInputType.text})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (state) {
              return Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (labelTop.isNotEmpty)
                      Text(labelTop,
                          style: TextStyle(
                              color: colorGrayDark1,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    if (labelTop.isNotEmpty) SizedBox(height: 5),
                    Container(
                      constraints: BoxConstraints(minHeight: 55),
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      height: 30.0 * maxLines,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: colorWhite,
                          border: Border.all(color: colorGrayLight3, width: 1)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            readOnly: readOnly,
                            onChanged: (value) {
                              state.didChange(value);
                              if (state.hasError) state.validate();
                              if (changed != null) changed(value);
                            },
                            maxLength: maxLen,
                            inputFormatters: inputFormatters,
                            controller: controller,
                            keyboardType: keyboardType,
                            obscureText: showPassword,
                            focusNode: focus,
                            maxLines: maxLines,
                            validator: validator,
                            style: TextStyle(fontSize: 18, color: colorBlack),
                            decoration: InputDecoration(
                                // counter: Container(width: 0, height: 0),
                                counterText: '',
                                semanticCounterText: '',
                                errorText: '',
                                errorMaxLines: 1,
                                counterStyle: TextStyle(
                                    height: 0, color: Colors.transparent),
                                errorStyle: TextStyle(
                                    height: 0, color: Colors.transparent),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 18, color: colorGrayDark2),
                                hintText: hint),
                          )),
                          if (isPassword)
                            GestureDetector(
                              onTap: () {
                                onObscure!();
                              },
                              child: SvgPicture.asset(
                                "assets/svg/view.svg",
                                width: 25,
                                color: !showPassword
                                    ? colorPrimaryDark
                                    : colorGrayDark3,
                              ),
                            )
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: width,
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runAlignment: WrapAlignment.spaceBetween,
                        children: [
                          Text(label,
                              style: TextStyle(
                                  color: colorGrayDark2,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400)),
                          if (state.hasError)
                            Text(state.errorText!,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
}
