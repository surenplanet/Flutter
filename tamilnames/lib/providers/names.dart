import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './name.dart';

class Names with ChangeNotifier {
  List<Name> _items = [];

  final String authToken;
  final String userId;

  Names(this.authToken, this.userId, this._items);

  List<Name> get items {
    return [..._items];
  }

  List<Name> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Name findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetNames([bool filterByUser = false]) async {
    print('Inside fetchAndSetnames');
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url =
        'https://tamilnames-91fba.firebaseio.com/tamilnames.json?auth=$authToken&$filterString';
    print(url);
    try {
      final response = await http.get(url);
      print('Data:' + response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      url =
          'https://tamilnames-91fba.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Name> loadedNames = [];
      extractedData.forEach((prodId, prodData) {
        loadedNames.add(Name(
          id: prodId,
          nameTamil: prodData['nameTamil'],
          nameEnglish: prodData['nameEnglish'],
          meaning: prodData['meaning'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedNames;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Name name) async {
    final url =
        'https://tamilnames-91fba.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'nameTamil': name.nameTamil,
          'nameEnglish': name.nameEnglish,
          'meaning': name.meaning,
          'creatorId': userId,
        }),
      );
      final newName = Name(
        nameTamil: name.nameTamil,
        nameEnglish: name.nameEnglish,
        meaning: name.meaning,
        id: json.decode(response.body)['name'],
      );
      _items.add(newName);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Name newName) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://tamilnames-91fba.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'nameTamil': newName.nameTamil,
            'nameEnglish': newName.nameEnglish,
            'meaning': newName.meaning,
          }));
      _items[prodIndex] = newName;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://tamilnames-91fba.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }
}
