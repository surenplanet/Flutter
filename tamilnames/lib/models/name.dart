import 'package:flutter/foundation.dart';

class Name {
  final String id;
  final String nameTamil;
  final String nameEnglish;
  final String meaning;
//  final int likes;
  bool isFavorite;

  Name({
    @required this.id,
    @required this.nameTamil,
    @required this.nameEnglish,
    @required this.meaning,
    this.isFavorite = false,
  });
}
