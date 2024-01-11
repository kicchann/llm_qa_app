import 'dart:math';
import 'package:flutter/material.dart';

const double scrollRateThreshold = 0.8;
const double normalBorderRadius = 8.0;
const double normalMargin = 8.0;
const double normalFontSize = 15.0;

const double normalColumnWidth = 400;
const double largeColumnWidth = 800;

double getWidth(BuildContext context, double maxWidth) {
  return min(maxWidth, MediaQuery.of(context).size.width * 0.85);
}
