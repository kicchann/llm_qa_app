// flutter
import 'package:flutter/material.dart';

// constants
import 'package:botob/constant/strings.dart';

final List<BottomNavigationBarItem> bottomNavigationBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: homeText,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.note_outlined),
    label: noteText,
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    label: profileText,
  ),
];
