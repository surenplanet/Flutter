import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/names_screen.dart';
import '../providers/user_auth.dart';

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
//              Navigator.of(context).pus(NamesScreen());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Contact Us'),
            trailing: Text('surenplanet@gmail.com'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.eject),
            title: Text('Logout'),
            onTap: () => Provider.of<UserAuth>(context, listen: false).logout(),
          )
        ],
      ),
    );
  }
}
