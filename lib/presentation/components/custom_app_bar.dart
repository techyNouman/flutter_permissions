import 'package:flutter/material.dart';

AppBar customAppBar({
  required String appBarTitle,
  bool? centerTitle,
  List<Widget>? actionWidgets,
}) =>
    AppBar(
      title: Text(appBarTitle),
      centerTitle: centerTitle ?? true,
      backgroundColor: Colors.teal,
      actions: actionWidgets ?? [],
    );