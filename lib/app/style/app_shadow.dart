import 'package:flutter/material.dart';

abstract class AppShadow {
  static List<BoxShadow> elevation_01dp() {
    return [
      const BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0, 3),
          blurRadius: 3,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_03dp() {
    return [
      const BoxShadow(
          color: Color(0x14000000),
          offset: Offset(0, 3),
          blurRadius: 8,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x08000000),
          offset: Offset(0, 2),
          blurRadius: 5,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_04dp() {
    return [
      const BoxShadow(
          color: Color(0x1a000000),
          offset: Offset(0, 6),
          blurRadius: 8,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x0d000000),
          offset: Offset(0, 1),
          blurRadius: 5,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x26000000),
          offset: Offset(0, 0),
          blurRadius: 1,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_06dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_8dp() {
    return [
      const BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0, 3),
          blurRadius: 5,
          spreadRadius: -1),
      const BoxShadow(
          color: Color(0x1f000000),
          offset: Offset(0, 1),
          blurRadius: 18,
          spreadRadius: 0),
      const BoxShadow(
          color: Color(0x24000000),
          offset: Offset(0, 6),
          blurRadius: 10,
          spreadRadius: 0)
    ];
  }

  static List<BoxShadow> elevation_shadow() {
    return [
      BoxShadow(
        color: Color(0xFFd2d2d2).withOpacity(.1),
        offset: Offset(0, 2),
        blurRadius: 8,
      ),
    ];
  }

  static List<BoxShadow> elevation_floating() {
    return [
      BoxShadow(
        color: Color(0xFF4041434).withOpacity(.06),
        offset: Offset(0, 4),
        blurRadius: 10,
      ),
    ];
  }

  static List<BoxShadow> elevation_devices() {
    return [
      BoxShadow(
        color: Color(0xFF403B3B).withOpacity(.05),
        offset: Offset(0, 2),
        blurRadius: 6,
      ),
    ];
  }

  static List<BoxShadow> elevation_section() {
    return [
      BoxShadow(
        color: Color(0xFF403B3B).withOpacity(.05),
        offset: Offset(0, 2),
        blurRadius: 6,
      ),
    ];
  }
}
