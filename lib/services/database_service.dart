import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weighttracker/models/app_users.dart';
import 'package:weighttracker/models/user_weights.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // collection
  final CollectionReference weightCollection =
      FirebaseFirestore.instance.collection('weights');

  Future<void> updateappUsersData(String name, double weight) async {
    return await weightCollection.doc(uid).set({
      'name': name,
      'weight': weight,
    });
  }

  // weight list from snapshot
  List<UserWeights> _weightListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserWeights(name: doc['name'] ?? '', weight: doc['weight'] ?? 0);
    }).toList();
  }

  // user data from snapshots
  AppUsersData _appUsersDataFromSnapshot(DocumentSnapshot snapshot) {
    return AppUsersData(
        uid: uid, name: snapshot['name'], weight: snapshot['weight']);
  }

  // get weights
  Stream<List<UserWeights>> get weights {
    return weightCollection.snapshots().map(_weightListFromSnapshot);
  }

  // get user documents
  Stream<AppUsersData> get appUsersData {
    return weightCollection.doc(uid).snapshots().map(_appUsersDataFromSnapshot);
  }
}
