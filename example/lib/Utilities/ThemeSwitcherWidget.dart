// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeProvider .dart';

class ThemeSwitcherWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThemeSwitcherWidget();
}

class _ThemeSwitcherWidget extends State<ThemeSwitcherWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Dark Mode:'),
        Switch(
          value: Provider.of<ThemeProvider>(context).isDarkMode,
          onChanged: (value) {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
      ],
    );
  }
}
