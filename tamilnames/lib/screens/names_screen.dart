import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/names.dart';

import '../widgets/app_drawer.dart';
import '../widgets/app_drawer.dart';
import '../widgets/names_list.dart';

enum FilterOptions {
  Favorites,
  All,
}

class NamesScreen extends StatefulWidget {
  @override
  _NamesScreenState createState() => _NamesScreenState();
}

class _NamesScreenState extends State<NamesScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    print('Inside Namescreen-Init');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('Inside Namescreen-didChangeDependencies');

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Names>(context).fetchAndSetNames().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    print('End of Namescreen-didChangeDependencies');
  }

  @override
  Widget build(BuildContext context) {
    print('Inside Namescreen-Build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamil Names'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Favorites'), value: FilterOptions.Favorites),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : NamesList(_showOnlyFavorites),
    );
  }
}
