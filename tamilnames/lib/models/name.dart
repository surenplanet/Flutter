import 'package:cloud_firestore/cloud_firestore.dart';

class Name {
  final String nameTamil;
  final String nameEnglish;
  final String meaning;
  final int likes;
  final DocumentReference reference;

  Name.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nameTamil'] != null),
        assert(map['nameEnglish'] != null),
        assert(map['meaning'] != null),
        assert(map['likes'] != null),
        nameTamil = map['nameTamil'],
        nameEnglish = map['nameEnglish'],
        meaning = map['meaning'],
        likes = map['likes'];

  Name.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "$nameTamil - $nameEnglish";
}
