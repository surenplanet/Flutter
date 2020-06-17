import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/names.dart';
import './name_item.dart';

class NamesList extends StatelessWidget {
  final bool showFavs;

  NamesList(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final namesData = Provider.of<Names>(context);
    final names = showFavs ? namesData.favoriteItems : namesData.items;
    print(names.length);
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: names.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: names[i],
        child: NameItem(
            // products[i].id,
            // products[i].title,
            // products[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
