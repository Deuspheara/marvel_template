import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/DarkThemeProvider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return SafeArea(
            child: Column(
              children: [
                ListTile(
                    title: Text('Dark mode'),
                    trailing: Switch(
                      value: value.darkTheme,
                      onChanged: (position) {
                        value.darkTheme = position;
                      },
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
