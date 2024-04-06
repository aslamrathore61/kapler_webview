import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';

import '../model/native_item.dart';

const greyColor = Color(0xFFF3F4F8);
const darkGreyColor = Color(0xFFF8F9FA);

const String BaseUrl = 'https://savemax.com';

void showToast(String message, Color color, Icon icon) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
