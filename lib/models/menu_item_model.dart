import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final List<Color> gradient;
  final int? count;
  final Function(BuildContext)? onTap;

  MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.gradient,
    this.count,
    this.onTap,
  });
}
