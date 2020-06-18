import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/http_exception.dart';
import './name.dart';

class Names with ChangeNotifier {
  List<Name> _items = [];

  final String userId;

  Names(this.userId, this._items);

  List<Name> get items {
    return [..._items];
  }

  List<Name> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Name findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetNames() async {
    print('Inside fetchAndSetnames');
    final List<Name> loadedNames = [];

    final extractedData = Firestore.instance
        .collection('tamilnames')
        .snapshots(); //stream<Querysnapshots>
    final extractedFavData = Firestore.instance
        .collection('userfavorites')
        .document(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        print('DocumentSnapshot data: ${doc.data}');
      } else {
        print('No Document found');
      }r
    });

//            (value) => (if(value != null){print('DocumentSnapshot data: ${document.data}');}
//        else{print('No Document found');})
//    );

    extractedData.forEach((snapshot) {
      print(snapshot.toString());
      snapshot.documents.map((data) {
        print(data.toString());
        final record = Name.fromSnapshot(data);
//        record.isFavorite = extractedFavData == null ? false : extractedFavData.[record.id] ?? false
        loadedNames.add(record);
        print(record.toString());
      }).toList();
    });
    _items = loadedNames;

    print(_items.length);
    notifyListeners();
  }
}
