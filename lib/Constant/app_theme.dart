import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF91C788);
const kPrimaryColor200 = Color(0xFF95C9B4);
const kPrimaryColor100 = Color(0xFFDDFFBC);
const kSecondaryColor = Color(0xFFFEFFDE);
const kNeutralColor = Color(0xFF6D7175);
const kNeutralColor200 = Color(0xFFF0F0F0);
const kDangerColor = Color(0xFFD72C0D);
const kDangerColor200 = Color(0xFFFD938D);
const kDangerColor100 = Color(0xFFFED3D1);
const kBlack = Colors.black;
const kWhite = Colors.white;

const kInputTitleTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  color: kBlack,
);
const kTextInputDecoration = InputDecoration(
  enabledBorder: kInputBorder,
  focusedBorder: kInputBorder,
  errorBorder: kInputBorder,
  disabledBorder: kInputBorder,
  border: kInputBorder,
  errorStyle: TextStyle(
    color: kDangerColor,
    fontSize: 14,
  )
);
const kInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(14),
    topRight: Radius.circular(14),
    bottomLeft: Radius.circular(14),
    bottomRight: Radius.circular(14),
  ),
  borderSide: BorderSide(
    color: kBlack,
    style: BorderStyle.solid,
    width: 1.5,
  ),
);
