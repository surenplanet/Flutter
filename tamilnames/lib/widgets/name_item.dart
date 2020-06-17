import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/name.dart';
import '../providers/user_auth.dart';

class NameItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final name = Provider.of<Name>(context, listen: false);

    final authData = Provider.of<UserAuth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Name>(
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
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
