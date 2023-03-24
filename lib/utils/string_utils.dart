import 'package:flutter/services.dart';
import 'package:get/get.dart';

class StringUtils {
  static String removerAcentos(String texto) {
    String comAcentos = "ÄÅÁÂÀÃäáâàãÉÊËÈéêëèÍÎÏÌíîïìÖÓÔÒÕöóôòõÜÚÛüúûùÇç";
    String semAcentos = "AAAAAAaaaaaEEEEeeeeIIIIiiiiOOOOOoooooUUUuuuuCc";

    for (int i = 0; i < comAcentos.length; i++) {
      texto =
          texto.replaceAll(comAcentos[i].toString(), semAcentos[i].toString());
    }
    return texto.toLowerCase();
  }

  static String unmask(String txt) {
    return txt
        .replaceAll("-", "")
        .replaceAll(".", "")
        .replaceAll(",", "")
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll("/", "")
        .replaceAll(" ", "")
        .replaceAll("\\", "")
        .replaceAll(";", "")
        .replaceAll("*", "")
        .replaceAll("+", "")
        .replaceAll("_", "")
        .replaceAll("/", "");
  }
}

String formatCel(String txt) {
  txt = txt.replaceAll("+55", "");
  txt = StringUtils.unmask(txt);
  if (txt.length < 10) return txt;
  if (txt.length < 11) {
    return '(${txt.substring(0, 2)}) ${txt.substring(2, 6)}-${txt.substring(6, 10)}';
  }
  return '(${txt.substring(0, 2)}) ${txt.substring(2, 7)}-${txt.substring(7, 11)}';
}

extension StringExtension on String {
  String pad2() {
    return padLeft(2, "0");
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalize!,
      selection: newValue.selection,
    );
  }
}
