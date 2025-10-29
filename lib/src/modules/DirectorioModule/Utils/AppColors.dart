import 'dart:ui';
import 'package:flutter/material.dart';

class AppColors {

  static HexColor deepBlue = HexColor("#31415B");
  static HexColor green = HexColor("#00cc00");
  static HexColor clearBlue = HexColor("#002E71");
  static HexColor orange = HexColor("#fb7611");
  static HexColor backHospitales = HexColor("#EFEAF2");
  static HexColor dirTextColor = HexColor("#33445F");
  static HexColor gnpTextSystem2 = HexColor("#5A677D");
  static HexColor gnpTextSystem = HexColor("#33445F");
  static HexColor secondary800 = HexColor("#FF8D21");
  static HexColor secondary900 = HexColor("#FF6B0B");
  static HexColor secondary50 = HexColor("#FFF8E2");
  static HexColor gnpBackLight2 = HexColor("#E8EEF8");
  static HexColor textvColor = HexColor("#404040");
  static HexColor greyColor = HexColor("#AAC3EE");
  static HexColor colorVisibilty = HexColor("#647085");
  static HexColor colorDisabled = HexColor("#ECEDF0");
  static HexColor primary700 = HexColor("#002E71");
  static HexColor primary200 = HexColor("#AAC3EE");
  static HexColor primary50 = HexColor("#EAF0FB");
  static HexColor azulGNP = HexColor("#003B7C");
  static HexColor gnp_back_disable2 = HexColor("#ECEDF0");
  static HexColor disabled = HexColor("#CCCCCC");
  static HexColor divider = HexColor("#9DAEC8");
  static HexColor textDropdown = HexColor("#0C2040");
  static HexColor dividerResults = HexColor("#CED8E8");
  static HexColor borderInput = HexColor("#FEFEFE");
  static HexColor boxShadow = HexColor("ECF1F8");
  static HexColor proccessColorDisabled = HexColor("#CED8E8");
  static HexColor stateVali = HexColor("#5BC790");
  static HexColor ribbonError = HexColor("#CD5A59");
  static HexColor ribbonAlert =        HexColor("#ECB741");
  static HexColor gnpbBackDisable2 = HexColor("#ECEDF0");
  static HexColor scrollbar = HexColor("#D4E1F7");
  static HexColor buttonTextDisable = HexColor("#A3AAB6");
  static HexColor gnpChartCeles = HexColor("#1C5FC1");
  static HexColor infoIcon = HexColor("#73A8E7");
  static HexColor infoIconBackground = HexColor("#ECFAFE");
  static HexColor gnp_text_disable = HexColor("#A3AAB6");
  static HexColor gnp_text_Aviso = HexColor("#595959");
  static HexColor gnpDateHelp = HexColor("#FFEBB5");
  static HexColor snackBarGreen = HexColor("#ECF9F2");
  static HexColor snackBarYellow = HexColor("#FDFBED");
}

class HexColor extends Color {

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}