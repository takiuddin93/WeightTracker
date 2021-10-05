import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:weighttracker/screens/authentication/authenticate.dart';
import 'package:weighttracker/models/app_users.dart';
import 'package:weighttracker/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUsers?>.value(
      initialData: null,
      value: AuthService().appUsers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weight Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Authenticate(),
      ),
    );
  }
}
