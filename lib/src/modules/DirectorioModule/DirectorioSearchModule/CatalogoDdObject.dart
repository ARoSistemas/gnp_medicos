import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CatalogoDdObject {
  String? label;
  dynamic selectedItem;
  List<ElementoDd>? valores;
  ConfiguracionDd? config;
  Function? onChange;

  CatalogoDdObject({this.label, this.selectedItem, this.valores, this.config, this.onChange});


}

class ElementoDd{
  dynamic id;
  String? valor;

  ElementoDd({this.id, this.valor});

}

class ConfiguracionDd{
  double? listSize;
  int? innnerMargin;
  int? defaultSelectedIndex;
  bool? selectedFeedBack;
  Color? selectedColor;
  Color? textItemColor;
  Color? selectedTextItemColor;
  double? dropdownSize;
  double? borderSize;
  Color? activeBorderColor;
  Color? borderColor;
  Color? accentColor;
  Color? dropdownBackgroundColor;
  Color? labelColor;
  Color? labelColorActive;
  Icon? icon;
  Function? onChange;


  ConfiguracionDd({this.listSize,
    this.innnerMargin ,
    this.defaultSelectedIndex,
    this.dropdownSize,
    this.accentColor,
    this.selectedColor,
    this.borderSize,
    this.dropdownBackgroundColor,
    this.activeBorderColor,
    this.borderColor,
    this.labelColor,
    this.icon,
    this.labelColorActive,
    this.selectedTextItemColor,
    this.textItemColor,
    this.onChange,
  });


}