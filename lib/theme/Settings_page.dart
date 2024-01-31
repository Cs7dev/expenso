import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeManager.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeMode? selectedThemeMode;

  @override
  void initState() {
    super.initState();
    selectedThemeMode =
        Provider.of<ThemeManager>(context, listen: false).themeMode;
  }

  @override
  Widget build(BuildContext context) {
    Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Theme mode'),
      ),
      body: Center(
        child: Consumer<ThemeManager>(
          builder: (context, themeManager, _) => Center(
            child: ListView(
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Dark mode'),
                  selected: selectedThemeMode == ThemeMode.dark,
                  value: ThemeMode.dark,
                  groupValue: selectedThemeMode,
                  onChanged: (value) => setState(() {
                    selectedThemeMode = value;
                    themeManager.setThemeMode(selectedThemeMode!);
                  }),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Light mode'),
                  selected: selectedThemeMode == ThemeMode.light,
                  value: ThemeMode.light,
                  groupValue: selectedThemeMode,
                  onChanged: (value) => setState(() {
                    selectedThemeMode = value;
                    themeManager.setThemeMode(selectedThemeMode!);
                  }),
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('System default'),
                  selected: selectedThemeMode == ThemeMode.system,
                  value: ThemeMode.system,
                  groupValue: selectedThemeMode,
                  onChanged: (value) => setState(() {
                    selectedThemeMode = value;
                    themeManager.setThemeMode(selectedThemeMode!);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
