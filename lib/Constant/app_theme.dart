import 'package:flutter/material.dart';
import 'package:get/get.dart';

final kPrimaryColor = Get.theme.colorScheme.primary;
final kSecondaryColor = Get.theme.colorScheme.secondary;
final kNeutralColor = Get.theme.colorScheme.onSurfaceVariant;
final kNeutralColor200 = Get.theme.colorScheme.surfaceVariant;
final kNeutralColor100 = Get.theme.colorScheme.surface;
final kDangerColor = Get.theme.colorScheme.error;
final kTertiaryColor = Get.theme.colorScheme.tertiary;
const kBlack = Colors.black;
const kWhite = Colors.white;
final kGrey = Colors.grey[700];
const kOrange = Color(0xFFFFA700);

const kInputTitleTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
  color: kBlack,
);

final kListTileMoneyText = TextStyle(
  fontWeight: FontWeight.w600,
  color: kPrimaryColor,
  textBaseline: TextBaseline.alphabetic,
);

const kListTilePrimaryText = TextStyle(
  fontWeight: FontWeight.w600,
  textBaseline: TextBaseline.alphabetic,
);

final kListTileSecondaryText = TextStyle(
  fontSize: 14,
  color: kNeutralColor,
  textBaseline: TextBaseline.alphabetic,
);

final kTextInputDecoration = InputDecoration(
  enabledBorder: kInputBorder,
  focusedBorder: kInputBorder,
  errorBorder: kInputBorder,
  disabledBorder: kInputBorder,
  border: kInputBorder,
  errorStyle: TextStyle(
    color: kDangerColor,
    fontSize: 14,
  ),
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
    width: 1.2,
  ),
);
