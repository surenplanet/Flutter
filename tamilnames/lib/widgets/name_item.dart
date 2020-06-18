import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/name.dart';
import '../providers/user_auth.dart';

class NameItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<Name>(context, listen: false);
    print('inNameItem-->$name');
    final authData = Provider.of<UserAuth>(context, listen: false);
    print(authData.userId);
    return Padding(
      key: ValueKey(name.nameEnglish),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          trailing: Consumer<Name>(
            builder: (ctx, name, _) => IconButton(
              icon: Icon(
                name.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                name.toggleFavoriteStatus(
                  authData.token,
                  authData.userId,
                );
              },
            ),
          ),
          title: Text(
            name.toString(),
            textAlign: TextAlign.left,
          ),
          subtitle: Text(
            name.meaning,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
