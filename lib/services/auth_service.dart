import 'package:firebase_auth/firebase_auth.dart';
import 'package:weighttracker/models/app_users.dart';
import 'package:weighttracker/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUsers? _firebaseUsers(User? user) {
    return user != null ? AppUsers(uid: user.uid) : null;
  }

  Stream<AppUsers?> get appUsers {
    return _auth.authStateChanges().map((User? user) => _firebaseUsers(user!));
  }

  Future signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? firebaseUser = userCredential.user;
      await DatabaseService(uid: firebaseUser!.uid)
          .updateappUsersData('new member', 0);
      return _firebaseUsers(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
