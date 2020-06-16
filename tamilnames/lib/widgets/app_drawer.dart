import 'package:flutter/material.dart';

import '../screens/names_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Categories'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('All Names'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(NamesScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            trailing: Text('surenplanet@gmail.com'),
          ),
        ],
      ),
    );
  }
}
