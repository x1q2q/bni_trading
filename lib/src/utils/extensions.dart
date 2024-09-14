import 'package:flutter/material.dart';

extension WidgetHelpers on Widget {
  Widget addPd(
      {double? l,
      double? r,
      double? t,
      double? b,
      double? x,
      double? y,
      double? all}) {
    final padding = EdgeInsets.only(
      left: all ?? x ?? l ?? 0,
      right: all ?? x ?? r ?? 0,
      top: all ?? y ?? t ?? 0,
      bottom: all ?? y ?? b ?? 0,
    );
    return Padding(
      padding: padding,
      child: this,
    );
  }

  Widget addBdRadius(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  Widget addInkWell(
      {required Color color,
      Color? splash,
      double? elev,
      VoidCallback? onPress}) {
    return Material(
        color: color,
        elevation: elev ?? 0,
        child:
            InkWell(splashColor: splash, onTap: onPress ?? () {}, child: this));
  }

  Widget addBorder({required Color color, double? radius}) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(radius ?? 0)),
        child: this);
  }
}
