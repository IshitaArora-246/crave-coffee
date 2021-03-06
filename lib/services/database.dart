import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crave_coffee/models/brew.dart';
import 'package:crave_coffee/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //Collection refernce
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brew list from snaqpshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
          name: doc.data()['name'] ?? "",
          strength: doc.data()['strength'] ?? 0,
          sugars: doc.data()['sugars'] ?? '0');
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength']);
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection
        .doc(uid)
        .snapshots()
        .map((event) => _userDataFromSnapShot(event));
  }
}
