import 'package:flutter/material.dart';

abstract class CustomDataTableRowModel {
  List<String> get rowTexts;

  String? get avatarUrl;

  VoidCallback? get onAction;

  VoidCallback? get onOptions;
}
