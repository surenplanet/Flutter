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
    final List<dynamic> fav = [];
    final extractedData = Firestore.instance
        .collection('tamilnames')
        .snapshots(); //stream<Querysnapshots>
    Firestore.instance
        .collection('userfavorites')
        .document(userId)
        .get()
        .then((doc) {
      if (doc.exists) {
        fav.addAll(doc.data['myfavnames']);
      } else {
        print('No Document found');
      }

      extractedData.forEach((snapshot) {
        print(snapshot.toString());
        snapshot.documents.map((data) {
          print('Data-->' + data.toString());
          final record = Name.fromSnapshot(data);
          record.isFavorite =
              fav == null ? false : fav.contains(record.id) ?? true;
          loadedNames.add(record);
          print('Data Fav ' +
              record.id.toString() +
              '-->' +
              record.isFavorite.toString());
        }).toList();
      });
      _items = loadedNames;

      notifyListeners();
    });
  }
}
