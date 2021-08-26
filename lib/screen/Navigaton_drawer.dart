import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/settings%20navigator%20page/people.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.pinkAccent,
        child: ListView(
          children: [
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Sync',
              icon: Icons.sync,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Font Style',
              icon: Icons.font_download,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: ' Theme',
              icon: Icons.color_lens,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 16),
            buildMenuItem(
              text: 'Lock',
              icon: Icons.lock,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.white70),
            const SizedBox(height: 50),
            buildMenuItem(
              text: 'Set Reminder',
              icon: Icons.notifications_active,
              onClicked: () => selectedItem(context, 4),
            ),
            buildMenuItem(
              text: 'Share App',
              icon: Icons.share,
              onClicked: () => selectedItem(context, 5),
            ),
            const SizedBox(height: 24),
            buildMenuItem(
              text: 'Privacy policy',
              icon: Icons.info,
              onClicked: () => selectedItem(context, 6),
            ),
            const SizedBox(height: 100),
            buildMenuItem(
                text: 'Log Out',
                icon: Icons.logout,
                onClicked: () {
                  FirebaseAuth.instance.signOut();
                }),
            const SizedBox(height: 0),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();


    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => People()));
        break;
    //   case 1:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //     break;
    //   case 2:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //     break;
    //   case 3:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //     break;
    //   case 4:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //     break;
    //   case 5:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //     break;
    //   case 6:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //     break;
    //   case 7:
    //     Navigator.of(context)
    //         .push(MaterialPageRoute(builder: (context) => People()));
    //
    }
  }
}