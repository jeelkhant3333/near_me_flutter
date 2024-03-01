import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AlertDialog clearHistory = AlertDialog(
    title: const Text("Clear History"),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 25,
    ),
    content: const Text("You Will Lose Your Current Data"),
    actions: [
      TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, 'home');
        },
        child: const Text(
          "Cancel",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, 'home');
        },
        child: const Text(
          "OK",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
  AlertDialog deleteAccount = AlertDialog(
    alignment: Alignment.center,
    title: const Text("Are You Sure?"),
    titleTextStyle: const TextStyle(
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontSize: 25,
    ),
    content: const Text(
      "Delete Account",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, 'home');
        },
        child: const Text(
          "Cancel",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, 'home');
        },
        child: const Text(
          "OK",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close_outlined),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile(
              title: const Text(
                "Notification",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              value: false,
              onChanged: (value) {
                // Add your logic here when the switch is toggled
              },
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return clearHistory;
                  },
                );
              },
              title: const Text("Clear History"),
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return deleteAccount;
                  },
                );
              },
              title: const Text("Delete Account"),
              titleTextStyle: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
