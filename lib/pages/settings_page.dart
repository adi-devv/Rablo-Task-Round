import 'package:chat_app/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final settings = [
      {
        'title': 'Dark Mode',
        'value': themeProvider.isDarkMode,
        'onChanged': (value) {
          themeProvider.toggleTheme();
        },
      },
      {
        'title': 'Notifications',
        'value': true,
        'onChanged': (value) {},
      },
      {
        'title': 'Location Access',
        'value': false,
        'onChanged': (value) {},
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade600,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: List.generate(settings.length, (index) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      settings[index]['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    CupertinoSwitch(
                      value: settings[index]['value'] as bool,
                      onChanged:
                          settings[index]['onChanged'] as void Function(bool)?,
                    ),
                  ],
                ),
                if (index < settings.length - 1) const SizedBox(height: 20),
              ],
            );
          }),
        ),
      ),
    );
  }
}
