import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Name with ChangeNotifier {
  final int id;
  final String nameTamil;
  final String nameEnglish;
  final String meaning;
//  final int likes;
  bool isFavorite = false;
  final DocumentReference reference;

  Name(
      {@required this.id,
      @required this.nameTamil,
      @required this.nameEnglish,
      @required this.meaning,
      this.isFavorite = false,
      this.reference = null});
  Name.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['id'] != null),
        assert(map['nameTamil'] != null),
        assert(map['nameEnglish'] != null),
        assert(map['meaning'] != null),
        id = map['id'],
        nameTamil = map['nameTamil'],
        nameEnglish = map['nameEnglish'],
        meaning = map['meaning'];

  Name.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "$nameTamil - $nameEnglish";

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();

    Firestore.instance
        .collection('userfavorites')
        .document(userId)
        .setData({"name": id})
        .then((value) => null)
        .catchError(() => _setFavValue(oldStatus));
//    final url =
//        'https://flutter-update.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
//    try {
//      final response = await http.put(
//        url,
//        body: json.encode(
//          isFavorite,
//        ),
//      );
//      if (response.statusCode >= 400) {
//        _setFavValue(oldStatus);
//      }
//    } catch (error) {
//      _setFavValue(oldStatus);
//    }
  }
}
